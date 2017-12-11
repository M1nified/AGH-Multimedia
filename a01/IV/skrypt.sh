#!/bin/bash

# 2)

ffmpeg -y -i samples/SampleVideo_1280x720_10mb.mp4 -vcodec copy -acodec libmp3lame SampleVideo_1280x720_10mb.avi

# 3)

## a)

### Video -> PNG
ffmpeg -y -i samples/SampleVideo_1280x720_10mb.mp4 SampleVideo_1280x720_10mb.mp3

### Audio only

#### Constant Bitrate Encoding (CBR):
ffmpeg -i samples/SampleVideo_1280x720_10mb.mp4 -vn \
       -acodec libmp3lame -ac 2 -ab 160k -ar 48000 \
        SampleVideo_1280x720_10mb_CBR.mp3

#### Variable Bitrate Encoding (VBR):
ffmpeg -i samples/SampleVideo_1280x720_10mb.mp4 -vn \
       -acodec libmp3lame -ac 2 -qscale:a 4 -ar 48000 \
        SampleVideo_1280x720_10mb_VBR.mp3 

## b)

### > ffmpeg -ss [start] -i in.mp4 -t [duration] -c copy out.mp4
### > -ss specifies the start time, e.g. 00:01:23.000 or 83 (in seconds)
### > -t specifies the duration of the clip (same format).
### > Recent ffmpeg also has a flag to supply the end time with -to.
### > -c copy copies the first video, audio, and subtitle bitstream from the input to the output file without re-encoding them. This won't harm the quality and make the command run within seconds.

ffmpeg -ss 10 -i samples/SampleVideo_1280x720_10mb.mp4 -t 00:00:01.000 SampleVideo_1280x720_10mb.mp4-%03d.png