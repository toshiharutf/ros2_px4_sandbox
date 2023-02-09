FROM ros:humble

ARG UID=1001
ARG GID=1001
ARG USER=ros2_dev
ARG ROS_DISTRO=humble

RUN groupadd -g $GID -o $USER
RUN useradd -u $UID -g $GID -ms /bin/bash $USER
RUN echo $USER:ros2_dev | chpasswd
RUN usermod -aG sudo $USER

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

RUN mkdir -p /home/$USER
COPY setup/ubuntu.sh /home/$USER
COPY setup/requirements.txt /home/$USER

RUN ls /home/$USER/
RUN bash -c "/home/$USER/ubuntu.sh --no-nuttx"

# Moved the installation of python requirements outside ubuntu.sh to improve flexibility in the Dockerfile
RUN python3 -m pip install -r /home/$USER/requirements.txt

# clean files
RUN rm /home/$USER/ubuntu.sh /home/$USER/requirements.txt

RUN apt update && apt install -y ros-$ROS_DISTRO-rviz2

#RUN mkdir -p /ros_custom_pkgs/src
#WORKDIR /ros_custom_pkgs

# Install micro-ros
#RUN git clone -b humble https://github.com/micro-ROS/micro_ros_setup.git src/micro_ros_setup
#RUN /bin/bash -c "source /opt/ros/$ROS_DISTRO/setup.bash && colcon build"
#RUN rosdep update
#RUN /bin/bash -c "source /opt/ros/$ROS_DISTRO/setup.bash && source install/local_setup.bash && ros2 run micro_ros_setup create_agent_ws.sh"
#RUN /bin/bash -c "source /opt/ros/$ROS_DISTRO/setup.bash && source install/local_setup.bash && ros2 run micro_ros_setup build_agent.sh"

# Install px4_msgs and px4_ros_com
#RUN git clone https://github.com/PX4/px4_msgs.git
#RUN git clone https://github.com/PX4/px4_ros_com.git src/px4_ros_com
#RUN /bin/bash -c "source /opt/ros/$ROS_DISTRO/setup.bash && colcon build"


WORKDIR /home/$USER/dev_ws
USER $USER   


# setup bashrc
RUN cp /etc/skel/.bashrc ~/
RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
