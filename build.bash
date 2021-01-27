#!/bin/bash
docker exec -it foxy /bin/bash -i -c 'source /opt/ros/foxy/setup.bash && colcon build'
