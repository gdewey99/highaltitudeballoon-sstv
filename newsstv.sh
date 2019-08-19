#!/bin/bash 
#
export SSTVDIR=/home/pi/SSTV
cd $SSTVDIR
while true {
# Set some variables
GPIO_PTT=7

# Initalize the GPIO ports 
/usr/local/bin/gpio mode $GPIO_PTT out 
/usr/local/bin/gpio write $GPIO_PTT 1

# Set volume
#amixer sset PCM 100%
#load camera module
sudo modprobe bcm2835-v4l2

####################################
### Do image capture from webcam ###
####################################
# capture image and save
#/usr/bin/fswebcam  --jpeg 95 --skip 2 -F 2 --deinterlace  --banner-colour "#10000000" --shadow --title "KD2PYB" #--crop 320x240  -d v4l2:/dev/video0 --save ${SSTVDIR}/webcam.jpg
#/usr/bin/fswebcam  --no-banner --resolution 2592x1944 --png 0  -d v4l2:/dev/video0 ${SSTVDIR}/webcam2.png

raspistill -t 1000 -ex sports --width 320 --height 256 -e png -o /image.png
raspistill -t 1000 -ex sports --width 2592 --height 1944 -e jpg -o /image.jpg
# add callsign
#mogrify -pointsize 24 -draw "text 10,40 'KD2PYB'" /image.png
convert image.png -font helvetica -fill white -stroke white -pointsize 24 -annotate +30+475 'KD2PYB' image.png



# Run program to encode webcam.jpg to webcam.wav audio file
#${SSTVDIR}/robot36
./pisstv /image.png 22050

#########################
### SWITCH ON WALKIE  ###
#########################
# PWR ON
#/usr/local/bin/gpio write $GPIO_PWR 1 
#sleep 3
# PTT ON
/usr/local/bin/gpio write $GPIO_PTT 0 
sleep .5


#
# Transmit SSTV Image
#
/usr/bin/aplay -d 0  ${SSTVDIR}/image.wav

sleep 1
/usr/local/bin/gpio write $GPIO_PTT 1
### SWITCH OFF WALKIE ###
#########################
sleep 170


#######################
### Move and Rename ###
#######################
 newname=$(date +%Y%m%d_%H%M)
 mv ${SSTVDIR}/image.png ${SSTVDIR}/pictures/lowres/$newname.png
 mv ${SSTVDIR}/image.jpg ${SSTVDIR}/pictures/highres/$newname.jpg
 rm -f ${SSTVDIR}/image.png
 rm -f ${SSTVDIR}/image.jpg

 rm -f ${SSTVDIR}/image.wav
}
