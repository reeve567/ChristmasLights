;
; ChristmasLights.asm
;

.equ STATE = $100

setup:
     ldi  R16, 0b00111100          ; pins on arduino 2,3,4,5 - lights
     out  DDRD, R16                     

     ldi  R16, 0b00000000          ; pins on arduino 9,10,11 - buttons
     out  DDRB, R16

     ldi  R16, 0
     out  PORTD, R16               ; set all of PORTD to LOW
     out  PORTB, R16               ; set all of PORTB to LOW

     ldi  R16, 1
     sts  STATE, R16

loop:
     ; get button input
     in   R16, PINB

     sbis PINB, 1
     rjmp other
     ldi  R16, 1
     sts  STATE, R16
other:
     sbis PINB, 2
     rjmp otherOne
     ldi  R16, 2
     sts  STATE, R16
otherOne:
     sbis PINB, 3
     rjmp endState
     ldi  R16, 3
     sts  STATE, R16
endState:

     ; run lights based on STATE
     lds  R16, STATE
     
     ldi  R17, 1                   ; run the first mode
     cp   R17, R16
     brne modeOne

     lds  R16, STATE

     ldi  R17, 2                   ; run the second mode
     cp   R17, R16
     brne modeTwo

     lds  R16, STATE

     ldi  R17, 3                   ; run the third mode
     cp   R17, R16
     brne modeThree

     rjmp loop

modeOne:
     call delay
     ldi  R16, 0b00101000
     out  PORTD, R16
     call delay
     ldi  R16, 0b00010100
     out  PORTD, R16

     rjmp loop

modeTwo:
     call delay
     ldi  R16, 0b00100000
     out  PORTD, R16
     call delay
     ldi  R16, 0b00010000
     out  PORTD, R16
     call delay
     ldi  R16, 0b00001000
     out  PORTD, R16
     call delay
     ldi  R16, 0b00000100
     out  PORTD, R16
          
     rjmp loop

modeThree:
     call delay
     ldi  R16, 0b00110000
     out  PORTD, R16
     call delay
     ldi  R16, 0b00001100
     out  PORTD, R16

     rjmp loop

delay:
     ldi  R20, 41
     ldi  R21, 150
     ldi  R22, 128
L1:  dec  R22
     brne L1
     dec  R21
     brne L1
     dec  R20
     brne L1

     ret