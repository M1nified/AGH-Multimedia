Michał Góra
Karol Pietruszka

# S 01 - asterisk

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
;               Zadzwon do odpowiedniego endpointu zdefiniowanego w pjsip.conf
;                                ^^ Timeout
```

## Konfiguracja endpointow / telefonow

### rport

Przy zakladanej konfiguracji Asterisk `rport` musi byc wylaczony, aby telefon otrzymywal informacje o nadchodzacych polaczeniach.

### STUN - Simple Traversal of UDP through NATs (Network Address Translation)

`STUN` rowniez musi byc wylaczony, aby uzyskac poprawna transmisje audio.

## Inne

### Dodawanie nazwy symbolicznej hosta

Plik: `/etc/hosts`.

```
[adres ip hosta] [nazwa symboliczna]
111.222.333.444 DP-SERVER
```