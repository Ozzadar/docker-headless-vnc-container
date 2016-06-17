#!/bin/bash

# Opens 10 tabs. 
# First click microphone icon on the test webpage. 
# You will see "Use your microphone" popup. Select "Allow". (1st time only)
# Select manually virtual source from Microphone setting on top right video icon in the address bar. (1st time only)
# Play some audio files into virtaul sinks.

echo "HOME: $HOME"

BINARY="./google-chrome"

DIR="/google-chrome/user"
USER_DATA_DIR="${HOME}${DIR}"
echo $USER_DATA_DIR

TEST_PAGE="https://dl.dropboxusercontent.com/u/4298998/html5/speechrecognition/GoogleDemo/speech.html"


MAX_TABS=10
COUNTER=0

while [  $COUNTER -lt $MAX_TABS ]; do
  echo "Tab ${COUNTER}"

  mkdir -p "${USER_DATA_DIR}${COUNTER}"

  $BINARY --user-data-dir="${USER_DATA_DIR}${COUNTER}" ${TEST_PAGE} &

  let COUNTER=COUNTER+1
done

