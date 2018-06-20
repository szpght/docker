#!/bin/bash
set -e

# Start dynamo on port 8000 if no args were specified
if [ "$1" == "start" ]; then
java -Djava.library.path=./DynamoDBLocal_lib -jar DynamoDBLocal.jar -port 8000
exit 0
fi

exec "$@"
