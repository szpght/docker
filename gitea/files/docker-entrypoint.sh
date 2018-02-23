#!/bin/bash
set -e

function start_postgres {
	# set up postgres directories with correct ownership
	export PGDATA=/var/lib/postgresql/data
	mkdir -p "$PGDATA"
	chmod 700 "$PGDATA"
	chown -R gitea:gitea "$PGDATA"
	chmod g+s /run/postgresql
	chown -R gitea:gitea /run/postgresql

	# Initialize the gitea database if necessary
	if [ ! -s "$PGDATA/PG_VERSION" ]; then
		eval "gosu gitea initdb"

		# Start database server internally so we can initialize using psql.
		gosu gitea pg_ctl -D "$PGDATA" \
			-o "-c listen_addresses='localhost'" \
			-w start

		# Create the gitea database
		psql=( psql -v ON_ERROR_STOP=1 --username gitea )
		"${psql[@]}" --dbname postgres <<-EOSQL
			CREATE DATABASE "gitea" ;
		EOSQL
		echo

		# Update the gitea account password (none) and privilege
		"${psql[@]}" --dbname gitea <<-EOSQL
			ALTER USER "gitea" WITH SUPERUSER ;
		EOSQL
		echo

		# Shut down the database server now that it's configured.
		gosu gitea pg_ctl -D "$PGDATA" -m fast -w stop

	fi

	# Start postgres
	gosu gitea postgres &

	echo "Waiting for postgres to start up..."
	/bin/bash -c "
		while ! psql --host=localhost --username=gitea -c ';'; do sleep 1; done;
	" >/dev/null 2>/dev/null
}

function start_sshd {
	/usr/sbin/sshd
}

function start_gitea {
	export GITEABIN=/usr/local/gitea
	export GITEADATA=/var/lib/gitea
	export GITEALOGS=/var/log/gitea

	mkdir -p "$GITEADATA"
	chmod 700 "$GITEADATA"
	chown -R gitea:gitea "$GITEADATA" "$GITEALOGS" "$GITEABIN"

	cd $GITEADATA
	exec $GITEABIN/launch.sh
}

# Start postgres, ssh and gitea if no args were supplied
if [ "$1" == "start" ]; then
	start_postgres
	start_sshd
	start_gitea
	exit 0
fi

exec "$@"
