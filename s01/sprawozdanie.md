Michał Góra   
Karol Pietruszka

# S 01 - Asterisk

## Przydatne komendy

```shell
asterisk -rvvvvv # uruchom CLI
```

```shell
CLI> core restart now
CLI> dialplan reload
CLI> pjsip show endpoints
```

## Dodawanie endpointu

W celu dodaniu nowego telefonu musimy zedydowac plik `/etc/asterisk/pjsip.conf` dodajac

```conf
[transport-udp]
type=transport
protocol=udp
bind=0.0.0.0
```

a dalej fragment odpowiadajacy bezposrednio za koncowke

```conf
[t6001]
type=endpoint
transport=transport-udp
;force_rport=no ; zakomentowane zeby dzialalo na telefonach SIP Cisco 7960
context=public
disallow=all
allow=ulaw
auth=t6001
aors=t6001

[t6001]
type=auth
auth_type=userpass
password=pass
username=t6001

[t6001]
type=aor
max_contacts=1
```

## Dodawanie rozszerzen 

Dodawanie rozszerzen wymaga edycji pliku `/etc/asterisk/extensions.conf`. Zawiera on dwa predefiniowane konteksty dotyczace ustawien: `[general]` i `[globals]`, pozostale moga miec arbitralne nazwy (odniesienia do nich znajduja sie w innych plikach, takich jak `pjsip.conf`).

### Hello World!

```conf
[public]
exten => 100,1,Goto(hello-world,s,1) 
;        ^^^ Aktywuje sie gdy dzwonimy pod numer 100
;              ^^^^^^^^^^^^^^^^^^^^^ Przekierowuje do sekcji [hello-world]

[default]

[hello-world]
exten => s,1,Answer()
same => n,Wait(1)
same => n,Playback(hello-world) ; /var/lib/asterisk/sounds
same => n,Hangup()
```

### Dodawanie nowego numeru telefonu

```conf
[public]
exten => 6001,1,Dial(PJSIP/t6001,30)
exten => 6002,1,Dial(PJSIP/t6002,30)
;        ^^^^ Numer aktywujacy rozszerzenie
;               ^^^^^^^^^^^^^^^^^^^^
;               Zadzwon do odpowiedniego endpointu
;               zdefiniowanego w pjsip.conf
;                                ^^ Timeout
```

## Konfiguracja endpointow / telefonow

### rport

Przy zakladanej konfiguracji Asterisk `rport` musi byc wylaczony, aby telefon otrzymywal informacje o nadchodzacych polaczeniach.

### STUN - Simple Traversal of UDP through NATs (Network Address Translation)

`STUN` rowniez musi byc wylaczony, aby uzyskac poprawna transmisje audio.

## Konfiguracja poczty glosowej

Najpierw w pliku `/etc/asterisk/voicemail.conf` dodajemy na koncu wpis:

```conf
[vm-demo]
8001 => 9900,[Imie i nazwisko uzytkownika],[email uzytkownika]
```

gdzie `8001` jest numerem poczty glosowej, a `9900` pinem potrzebnym do uzyskania dostepu do wiadomosci.

W kontekscie `[general]` tego pliku znajduja sie podstawowe parametry konfiguracyjne

Nastepnie edytujemy plik `/etc/asterisk/extensions.conf`. W sekcji `[public]` ponizej wpisu:

```conf
exten => 6002,1,Dial(PJSIP/t6002,30)
```

dodajemy:

```conf
exten => 6002, n, VoiceMail(8001@vm-demo, u)
exten => 6002, n, Hangup()
; odsluchiwanie wiadomosci
exten => 6600, 1, Answer(500)
exten => 6600, n, VoiceMailMain(@vm-demo)
```

zapisujemy zmiany i wykonujemy `core restart now` Asteriska.

### Odsluchiwanie poczty glosowej

 1. Zadzwon pod numer poczty glosowej: `6600`
 2. Podaj numer poczty glosowej: `8001`
 3. Podaj pin: `9900`

Powyzsze kroki odpowiadaja zapowiedziom glosowym centrali.

## Konfiguracja menu glosowego (Interactive Voice Response)

Edytujemy plik `/etc/asterisk/extensions.conf`. Na jego koncu dodajey sekcje:

```conf
[demo-menu] ; nasza nazwa menu
exten => s,1,Abswer(500)
same => n(loop),Background(basic-pbx-ivr-main) 
               ; Odtwarza basic-pbx-ivr-main.gsm
               ; zawierajacy domyslny komunikat
same => n,WaitExten()

exten => 1,1,Playback(you-entered) ; Mowi: "you entered"
same => n,SayNumber(1) ; Mowi: "one"
same => n,Goto(s,loop)

exten => 2,1,Playback(you-entered) ; Mowi: "you entered"
same => n,SayNumber(2) ; Mowi: "two"
same => n,Goto(s,loop)
```

Komunikaty mozna laczy w prosty sposob przy pomocy znaku `&` np.:

```conf
same => n(loop),Background(press-1&or&press-2)
```

Aby odtwarzac wlasny komunikat wystarczy zmienic argument polecenia `Background` na nazwe naszego pliku `.gsm`, ktory musimy wczesniej dodac do katalogu `/var/lib/asterisk/sounds/`.

## Przygotowywanie plikow dzwiekowych w formacie .gsm

1. Nagrywamy potrzebny komunikat i zapisujemy w formacie: `WAV (Microsoft) Signed 16bit PCM`; plik `.wav`
2. Za pomoca programu `sox` konwertujemy do `.gsm`

```shell
sox komunikat.wav -r 8000 -c 1 komunikat.gsm
```

3. Umieszczamy plik `.gsm` w katalogu `/var/lib/asterisk/sounds/en/` na serwerze z Asteriskiem

### Instalacja sox

```shell
sudo apt-get install sox libsox-fmt-all
```

## Inne

### Dodawanie nazwy symbolicznej hosta

Plik: `/etc/hosts`.

```
[adres ip hosta] [nazwa symboliczna]
111.222.333.444 DP-SERVER
```