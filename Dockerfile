From osrf/ros:melodic-desktop-full-bionic
LABEL maintainer="Liang Qi <qiliang72@gmail.com>"

# install necessary pkg
RUN apt update && apt install -q -y --no-install-recommends \
    wget git vim curl unzip \
    && rm -rf /var/lib/apt/lists/*

# install gtsam
RUN wget -O /gtsam.zip https://github.com/borglab/gtsam/archive/4.0.0-alpha2.zip \
    && unzip gtsam.zip \
    && cd /gtsam-4.0.0-alpha2/ \
    && mkdir build && cd build \
    && cmake .. \
    && make install

# # install lego-loam
# RUN /bin/bash -c 'mkdir -p /catkin_ws/src && cd /catkin_ws/src \
#     && git clone https://github.com/RobustFieldAutonomyLab/LeGO-LOAM.git \
#     && cd .. \
#     && source /opt/ros/melodic/setup.bash \
#     && catkin_make -j1'

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

COPY startup.sh /
ENTRYPOINT ["/startup.sh"]