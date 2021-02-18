# docker_ros2_dev 
**ROS2 developement environnement powered by docker.**

- Edit Dockerfile and change the packages you want to clone in the colcon folder.
- Build the docker container.
  ```bash
  docker build -t my/ros:app .
  ```
- Run the container (Find a fancy name)
  ```
  docker run \
  --name foxy -t -d \
  --net=host --privileged \
  my/ros:app
  ```
- You can use sshfs to mount the workspace :
  ```
  sshfs -o password_stdin -p 2222 root@localhost:/colcon_ws ./ws <<< 'root'
  ```
- To build the workspace
  - Run bash in the conmtainer
  ```
  docker exec -it foxy bash
  ```
  - To build form the host
  ```
  docker exec -it foxy /bin/bash -i -c 'colcon build'
  ```
