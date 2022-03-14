fl ../../cforth/printf.fth
fl ./rpi-gpio.fth 

fl ./mqtt-settings.fth
fl ./mqtt.fth 
fl ../../lib/ftoi.fth

: sha256  ( dst-adr src-adr src-len -- )
   sha256-open >r           ( dst-adr src-adr len  r: context )
   swap r@ sha256-update    ( dst-adr   r: context )
   r> sha256-close          ( )
;

[ifdef] libusb_init
fl usbtools.fth
fl usbdfu.fth
[then]

: banner
	." Hello" cr
;

" app.dic" save
