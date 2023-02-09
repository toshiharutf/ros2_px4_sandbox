# ros2_px4_sandbox

Based on https://gist.github.com/julianoes/adbf76408663829cd9aed8d14c88fa29

# PX4 setup

Clone PX4 repo into ros2_px4_sandbox directory (It can not set as submodule by default)

git clone git@github.com:toshiharutf/PX4-Autopilot.git

Then, initialize PX4 submodules
git submodule update --init --recursive

# Start the docker container terminals
run ./star_docker.sh

# Build and run PX4 SITL
In the PX4 folder run make px4_sitl gazebo-classic_iris


# Build micro_ros
In another terminal:

cd ros2_ws
source /opt/ros/humble/setup.bash
rosdep update
colcon build
source install/local_setup.bash
ros2 run micro_ros_setup create_agent_ws.sh
ros2 run micro_ros_setup build_agent.sh

# Start micros_ros

Start micro_ros agent with:
ros2 run micro_ros_agent micro_ros_agent udp4 --port 8888

# Start the offboard demo

In a third terminal:
ros2 launch px4_offboard offboard_position_control.launch.py

# QGroundControl
Launch QGroundControl and in the Vehicle config change COM_RCL_EXCEPT to 4 (Offboard control).
Change the Flight mode to "Offboard".
Arm the vehicle. After this, the offboard_position_control should start running.
