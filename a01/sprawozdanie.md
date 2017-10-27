Michał Góra   
Karol Pietruszka

# A 01 - ffmpeg

## Przydatne komendy

```shell
ffmpeg -formats
```

```shell
ffmpeg -codecs
```

```shell
ffmpeg -i <input_file> -f <output_format> -ac <output_channels_count> -ar <output_sample_rate> -ab <output_bitrate> -acodec <output_codec> <output_file>
```

Parametry okreslajace plik dotycza tylko i wylacznie tego (pliku), ktory znajduje sie jako pierwszy za tymi parametrami.

## Kompresja g.7xx

> a) [bitrate dla przepustowości DS0] na format wav, pcm (brak kompresji), częstotliwość próbkowania 8kHz, słowo kodowe 8 bitów bez znaku, bitrate 64kbity/s, jeden kanał

```shell
ffmpeg -i mowa.mp3 -ac 1 -f wav -ar 8000 -ab 64000 -acodec pcm_u8 a01.z2.a.mowa.wav
```

> b) [bardzo niska częstotliwość próbkowania] na format wav, pcm (brak kompresji), częstotliwośc próbkowania 1kHz, słowo kodowe 8 bitów bez znaku

```shell
ffmpeg -i mowa.mp3 -ac 1 -f wav -ar 1000 -acodec pcm_u8 a01.z2.b.mowa.wav
```

> c) [g.711 A-law] na format wav, pcm alaw, częstotliwość próbkowania 8kHz, słowo kodowe 8 bitów (z oryginalnych 16 bitów)

```shell
ffmpeg -i mowa.mp3 -ac 1 -f wav -ar 8000 -ab 8000 -acodec pcm_alaw a01.z2.c.mowa.wav
```

> d) [g.711 µ-law] na format wav, pcm mulaw, częstotliwość próbkowania 8kHz, słowo kodowe 8 bitów (z oryginalnych 16 bitów)

```shell
ffmpeg -i mowa.mp3 -ac 1 -f wav -ar 8000 -ab 8000 -acodec pcm_mulaw a01.z2.d.mowa.wav
```

> e) [g.722] na format g722, częstotliwość próbkowania 16kHz, słowo kodowe 16 bitów, bitrate 64kbity/s

```shell
ffmpeg -i mowa.mp3 -ac 1 -f g722 -ar 16000 -ab 16000 -acodec adpcm_g722 a01.z2.e.mowa.g722
```

> f) [amr] na format amr (narrowband), częstotliwość próbkowania 8Khz, jeden kanał, wszystkie dostępne bitrate (sprawdzić jakie są dostępne )

```shell
ffmpeg -i mowa.mp3 -ac 1 -f amr -ar 8000 -ab 4.74k -acodec amr_nb a01.z2.f.bitrate4740.mowa.amr
ffmpeg -i mowa.mp3 -ac 1 -f amr -ar 8000 -ab 7.95k -acodec amr_nb a01.z2.f.bitrate7950.mowa.amr
ffmpeg -i mowa.mp3 -ac 1 -f amr -ar 8000 -ab 12.2k -acodec amr_nb a01.z2.f.bitrate12200.mowa.amr
```

> Amr supports only 8000Hz sample rate and 4.75k, 5.15k, 5.9k, 6.7k, 7.4k, 7.95k, 10.2k or 12.2k bit rates:

W przypadku plikow `wav` wystepowal problem z ich odtwarzaniem za pomoca `VLC`, dzialal za to `Windows Media Player`.

## Kompresja mp3

### 1 - VBR

> 1) [VBR] Skompresować przykładowe pliki dźwiękowe (mowa, muzyka) z wykorzystaniem kodeka MP3 w trybie VBR. Porównać rozmiary plików oryginalnych i po kompresji oraz odsłuchowo sprawdzić jakość otrzymanych rezultatów. Należy przetestować efekty dla co najmniej 3 różnych wartości parametru określającego jakość kompresji.

```shell
# v1:
ffmpeg -i mowa.mp3 -y -ac 1 -f mp3 -acodec mp3 -q:a 0 a01.z3.1.v1.q0.mowa.mp3
ffmpeg -i mowa.mp3 -y -ac 1 -f mp3 -acodec mp3 -q:a 4 a01.z3.1.v1.q4.mowa.mp3
ffmpeg -i mowa.mp3 -y -ac 1 -f mp3 -acodec mp3 -q:a 9 a01.z3.1.v1.q9.mowa.mp3

# v2:
ffmpeg -i mowa.mp3 -y -ac 1 -f mp3 -codec:a libmp3lame -qscale:a 0 a01.z3.1.v2.quality0.mowa.mp3
ffmpeg -i mowa.mp3 -y -ac 1 -f mp3 -codec:a libmp3lame -qscale:a 4 a01.z3.1.v2.quality4.mowa.mp3
ffmpeg -i mowa.mp3 -y -ac 1 -f mp3 -codec:a libmp3lame -qscale:a 9 a01.z3.1.v2.quality9.mowa.mp3
```

### 2 - CBR

> 2) [CBR] Skompresować przykładowe pliki dźwiękowe (mowa, muzyka) z wykorzystaniem kodeka MP3 w trybie CBR. Porównać rozmiary plików oryginalnych i po kompresji oraz odsłuchowo sprawdzić jakość otrzymanych rezultatów. Sprawdzić jaki najniższy bitrate można osiągnąć i jaka jest jakość po kompresji.

Minimalny uzyskany bitrate to 32kbps, nawet pomimio mozliwosci podanie mniejszej wartosci jako argumentu.

```shell
# v1:
ffmpeg -i mowa.mp3 -y -ac 1 -f mp3 -acodec mp3 -b:a 8k a01.z3.2.v1.8k.mowa.mp3
ffmpeg -i mowa.mp3 -y -ac 1 -f mp3 -acodec mp3 -b:a 128k a01.z3.2.v1.128k.mowa.mp3
ffmpeg -i mowa.mp3 -y -ac 1 -f mp3 -acodec mp3 -b:a 320k a01.z3.2.v1.320k.mowa.mp3

# v2:
ffmpeg -i mowa.mp3 -y -ac 1 -f mp3 -codec:a libmp3lame -b:a 8k a01.z3.2.v2.br8k.mowa.mp3
ffmpeg -i mowa.mp3 -y -ac 1 -f mp3 -codec:a libmp3lame -b:a 128k a01.z3.2.v2.br128k.mowa.mp3
ffmpeg -i mowa.mp3 -y -ac 1 -f mp3 -codec:a libmp3lame -b:a 320k a01.z3.2.v2.br320k.mowa.mp3
```

### 3 - CBR - lame

> 3) [CBR niski bitrate] Jeśli chcemy uzyskać niższy CBR niż przy użyciu samego programu ffmpeg. Konieczne jest bezpośrednie skorzystanie z programu lame. Można to zrobić wywołując w potoku programy ffmpeg i lame:
> ```shell
> ffmpeg -i [plik źródłowy] -f wav - | lame --cbr -b 8 - out.mp3
> ```

```shell
ffmpeg -i muzyka.mp3 -y -ac 1 -f wav - | lame --cbr -b 8 - a01.z3.3.b8k.muzyka.mp3
ffmpeg -i muzyka.mp3 -y -ac 1 -f wav - | lame --cbr -b 160 - a01.z3.3.b160k.muzyka.mp3
ffmpeg -i muzyka.mp3 -y -ac 1 -f wav - | lame --cbr -b 320 - a01.z3.3.b320k.muzyka.mp3
```