FROM ros:foxy

WORKDIR colcon_ws

# System packages
RUN apt-get update && apt install -y -qq iproute2 netcat openssh-server rsync gdb
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
RUN sed -i '/UsePAM yes/d' /etc/ssh/sshd_config > /dev/null
RUN echo 'root:root' | chpasswd
RUN service ssh restart

# Cloning packages
RUN mkdir src
RUN git clone https://github.com/ros-drivers/ros2_ouster_drivers.git src/ros2_ouster_drivers
RUN git clone https://github.com/ouster-lidar/ouster_example.git src/.ouster_example

# Install deps
RUN . /opt/ros/$ROS_DISTRO/setup.sh && \
    export DEBIAN_FRONTEND=noninteractive && \
    rosdep install -y -qq \
      --from-paths src \
      --ignore-src

# Building packages
RUN . /opt/ros/$ROS_DISTRO/setup.sh && colcon build --symlink-install && . install/setup.sh 

# Clean
RUN rm -rf /var/lib/apt/lists/*

ENTRYPOINT service ssh restart && /bin/bash
