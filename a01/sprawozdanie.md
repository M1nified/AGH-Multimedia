Michał Góra
Karol Pietruszka

# A 01 - ffmpeg

## Przydatne komendy

```
ffmpeg -formats
```

```
ffmpeg -codecs
```

```
ffmpeg -i <input_file> -f <output_format> -ac <output_channels_count> -ar <output_sample_rate> -ab <output_bitrate> -acodec <output_codec> <output_file>
```

## Kompresja g.7xx

> a) [bitrate dla przepustowości DS0] na format wav, pcm (brak kompresji), częstotliwość próbkowania 8kHz, słowo kodowe 8 bitów bez znaku, bitrate 64kbity/s, jeden kanał

```
ffmpeg -i mowa.mp3 -ac 1 -f wav -ar 8000 -ab 64000 -acodec pcm_u8 a01.z2.a.mowa.wav
```

> b) [bardzo niska częstotliwość próbkowania] na format wav, pcm (brak kompresji), częstotliwośc próbkowania 1kHz, słowo kodowe 8 bitów bez znaku

```
ffmpeg -i mowa.mp3 -ac 1 -f wav -ar 1000 -acodec pcm_u8 a01.z2.b.mowa.wav
```

> c) [g.711 A-law] na format wav, pcm alaw, częstotliwość próbkowania 8kHz, słowo kodowe 8 bitów (z oryginalnych 16 bitów)

```
ffmpeg -i mowa.mp3 -ac 1 -f wav -ar 8000 -ab 8000 -acodec pcm_alaw a01.z2.c.mowa.wav
```

> d) [g.711 µ-law] na format wav, pcm mulaw, częstotliwość próbkowania 8kHz, słowo kodowe 8 bitów (z oryginalnych 16 bitów)

```
ffmpeg -i mowa.mp3 -ac 1 -f wav -ar 8000 -ab 8000 -acodec pcm_mulaw a01.z2.d.mowa.wav
```

> e) [g.722] na format g722, częstotliwość próbkowania 16kHz, słowo kodowe 16 bitów, bitrate 64kbity/s

```
ffmpeg -i mowa.mp3 -ac 1 -f g722 -ar 16000 -ab 16000 -acodec adpcm_g722 a01.z2.e.mowa.g722
```

> f) [amr] na format amr (narrowband), częstotliwość próbkowania 8Khz, jeden kanał, wszystkie dostępne bitrate (sprawdzić jakie są dostępne )

```
ffmpeg -i mowa.mp3 -ac 1 -f amr -ar 8000 -ab 4.74k -acodec amr_nb a01.z2.f.bitrate4740.mowa.amr
ffmpeg -i mowa.mp3 -ac 1 -f amr -ar 8000 -ab 7.95k -acodec amr_nb a01.z2.f.bitrate7950.mowa.amr
ffmpeg -i mowa.mp3 -ac 1 -f amr -ar 8000 -ab 12.2k -acodec amr_nb a01.z2.f.bitrate12200.mowa.amr
```

> Amr supports only 8000Hz sample rate and 4.75k, 5.15k, 5.9k, 6.7k, 7.4k, 7.95k, 10.2k or 12.2k bit rates:

W przypadku plikow `wav` wystepowal problem z ich odtwarzaniem za pomoca `VLC`, dzialal za to `Windows Media Player`.