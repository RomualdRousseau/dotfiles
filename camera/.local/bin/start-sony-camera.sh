#!/bin/sh
sudo modprobe v4l2loopback exclusive_caps=1 max_buffers=2
sleep 1
gphoto2 --stdout --capture-movie | ffmpeg -i - -vcodec rawvideo -pix_fmt yuv420p -threads 8 -f v4l2 /dev/video2
