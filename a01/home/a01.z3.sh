# 1)

ffmpeg -i mowa.mp3 -f mp3 -ac 1 -acodec mp3 -q:a 2 a01.z3.1.mowa.mp3

# 2)

ffmpeg -i mowa.mp3 -f mp3 -ac 1 -acodec mp3 -b:a 320k 2 a01.z3.2.320k.mowa.mp3

# 3)

ffmpeg -i muzyka.mp3 -f wav - | lame --cbr -b 320 - a01.z3.3.b320.muzyka.mp3