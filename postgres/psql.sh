#!/bin/bash

docker run -it --link postgres --rm brett/postgres \
	sh -c 'exec psql -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U postgres'
