sudo xhost +local:root

docker restart tk_ENV1
docker exec -ti -e COLUMNS=$COLUMNS -e LINES=$LINES -e TERM=$TERM -e LC_ALL=C.UTF-8 tk_ENV1 bash
#docker exec -ti -e COLUMNS=$COLUMNS -e LINES=$LINES -e TERM=$TERM -e LC_ALL=C.UTF-8 -u tkay tk_ENV1 bash

