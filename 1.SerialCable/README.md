# KC-YCDI

![Keep calm, You can do it](KC-YCDI.png)

This is the most tricky part of the guide, but you will understand the benefit and the skill you learnt at the end of the procedure.

## You need:
1. to disassemble your device
2. get access to the serial pins
3. solder 3 dupont cables
4. connect the serial to another device; I used a Rasperry PI with a "USB to UART" [^1] serial adapter.

## Disassemble your device

There are no specific instruction, here. You just need some patience and unscrew it.
In My device there are just 4 main screws:
+ 2 visible on top near the disk enclosure
+ 2 on the base, accessible after you remove the plastic cover

Then you need to unscrew the metal chassis and to get access to the board.

## Get access to the serial pins

The board has a space dedicated to the serial connection. See this picture:
![Bottom side of the board](Bottom.jpg)

Should your board be different, WD adopt the convention of keeping the same drawing for the serial connection.

If you are unsecure about which is the right pint, continue to the next step with the soldering and then you can try to connect to the _USB to UART_ device.
If you used a powered _USB to UART_ you can avoid to solder and connect the +3.3V; as these are TTL signals there is no risk you can burn the serial circuits in case of wrong connection of the other 3 pins (GND, Tx and Rx).

## Solder 3 dupont cables

Yes, you need it :roll_eyes:

The simplest tip is to use 3 dupont cable (_male to male_ or _male to female_ ~10 cm).
You shall put the male end in the small hole and then put the tin and solder on it; wait few second the tin is meld and remove the solder blowing as much as you can : )
One tip; before putting the male pin, you can use pliers and give it a "L form"; in thiw ways, you can have the wire laying parallel to the board and just the pin endpoint entering the hole. You will gain stability during the soldering and furthermore you can leave the dupont cable also after reassembling the device.
Just sold the GND, the TX and the RX pins; there no need to solder also the +3.3 V (assuming your _USB to UART_ is powered).

## Connect the serial to your PC

Assuming your setup is:
+ (WDMY + dupont cable)
+ "USB to UART"
+ Raspberry PI
proceed  in this way

### 1. Connect the "USB to UART" to your Raspberry

With `dmesg` you should see a new tty device available. this should be visible in the /dev folder with something like `/dev/ttyUSB0`
```
kernel: [   17.620214] usbcore: registered new interface driver ch341
kernel: [   17.620303] usbserial: USB Serial support registered for ch341-uart
kernel: [   17.620465] ch341 1-1.4:1.0: ch341-uart converter detected
kernel: [   17.626101] ch341-uart ttyUSB0: break control not supported, using simulated break
kernel: [   17.626450] usb 1-1.4: ch341-uart converter now attached to *ttyUSB0*
```

Start a serial program like `minicom` or `putty`.
If needed, configure the serial program to use ONLY SW flow control as you are not using CTS & RTS.
For example with `minicom -s`:
```
+-----------------------------------------------------------------------+
| A -    Serial Device      : /dev/ttyUSB0                              |
| B - Lockfile Location     : /var/lock                                 |
| C -   Callin Program      :                                           |
| D -  Callout Program      :                                           |
| E -    Bps/Par/Bits       : 115200 8N1                                |
| F - Hardware Flow Control : No                                        |
| G - Software Flow Control : Yes                                       |
| H -     RS485 Enable      : No                                        |
| I -   RS485 Rts On Send   : No                                        |
| J -  RS485 Rts After Send : No                                        |
| K -  RS485 Rx During Tx   : No                                        |
| L -  RS485 Terminate Bus  : No                                        |
| M - RS485 Delay Rts Before: 0                                         |
| N - RS485 Delay Rts After : 0                                         |
|                                                                       |
|    Change which setting?                                              |
+-----------------------------------------------------------------------+
```
Start `minicom` and wait the first signal is received

### 2. Connect the "USB to UART" to dupont cables

The connection is quite simple:
```
GND <-> GND
Tx  <-> Rx
Rx  <-> Tx
```

Should you have a different board and you need to discover the pins, use this consideratins:
+ find GND at first; using a mutlimeter you should be able to recognise as it is short-cirtui with other pins or part, like chassis; moreover the GND has a stable reference w.r.t. the +3.3V pin (the fourth one you have not soldered)
+ cycle the WD power off/on; during the boot sequence, the Tx should be `high` ~3V and Rx ~0V. 
+ connect the _WD Tx_ to the RX _USB to UART_; if the connection is fine, you should see a blikning led on the _USB to UART_
+ last connection is the Rx->Tx

### 3. Power ON the WD MC and check the connection

The WD MC is able to boot and load linux without any device connected.
If everything is fine, here you should be able to login on your Device as you would be with an ssh connection.

[^1]: Just google _UST to UART_ on google or amazon
[Example 1](https://www.amazon.de/-/en/Mountaineer-CP2104-USB-Module-Converter-Compatible/dp/B01CYBHM26/ref=sr_1_3?crid=38G2KJ58ADXYF&keywords=usb%2Bauf%2Buart&qid=1648975046&sprefix=usb%2Bto%2Buart%2Caps%2C82&sr=8-3&th=1)
[Example 1](https://www.amazon.de/-/en/gp/product/B089YTXK8V/ref=ppx_yo_dt_b_search_asin_title?ie=UTF8&psc=1)
