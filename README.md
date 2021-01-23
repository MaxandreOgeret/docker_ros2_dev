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
  sshfs root@localhost:/colcon_ws ./ws
  ```
- To build the workspace
  - Run bash in the conmtainer
  ```
  docker exec -it foxy bash
  ```
  - Navigate to the ws and build it.
  ```
  cd colcon_ws
  colcon build
  ```
