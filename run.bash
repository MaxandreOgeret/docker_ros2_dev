#!/bin/bash
docker exec -it foxy /bin/bash -i -c 'source install/setup.bash && ros2 launch ros2_ouster os1_launch.py'
