# docker_ros2_dev 
**ROS2 developement environnement powered by docker.**

- Edit Dockerfile and change the packages you want to clone in the colcon folder.
- Build the docker container.
  ```bash
  docker build -t my/ros:app .
  ```
- Run the container (Find a fancy name)
  ```bash
  docker run \
  --name ros-dev -t -d \
  --net=host --privileged \
  my/ros:app
  ```
- You can use sshfs to mount the workspace :

  ```bash
  sshfs -o password_stdin -p 2222 root@localhost:/colcon_ws ./ws <<< 'root'
  ```
- To build the workspace
  - Run bash in the container and build with colcon.

  ```bash
  # From the host
  docker exec -it ros-dev bash
  ```

  ```bash
  # In the container
  colcon build
  ```

  - To build directly from the host

  ```bash
  docker exec -it ros-dev /bin/bash -i -c 'colcon build'
  ```
