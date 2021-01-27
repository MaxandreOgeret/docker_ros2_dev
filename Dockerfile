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
RUN git clone https://github.com/MaxandreOgeret/ros2_simple_ouster_driver.git src/ && cd src && git checkout foxy_devel

# Install deps
RUN . /opt/ros/$ROS_DISTRO/setup.sh && \
  rosdep update && \
  rosdep install --from-paths src --ignore-src -r -y

# Building packages
RUN pwd && . /opt/ros/$ROS_DISTRO/setup.sh && colcon build --symlink-install && . install/setup.sh 

# Clean
RUN rm -rf /var/lib/apt/lists/*

ENTRYPOINT service ssh restart && /bin/bash
