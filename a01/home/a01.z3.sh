# 1)

# v1:
ffmpeg -i mowa.mp3 -y -ac 1 -f mp3 -acodec mp3 -q:a 0 a01.z3.1.v1.mowa.mp3
ffmpeg -i mowa.mp3 -y -ac 1 -f mp3 -acodec mp3 -q:a 4 a01.z3.1.v1.mowa.mp3
ffmpeg -i mowa.mp3 -y -ac 1 -f mp3 -acodec mp3 -q:a 9 a01.z3.1.v1.mowa.mp3

ffmpeg -i muzyka.mp3 -y -ac 1 -f mp3 -acodec mp3 -q:a 0 a01.z3.1.v1.muzyka.mp3
ffmpeg -i muzyka.mp3 -y -ac 1 -f mp3 -acodec mp3 -q:a 4 a01.z3.1.v1.muzyka.mp3
ffmpeg -i muzyka.mp3 -y -ac 1 -f mp3 -acodec mp3 -q:a 9 a01.z3.1.v1.muzyka.mp3

# v2:
ffmpeg -i mowa.mp3 -y -ac 1 -codec:a libmp3lame -qscale:a 0 a01.z3.1.v2.quality0.mowa.mp3
ffmpeg -i mowa.mp3 -y -ac 1 -codec:a libmp3lame -qscale:a 4 a01.z3.1.v2.quality4.mowa.mp3
ffmpeg -i mowa.mp3 -y -ac 1 -codec:a libmp3lame -qscale:a 9 a01.z3.1.v2.quality9.mowa.mp3

ffmpeg -i muzyka.mp3 -y -ac 1 -codec:a libmp3lame -qscale:a 0 a01.z3.1.v2.quality0.muzyka.mp3
ffmpeg -i muzyka.mp3 -y -ac 1 -codec:a libmp3lame -qscale:a 4 a01.z3.1.v2.quality4.muzyka.mp3
ffmpeg -i muzyka.mp3 -y -ac 1 -codec:a libmp3lame -qscale:a 9 a01.z3.1.v2.quality9.muzyka.mp3

# 2)

# v1:
ffmpeg -i mowa.mp3 -y -ac 1 -f mp3 -acodec mp3 -b:a 8k 2 a01.z3.2.8k.mowa.mp3
ffmpeg -i mowa.mp3 -y -ac 1 -f mp3 -acodec mp3 -b:a 128k 2 a01.z3.2.128k.mowa.mp3
ffmpeg -i mowa.mp3 -y -ac 1 -f mp3 -acodec mp3 -b:a 320k 2 a01.z3.2.320k.mowa.mp3

ffmpeg -i muzyka.mp3 -y -ac 1 -f mp3 -acodec mp3 -b:a 8k 2 a01.z3.2.8k.muzyka.mp3
ffmpeg -i muzyka.mp3 -y -ac 1 -f mp3 -acodec mp3 -b:a 128k 2 a01.z3.2.128k.muzyka.mp3
ffmpeg -i muzyka.mp3 -y -ac 1 -f mp3 -acodec mp3 -b:a 320k 2 a01.z3.2.320k.muzyka.mp3

# v2:
ffmpeg -i mowa.mp3 -y -ac 1 -codec:a libmp3lame -b:a 8k a01.z3.2.v2.br8k.mowa.mp3
ffmpeg -i mowa.mp3 -y -ac 1 -codec:a libmp3lame -b:a 128k a01.z3.2.v2.br128k.mowa.mp3
ffmpeg -i mowa.mp3 -y -ac 1 -codec:a libmp3lame -b:a 320k a01.z3.2.v2.br320k.mowa.mp3

ffmpeg -i muzyka.mp3 -y -ac 1 -codec:a libmp3lame -b:a 8k a01.z3.2.v2.br8k.muzyka.mp3
ffmpeg -i muzyka.mp3 -y -ac 1 -codec:a libmp3lame -b:a 128k a01.z3.2.v2.br128k.muzyka.mp3
ffmpeg -i muzyka.mp3 -y -ac 1 -codec:a libmp3lame -b:a 320k a01.z3.2.v2.br320k.muzyka.mp3

# 3)

ffmpeg -i muzyka.mp3 -y -ac 1 -f wav - | lame --cbr -b 8 - a01.z3.3.b8k.muzyka.mp3
ffmpeg -i muzyka.mp3 -y -ac 1 -f wav - | lame --cbr -b 160 - a01.z3.3.b160k.muzyka.mp3
ffmpeg -i muzyka.mp3 -y -ac 1 -f wav - | lame --cbr -b 320 - a01.z3.3.b320k.muzyka.mp3