sudo gnome-terminal -- bash -c "./docker/run_px4_humble.sh"
gnome-terminal --tab -- bash -c "docker exec -it px4-ros-humble /bin/bash"
gnome-terminal --tab -- bash -c "docker exec -it px4-ros-humble /bin/bash"
