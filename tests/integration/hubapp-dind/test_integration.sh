set -e

if [ "${PWD##*/}" != "jina" ]
  then
    echo "test_integration.sh should only be run from the jina base directory"
    exit 1
fi

CONTAINER_ID=$(docker run -v /var/run/docker.sock:/var/run/docker.sock -d jinaai/test_hubapp_dind)

sleep 5

RESPONSE=$(curl --request POST -d '{"top_k": 10, "data": ["text:hey, dude"]}' -H 'Content-Type: application/json' '0.0.0.0:45678/api/index')
echo "Response is: ${RESPONSE}"

docker rm -f $CONTAINER_ID

# perform some checks here