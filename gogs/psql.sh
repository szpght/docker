#!/bin/bash

docker exec -it gogs psql -h localhost -p 5432 --username gogs --dbname gogs
