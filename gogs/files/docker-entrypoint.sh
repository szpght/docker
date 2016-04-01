#!/bin/bash
set -e

function start_postgres {
	# set up postgres directories with correct ownership
	export PGDATA=/var/lib/postgresql/data
	mkdir -p "$PGDATA"
	chmod 700 "$PGDATA"
	chown -R gogs:gogs "$PGDATA"
	chmod g+s /run/postgresql
	chown -R gogs:gogs /run/postgresql

	# Initialize the gogs database if necessary
	if [ ! -s "$PGDATA/PG_VERSION" ]; then
		eval "gosu gogs initdb"

		# Start database server internally so we can initialize using psql.
		gosu gogs pg_ctl -D "$PGDATA" \
			-o "-c listen_addresses='localhost'" \
			-w start

		# Create the gogs database
		psql=( psql -v ON_ERROR_STOP=1 --username gogs )
		"${psql[@]}" --dbname postgres <<-EOSQL
			CREATE DATABASE "gogs" ;
		EOSQL
		echo

		# Update the gogs account password (none) and privilege
		"${psql[@]}" --dbname gogs <<-EOSQL
			ALTER USER "gogs" WITH SUPERUSER ;
		EOSQL
		echo

		# Shut down the database server now that it's configured.
		gosu gogs pg_ctl -D "$PGDATA" -m fast -w stop

	fi

	# Start postgres
	gosu gogs postgres &

	echo "Waiting for postgres to start up..."
	/bin/bash -c "
		while ! psql --host=localhost --username=gogs -c ';'; do sleep 1; done;
	" >/dev/null 2>/dev/null
}

function start_gogs {
	export GOGSBIN=/usr/local/gogs
	export GOGSDATA=/var/lib/gogs
	export GOGSLOGS=/var/log/gogs

	mkdir -p "$GOGSDATA"
	chmod 700 "$GOGSDATA"
	chown -R gogs:gogs "$GOGSDATA" "$GOGSLOGS" "/usr/local/gogs"

	cd $GOGSDATA
	exec $GOGSBIN/launch.sh
}

# Start postgres, ssh and gogs if no args were supplied
if [ "$1" == "start" ]; then
	start_postgres
	start_gogs
	exit 0
fi

exec "$@"
