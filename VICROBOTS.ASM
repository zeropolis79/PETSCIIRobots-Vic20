;PETSCII Robots (VIC-20 version)
;by David Murray 2020
;dfwgreencars@gmail.com

!to "vicrobots",cbm

*=$1201		;START ADDRESS IS $1201
DESTRUCT_PATH	=$A000	;Destruct path array (256 bytes)
TILE_ATTRIB	=$A100	;Tile attrib array (256 bytes)
TILE_DATA_TL	=$A200	;Tile character top-left (256 bytes)
TILE_DATA_TM	=$A300	;Tile character top-middle (256 bytes)
TILE_DATA_TR	=$A400	;Tile character top-right (256 bytes)
TILE_DATA_ML	=$A500	;Tile character middle-left (256 bytes)
TILE_DATA_MM	=$A600	;Tile character middle-middle (256 bytes)
TILE_DATA_MR	=$A700	;Tile character middle-right (256 bytes)
TILE_DATA_BL	=$A800	;Tile character bottom-left (256 bytes)
TILE_DATA_BM	=$A900	;Tile character bottom-middle (256 bytes)
TILE_DATA_BR	=$AA00	;Tile character bottom-right (256 bytes)
TILE_COLOR_TL	=$AB00	;Tile color top-left (256 bytes) (C64/VIC/TED VERSION ONLY)
TILE_COLOR_TM	=$AC00	;Tile color top-middle (256 bytes) (C64/VIC/TED VERSION ONLY)
TILE_COLOR_TR	=$AD00	;Tile color top-right (256 bytes) (C64/VIC/TED VERSION ONLY)
TILE_COLOR_ML	=$AE00	;Tile color middle-left (256 bytes) (C64/VIC/TED VERSION ONLY)
TILE_COLOR_MM	=$AF00	;Tile color middle-middle (256 bytes) (C64/VIC/TED VERSION ONLY)
TILE_COLOR_MR	=$B000	;Tile color middle-right (256 bytes) (C64/VIC/TED VERSION ONLY)
TILE_COLOR_BL	=$B100	;Tile color bottom-left (256 bytes) (C64/VIC/TED VERSION ONLY)
TILE_COLOR_BM	=$B200	;Tile color bottom-middle (256 bytes) (C64/VIC/TED VERSION ONLY)
TILE_COLOR_BR	=$B300	;Tile color bottom-right (256 bytes) (C64/VIC/TED VERSION ONLY)
PEST_SOUND	=$0400	;Sound system base address
PLAY_SOUND	=$0415	;play sound effect

;***These arrays can go anywhere in RAM***
UNIT_TIMER_A	=$0E00	;Primary timer for units (64 bytes)
UNIT_TIMER_B	=$0E40	;Secondary timer for units (64 bytes)
UNIT_TILE	=$0E80	;Current tile assigned to unit (32 bytes)
;UNIT_ALT_MOVE	=$0EA0	;For moving around objects (32 bytes)
;UNIT_DEST_X	=$0EC0	;Destination X coordinate (32 bytes)
;UNIT_DEST_Y	=$0EE0	;Destination X coordinate (32 bytes)
EXP_BUFFER	=$0F00	;Explosion Buffer (16 bytes)
MAP_PRECALC	=$0F10	;Stores pre-calculated objects for map window (49 bytes)
;The following addresses are used to store the current 
;state of the SNES buttons.
SNES_B		=$0F41
SNES_Y		=$0F42
SNES_SELECT	=$0F43
SNES_START	=$0F44
SNES_UP		=$0F45
SNES_DOWN	=$0F46
SNES_LEFT	=$0F47
SNES_RIGHT	=$0F48
SNES_A		=$0F49
SNES_X		=$0F4A
SNES_BACK_L	=$0F4B
SNES_BACK_R	=$0F4C
;The following addresses are used to store the last
;state of the SNES buttons so that we can determine
;if a button was released.
LAST_B		=$0F4D
LAST_Y		=$0F4E
LAST_SELECT	=$0F4F
LAST_START	=$0F50
LAST_UP		=$0F51
LAST_DOWN	=$0F52
LAST_LEFT	=$0F53
LAST_RIGHT	=$0F54
LAST_A		=$0F55
LAST_X		=$0F56
LAST_BACK_L	=$0F57
LAST_BACK_R	=$0F58

;The following addresses are used to store new
;presses of the SNES buttons.  Once they are set
;as a 1, it requires the game to reset them to
;0 when it is ready to be read again.
NEW_B		=$0F59
NEW_Y		=$0F5A
NEW_SELECT	=$0F5B
NEW_START	=$0F5C
NEW_UP		=$0F5D
NEW_DOWN	=$0F5E
NEW_LEFT	=$0F5F
NEW_RIGHT	=$0F60
NEW_A		=$0F61
NEW_X		=$0F62
NEW_BACK_L	=$0F63
NEW_BACK_R	=$0F64

;The following are the locations where the current
;key controls are stored.  These must be set before
;the game can start.
KEY_MOVE_UP		=$0F65
KEY_MOVE_DOWN		=$0F66
KEY_MOVE_LEFT		=$0F67
KEY_MOVE_RIGHT		=$0F68
KEY_FIRE_UP		=$0F69
KEY_FIRE_DOWN		=$0F6A
KEY_FIRE_LEFT		=$0F6B
KEY_FIRE_RIGHT		=$0F6C
KEY_CYCLE_WEAPONS	=$0F6D
KEY_CYCLE_ITEMS		=$0F6E
KEY_USE			=$0F6F
KEY_SEARCH		=$0F70
KEY_MOVE		=$0F71

;***MAP FILES CONSIST OF EVERYTHING FROM THIS POINT ON***
UNIT_TYPE	=$5D00	;Unit type 0=none (64 bytes)	
UNIT_LOC_X	=$5D40	;Unit X location (64 bytes)
UNIT_LOC_Y	=$5D80	;Unit X location (64 bytes)
UNIT_A		=$5DC0	
UNIT_B		=$5E00
UNIT_C		=$5E40
UNIT_D		=$5E80
UNIT_HEALTH	=$5EC0	;Unit health (0 to 11) (64 bytes)
MAP		=$6000	;Location of MAP (8K)
;***END OF MAP FILE***

;*** Zero Page locations used ***
TILE		=$23	;The tile number to be plotted
TEMP_X		=$24	;Temporarily used for loops
TEMP_Y		=$25	;Temporarily used for loops
MAP_X		=$26	;Current X location on map
MAP_Y		=$27	;Current Y location on map
MAP_WINDOW_X	=$28	;Top left location of what is displayed in map window
MAP_WINDOW_Y	=$29	;Top left location of what is displayed in map window
DECNUM		=$2A	;a decimal number to be displayed onscreen as 3 digits.
ATTRIB		=$2B	;Tile attribute value
UNIT		=$2C	;Current unit being processed
TEMP_A		=$2D	;used within some routines
TEMP_B		=$2E	;used within some routines
TEMP_C		=$2F	;used within some routines
TEMP_D		=$30	;used within some routines
CURSOR_X	=$31	;For on-screen cursor
CURSOR_Y	=$32	;For on-screen cursor
CURSOR_ON	=$33	;Is cursor active or not? 1=yes 0=no
REDRAW_WINDOW	=$34	;1=yes 0=no
MOVE_RESULT	=$35	;1=Move request success, 0=fail.
UNIT_FIND	=$36	;255=no unit present.
MOVE_TYPE	=$37	;%00000001=WALK %00000010=HOVER
SCREEN_SHAKE 	=$38	;0=NO 1=YES
PRECALC_COUNT	=$39	;part of screen draw routine

BASIC	!BYTE $0C,$12,$01,$00,$9E,$20,$34,$36,$32,$32,$00,$00,$00
	;Adds BASIC line:  1 SYS 4622
	JMP	$1272	

*=$1272		;Must leave padding for video RAM at $1000-$1271
	LDA	#%00101000	;Pins 3 & 5 are output
	STA	$9112		;Data-direction-register for userport
	LDA	#$0E		;black with blue border
	STA	$900F		;set fore/background
	LDA	#$80
	STA	$0291	;Disable character set switching
	LDA	#$15
	STA	$D018	;enable upper-case character set
	JSR	DISPLAY_LOAD_MESSAGE1
	JSR	TILE_LOAD_ROUTINE
	JSR	SOUND_LOAD_ROUTINE
	LDA	#0
	STA	SCREEN_SHAKE
	JSR	SETUP_INTERRUPT
	JSR	SET_CONTROLS	;copy initial key controls
	JSR	PEST_SOUND	;INIT SOUNND ROUTINE
	JSR	SET_SCREEN_SIZE
	JMP	INTRO_SCREEN
INIT_GAME:
	LDA	#0
	STA	SCREEN_SHAKE
	JSR	DISPLAY_GAME_SCREEN
	JSR	DISPLAY_LOAD_MESSAGE2
	JSR	RESET_KEYS_AMMO
	JSR	MAP_LOAD_ROUTINE
	JSR	SET_DIFF_LEVEL
	JSR	ANIMATE_PLAYER
	JSR	CACULATE_AND_REDRAW
	JSR	DRAW_MAP_WINDOW
	JSR	DISPLAY_PLAYER_HEALTH
	JSR	DISPLAY_KEYS
	JSR	DISPLAY_WEAPON
	LDA	#1
	STA	UNIT_TYPE
	LDA	#97
	STA	UNIT_TILE
	JSR	SET_INITIAL_TIMERS
	JSR	PRINT_INTRO_MESSAGE
	LDA	#30
	STA	KEYTIMER
	JMP	MAIN_GAME_LOOP

TILENAME  	!PET"tileset.vic"
MAPNAME  	!PET"level-a"
SNDNAME  	!PET"pdrv-vic"
MUSICNAME  	!PET"music0.vic"
LOADMSG1	!PET 5,"loading tiles...",13
KEYS		!BYTE 	00	;bit 0=spade bit2=heart bit3=star
AMMO_PISTOL	!BYTE	00	;how much ammo for the pistol
AMMO_PLASMA	!BYTE	00	;how many shots of the plasmagun
INV_BOMBS	!BYTE	00	;How many bombs do we have
INV_EMP		!BYTE	00	;How many EMPs do we have
INV_MEDKIT	!BYTE	00	;How many medkits do we have?
INV_MAGNET	!BYTE	00	;How many magnets do we have?
SELECTED_WEAPON	!BYTE	00	;0=none 1=pistol 2=plasmagun
SELECTED_ITEM	!BYTE	00	;0=none 1=bomb 2=emp 3=medkit
ANIMATE		!BYTE 	01	;0=DISABLED 1=ENABLED
BIG_EXP_ACT	!BYTE	00	;0=No explosion active 1=big explosion active
MAGNET_ACT	!BYTE	00	;0=no magnet active 1=magnet active
PLASMA_ACT	!BYTE	00	;0=No Plasma active 1=plasma active
RANDOM		!BYTE	00	;used for random number generation
CONTROL		!BYTE	00	;0=keyboard 1=custom keys 2=snes
MUSIC_STATE	!BYTE	00	;0=music off 1=music on
PLAYER_DIR	!BYTE	01	;0=UP 1=DOWN 2=LEFT 3=RIGHT
PLAYER_ANI	!BYTE	56	;0=ANIM1 56=ANIM2
INTRO_MESSAGE	!SCR"vic-robots! by",255
		!SCR"david murray 2021",0
MSG_CANTMOVE	!SCR"can't move that!",0
MSG_BLOCKED	!SCR"blocked!",0
MSG_SEARCHING	!SCR"searching",0
MSG_NOTFOUND	!SCR"nothing found here",0
MSG_FOUNDKEY	!SCR"found a key card!",0
MSG_FOUNDGUN	!SCR"found a pistol!",0
MSG_FOUNDEMP	!SCR"found emp device!",0
MSG_FOUNDBOMB	!SCR"found a timebomb!",0
MSG_FOUNDPLAS	!SCR"found a plasmagun!",0
MSG_FOUNDMED	!SCR"found a medkit!",0
MSG_FOUNDMAG	!SCR"found a magnet!",0

*=$13FE	;CHARSET GOES HERE
!BINARY	"gfxfont.prg"

MSG_MUCHBET	!SCR"ahhh, much better!",0
MSG_EMPUSED	!SCR"emp activated!",255
		!SCR"robots rebooting.",0
MSG_TERMINATED	!SCR"you're terminated!",0
MSG_TRANS1	!SCR"transporter won't",255
		!SCR"activate until all",255
		!SCR"robots destroyed!",0
MSG_ELEVATOR	!SCR"[ elevator panel ]",255
		!SCR"[  select level  ]",0
MSG_LEVELS	!SCR"[                ]",0
MSG_PAUSED	!SCR"game paused.",255
		!SCR"exit game (y/n)",0
SELECTED_MAP	!BYTE	00

;Reconfigures VIC-20 screen to 25x25 characters
;uses sound routine to check if PAL or NTSC.
SET_SCREEN_SIZE:
	LDA	#25		;Number of columns to display on VIC
	STA	$9002		;Send to VIC.  also sets COLOR RAM to $9400
	LDA	#50		;Number of rows (times two) for VIC
	STA	$9003		;Send to VIC
	JSR 	PEST_SOUND+27
	CMP	#0
	BNE	PAL
	;NTSC MODE
	LDA	#1
	STA	$9000		;horizontal offset
	LDA	#22
	STA	$9001		;vertical offset
	RTS
PAL:	LDA	#9
	STA	SHAKE3+1
	LDA	#10
	STA	SHAKE4+1
	LDA	#35
	STA	$9001		;vertical offset
	RTS

DISPLAY_LOAD_MESSAGE1:		
	LDY	#0
DLM1:
	LDA	LOADMSG1,Y
	JSR	$FFD2
	INY
	CPY	#18
	BNE	DLM1
	RTS

;Displays loading message for map.
DISPLAY_LOAD_MESSAGE2:
	LDY	#0
DLM2:	LDA	LOAD_MSG2,Y
	STA	$10FA,Y
	INY
	CPY	#12
	BNE	DLM2
	LDA	SELECTED_MAP
	STA	DECNUM
	INC	DECNUM
	LDA	#$06
	STA	$FB
	LDA	#$11
	STA	$FC
	JSR	DECWRITE
	RTS
LOAD_MSG2:	!SCR"loading map:"

SETUP_INTERRUPT:
	SEI			; Disable interrupt routine
	LDA	#<RUNIRQ	; Setup IRQ to visit my routine RUNIRQ before
	STA	$0314		; doing the usual IRQ routine.
	LDA	#>RUNIRQ
	STA	$0315
	CLI			; Reenable routine.
	RTS

;This is the routine that runs every 60 seconds from the IRQ.
;BGTIMER1 is always set to 1 every cycle, after which the main
;program will reset it to 0 when it is done with it's work for
;that cycle.  BGTIMER2 is a count-down to zero and then stays
;there.
RUNIRQ:
	JSR	ANIMATE_WATER
	LDA	#1
	STA	BGTIMER1
	LDA	BGTIMER2
	CMP	#0
	BEQ	IRQ1
	DEC	BGTIMER2
IRQ1:	LDA	KEYTIMER
	CMP	#0
	BEQ	IRQ2
	DEC	KEYTIMER
IRQ2:	;BORDER FLASHER
	LDX	BORDER
	CPX	#0
	BEQ	IRQ3
	LDA	BORDER,X
	STA	$900F
	DEC	BORDER
	;BACKGROUND FLASHER
IRQ3:	LDX	BGFLASH
	CPX	#0
	BEQ	IRQ10
	LDA	BGFLASH,X
	STA	$900F
	DEC	BGFLASH
IRQ10:	;SCREEN_SHAKER
	LDA	SCREEN_SHAKE
	CMP	#$00
	BEQ	SHAKE3
SHAKE2:	LDA	$9000	;X-SCROLL REGISTER
	AND	#%00000001
	CMP	#%00000001
	BEQ	SHAKE4
SHAKE3:	LDA	#%00000001
	STA	$9000
	JMP	IRQ20
SHAKE4:	LDA	#%00000000
	STA	$9000
	;CHECK TO SEE IF KEYBOARD WAS DISABLED	
	;This routine causes the kernal to skip keyboard
	;input for one cycle to help "debounce" the 
	;keyboard.
IRQ20:	LDA	$0289	;1=normal 0=disabled
	CMP	#0
	BNE	IRQ30
	LDA	KEYSOFF
	CMP	#00
	BEQ	IRQ21
	LDA	#0
	STA	KEYSOFF
	LDA	#1
	STA	$0289	;turn keyboard back on
	JMP	IRQ30:
IRQ21:	INC	KEYSOFF
IRQ30:	JSR	PEST_SOUND+$06	;UPDATE Sound
	JMP	$EABF		; Back to usual IRQ routine
BGTIMER1	!BYTE 00
BGTIMER2	!BYTE 00
KEYTIMER	!BYTE 00
KEYSOFF		!BYTE 00
BORDER		!BYTE 00,14,10,10,10,15,15,15,10,10,10
BGFLASH		!BYTE 00,14,104,232,232,30,30,30,232,232,104

SNES_CONTROLER_READ:
	;First copy last time's results to the LAST variables.
	LDY	#0
SNCL:	LDA	SNES_B,Y
	STA	LAST_B,Y
	INY
	CPY	#12
	BNE	SNCL
	;now latch data
	LDA	#%00100000	;latch on pin 5
	STA	$9110	
	LDA	#%00000000
	STA	$9110	
	LDX	#0
	;Now read in bits
SRLOOP:	LDA	$9110
	AND	#%01000000	;READ pin 6
	CMP	#%01000000
	BEQ	SRL1
	LDA	#1
	JMP	SRL5
SRL1:	LDA	#0
SRL5:	STA	SNES_B,X
	;pulse the clock line
	LDA	#%00001000	;CLOCK on pin 3
	STA	$9110
	LDA	#%00000000
	STA	$9110
	INX
	CPX	#12
	BNE	SRLOOP
	;now process any new presses
	LDY	#0
SRL09:	LDA	NEW_B,Y
	CMP	#1
	BEQ	SRL10
	LDA	SNES_B,Y
	CMP	#1
	BNE	SRL10
	LDA	LAST_B,Y
	CMP	#0
	BNE	SRL10
	LDA	#1
	STA	NEW_B,Y
SRL10:	INY
	CPY	#12
	BNE	SRL09
	RTS

;This routine spaces out the timers so that not everything
;is running out once.
SET_INITIAL_TIMERS:
	LDX	#01
SIT1	TXA
	STA	UNIT_TIMER_A,X
	LDA	#0
	STA	UNIT_TIMER_B,X
	INX	
	CPX	#48
	BNE	SIT1
	RTS

MAIN_GAME_LOOP:
	JSR	BACKGROUND_TASKS
	LDA	UNIT_TYPE
	CMP	#1	;Is player unit alive
	BEQ	MG00
	JMP	GAME_OVER
MG00:	LDA	CONTROL
	CMP	#2
	BNE	KY01
	JMP	SC01
KY01:	;Keyboard controls here.
	JSR	KEY_REPEAT
	JSR	$FFE4
	CMP	#$00
	BEQ	MAIN_GAME_LOOP	
MG01:	CMP	#$1D	;CURSOR RIGHT
	BNE	MG02
MG01A:	LDA	#3	
	STA	PLAYER_DIR
	LDA	#0
	STA	UNIT
	LDA	#%00000001
	STA	MOVE_TYPE
	JSR	REQUEST_WALK_RIGHT
	JMP	AFTER_MOVE
MG02:	CMP	#$9D	;CURSOR LEFT
	BNE	MG03
MG02A:	LDA	#2	
	STA	PLAYER_DIR
	LDA	#0
	STA	UNIT
	LDA	#%00000001
	STA	MOVE_TYPE
	JSR	REQUEST_WALK_LEFT
	JMP	AFTER_MOVE
MG03:	CMP	#$11	;CURSOR DOWN
	BNE	MG04
MG03A:	LDA	#1	
	STA	PLAYER_DIR
	LDA	#0
	STA	UNIT
	LDA	#%00000001
	STA	MOVE_TYPE
	JSR	REQUEST_WALK_DOWN
	JMP	AFTER_MOVE
MG04:	CMP	#$91	;CURSOR UP
	BNE	MG05
MG04A:	LDA	#0	
	STA	PLAYER_DIR
	LDA	#0
	STA	UNIT
	LDA	#%00000001
	STA	MOVE_TYPE
	JSR	REQUEST_WALK_UP
	JMP	AFTER_MOVE
MG05:	CMP	#133	;F1-Key
	BNE	MG06
	JSR	CYCLE_WEAPON
	JSR	CLEAR_KEY_BUFFER
	JMP	MAIN_GAME_LOOP
MG06:	CMP	#134	;F3-Key
	BNE	MG07
	JSR	CYCLE_ITEM
	JSR	CLEAR_KEY_BUFFER
	JMP	MAIN_GAME_LOOP
MG07:	CMP	KEY_MOVE
	BNE	MG08
	JSR	MOVE_OBJECT
	JSR	CLEAR_KEY_BUFFER
	JMP	MAIN_GAME_LOOP	
MG08:	CMP	KEY_SEARCH
	BNE	MG09
	JSR	SEARCH_OBJECT
	JSR	CLEAR_KEY_BUFFER
	JMP	MAIN_GAME_LOOP
MG09:	CMP	KEY_USE
	BNE	MG10
	JSR	USE_ITEM
	JSR	CLEAR_KEY_BUFFER
	JMP	MAIN_GAME_LOOP
MG10:	CMP	KEY_MOVE_LEFT
	BNE	MG11
	JMP	MG02A	
MG11:	CMP	KEY_MOVE_DOWN
	BNE	MG12
	JMP	MG03A
MG12:	CMP	KEY_MOVE_RIGHT
	BNE	MG13
	JMP	MG01A
MG13:	CMP	KEY_MOVE_UP
	BNE	MG14
	JMP	MG04A
MG14:	CMP	KEY_FIRE_UP
	BNE	MG15
	JSR	FIRE_UP
	LDA	#20
	STA	KEYTIMER
	JMP	MAIN_GAME_LOOP
MG15:	CMP	KEY_FIRE_LEFT
	BNE	MG16
	JSR	FIRE_LEFT
	LDA	#20
	STA	KEYTIMER
	JMP	MAIN_GAME_LOOP
MG16:	CMP	KEY_FIRE_DOWN
	BNE	MG17
	JSR	FIRE_DOWN
	LDA	#20
	STA	KEYTIMER
	JMP	MAIN_GAME_LOOP
MG17:	CMP	KEY_FIRE_RIGHT
	BNE	MG18
	JSR	FIRE_RIGHT
	LDA	#20
	STA	KEYTIMER
	JMP	MAIN_GAME_LOOP
MG18:	CMP	#03	;RUN/STOP
	BNE	MG19
	JMP	PAUSE_GAME
MG19:	CMP	#223	;C= + * (cheat mode)
	BNE	MG20
	JSR	CHEATER
	JMP	MAIN_GAME_LOOP
MG20:	CMP	#205	;SHIFT-M
	BNE	MG21
	JSR	TOGGLE_MUSIC
	JSR	CLEAR_KEY_BUFFER
MG21:	JMP	MAIN_GAME_LOOP

SC01:	;SNES CONTROLLER starts here
	JSR	SNES_CONTROLER_READ
	;check keytimer for repeat time.
	LDA	KEYTIMER
	CMP	#0
	BEQ	SC02
	JMP	SC40
SC02:	LDA	#0
	STA	NEW_UP
	STA	NEW_DOWN
	STA	NEW_LEFT
	STA	NEW_RIGHT
	STA	SNES_UP
	STA	SNES_DOWN
	STA	SNES_LEFT
	STA	SNES_RIGHT
	JSR	SNES_CONTROLER_READ
SC05:	;first we start with the 4 directional buttons.
	LDA	NEW_LEFT
	CMP	#01
	BNE	SC10
	LDA	#2	
	STA	PLAYER_DIR
	LDA	#0
	STA	UNIT
	LDA	#%00000001
	STA	MOVE_TYPE
	JSR	REQUEST_WALK_LEFT
	JMP	AFTER_MOVE_SNES	
SC10:	LDA	NEW_RIGHT
	CMP	#01
	BNE	SC20
	LDA	#3	
	STA	PLAYER_DIR
	LDA	#0
	STA	UNIT
	LDA	#%00000001
	STA	MOVE_TYPE
	JSR	REQUEST_WALK_RIGHT
	JMP	AFTER_MOVE_SNES
SC20:	LDA	NEW_UP
	CMP	#01
	BNE	SC30
	LDA	#0
	STA	PLAYER_DIR
	STA	UNIT
	LDA	#%00000001
	STA	MOVE_TYPE
	JSR	REQUEST_WALK_UP
	JMP	AFTER_MOVE_SNES
SC30:	LDA	NEW_DOWN
	CMP	#01
	BNE	SC35
	LDA	#1	
	STA	PLAYER_DIR
	LDA	#0
	STA	UNIT
	LDA	#%00000001
	STA	MOVE_TYPE
	JSR	REQUEST_WALK_DOWN
	JMP	AFTER_MOVE_SNES
SC35:	LDA	#0
	STA	KEY_FAST
SC40:	;Now check for non-repeating buttons
	LDA	NEW_Y
	CMP	#1
	BNE	SC45
	JSR	FIRE_LEFT
	LDA	#0
	STA	NEW_Y
SC45:	LDA	NEW_A
	CMP	#1
	BNE	SC50
	JSR	FIRE_RIGHT
	LDA	#0
	STA	NEW_A
SC50:	LDA	NEW_X
	CMP	#1
	BNE	SC55
	JSR	FIRE_UP
	LDA	#0
	STA	NEW_X
SC55:	LDA	NEW_B
	CMP	#1
	BNE	SC60
	JSR	FIRE_DOWN
	LDA	#0
	STA	NEW_B
SC60:	LDA	NEW_BACK_L
	CMP	#1
	BNE	SC65
	LDA	SNES_SELECT
	CMP	#1
	BNE	SC62
	JSR	CYCLE_ITEM
	JMP	SC63
SC62:	JSR	SEARCH_OBJECT
SC63:	LDA	#0
	STA	NEW_BACK_L
	LDA	#15
	STA	KEYTIMER
SC65:	LDA	NEW_BACK_R
	CMP	#1
	BNE	SC70
	LDA	SNES_SELECT
	CMP	#1
	BNE	SC67
	JSR	CYCLE_WEAPON
	JMP	SC68
SC67:	JSR	MOVE_OBJECT
SC68:	LDA	#0
	STA	NEW_BACK_R
	LDA	#15
	STA	KEYTIMER
SC70:	LDA	NEW_START
	CMP	#1
	BNE	SC75
	JSR	USE_ITEM
	LDA	#0
	STA	NEW_START
	LDA	#15
	STA	KEYTIMER
SC75:	;STILL USE KEYBOARD TO CHECK FOR RUN/STOP
	JSR	$FFE4
	CMP	#03	;RUN/STOP
	BNE	SC82
	JMP	PAUSE_GAME
SC82:	CMP	#205	;SHIFT-M
	BNE	SC83
	JSR	TOGGLE_MUSIC
	JSR	CLEAR_KEY_BUFFER
SC83:	JMP	MAIN_GAME_LOOP

;This routine handles things that are in common to
;all 4 directions of movement.
AFTER_MOVE_SNES:
	LDA	MOVE_RESULT
	CMP	#1
	BNE	AMS01
	JSR	ANIMATE_PLAYER
	JSR	CACULATE_AND_REDRAW
AMS01:	LDA	KEY_FAST
	CMP	#0
	BNE	AMS02
	LDA	#15
	STA	KEYTIMER
	LDA	#1
	STA	KEY_FAST
	JMP	AMS03
AMS02:	LDA	#6
	STA	KEYTIMER
	LDA	#0
	STA	NEW_UP
	STA	NEW_DOWN
	STA	NEW_LEFT
	STA	NEW_RIGHT
AMS03:	JMP	MAIN_GAME_LOOP

CHEATER:
	LDA	#7
	STA	KEYS			
	LDA	#100
	STA	AMMO_PISTOL	
	STA	AMMO_PLASMA	
	STA	INV_BOMBS	
	STA	INV_EMP		
	STA	INV_MEDKIT	
	STA	INV_MAGNET	
	LDA	#1	
	STA	SELECTED_WEAPON		
	STA	SELECTED_ITEM	
	JSR	DISPLAY_KEYS
	JSR	DISPLAY_WEAPON
	JSR	DISPLAY_ITEM	
	RTS

PAUSE_GAME:
	JSR	SCROLL_INFO
	LDA	#<MSG_PAUSED
	STA	$FB
	LDA	#>MSG_PAUSED
	STA	$FC
	JSR	PRINT_INFO
	JSR	CLEAR_KEY_BUFFER
PG1:	JSR	$FFE4
	CMP	#$00
	BEQ	PG1
	CMP	#03	;RUN/STOP
	BEQ	PG5
	CMP	#78	;N-KEY
	BEQ	PG5	
	CMP	#89	;Y-KEY
	BEQ	PG6
	JMP	PG1
PG5:	JSR	SCROLL_INFO
	JSR	SCROLL_INFO
	JSR	SCROLL_INFO
	JSR	CLEAR_KEY_BUFFER
	JMP	MAIN_GAME_LOOP
PG6:	JMP	GOM4

CLEAR_KEY_BUFFER:
	LDA	#0
	STA	$0289	;disable keyboard input
	LDA	#0
	STA	$00C6	;CLEAR KEYBOARD BUFFER
	LDA	#20
	STA	KEYTIMER
	RTS

USE_ITEM:
	;First figure out which item to use.
	LDA	SELECTED_ITEM
	CMP	#1	;BOMB
	BNE	UI02
	JMP	USE_BOMB
UI02:	CMP	#2	;EMP
	BNE	UI03	
	JMP	USE_EMP
UI03:	CMP	#3	;MEDKIT
	BNE	UI04
	JMP	USE_MEDKIT
UI04:	CMP	#4	;MAGNET
	BNE	UI05
	JMP	USE_MAGNET
UI05:	RTS

USE_BOMB:
	JSR	USER_SELECT_OBJECT
	;NOW TEST TO SEE IF THAT SPOT IS OPEN
	JSR	BOMB_MAGNET_COMMON1
	BEQ	BM30	
	JMP	BM3A				;If not, then exit routine.
BM30:	;Now scan for any units at that location:
	JSR	CHECK_FOR_UNIT
	LDA	UNIT_FIND
	CMP	#255			;255 means no unit found.
	BEQ	BM31
BM3A:	JMP	BOMB_MAGNET_COMMON2
BM31:	LDX	#28	;Start of weapons units
BOMB1:	LDA	UNIT_TYPE,X
	CMP	#0
	BEQ	BOMB2
	INX
	CPX	#32
	BNE	BOMB1
	RTS	;no slots available right now, abort.
BOMB2:	LDA	#6	;bomb AI
	STA	UNIT_TYPE,X
	LDA	#130	;bomb tile
	STA	UNIT_TILE,X
	LDA	MAP_X
	STA	UNIT_LOC_X,X
	LDA	MAP_Y
	STA	UNIT_LOC_Y,X
	LDA	#100		;How long until exposion?
	STA	UNIT_TIMER_A,X
	LDA	#0
	STA	UNIT_A,X
	DEC	INV_BOMBS
	JSR	DISPLAY_ITEM
	LDA	#01
	STA	REDRAW_WINDOW
	LDA	#06		;move sound
	JSR	PLAY_SOUND	;SOUND PLAY
	RTS

USE_MAGNET:
	LDA	MAGNET_ACT	;only one magnet active at a time.
	CMP	#0
	BEQ	MG32
	RTS
MG32:	JSR	USER_SELECT_OBJECT
	;NOW TEST TO SEE IF THAT SPOT IS OPEN
	JSR	BOMB_MAGNET_COMMON1
	BEQ	MG31	
	JMP	BOMB_MAGNET_COMMON2
MG31:	LDX	#28	;Start of weapons units
MAG1:	LDA	UNIT_TYPE,X
	CMP	#0
	BEQ	MAG2
	INX
	CPX	#32
	BNE	MAG1
	RTS	;no slots available right now, abort.
MAG2:	LDA	#20	;MAGNET AI
	STA	UNIT_TYPE,X
	LDA	#134	;MAGNET tile
	STA	UNIT_TILE,X
	LDA	MAP_X
	STA	UNIT_LOC_X,X
	LDA	MAP_Y
	STA	UNIT_LOC_Y,X
	LDA	#1		;How long until ACTIVATION
	STA	UNIT_TIMER_A,X
	LDA	#255		;how long does it live -A
	STA	UNIT_TIMER_B,X
	LDA	#5		;how long does it live -B
	STA	UNIT_A,X
	LDA	#1
	STA	MAGNET_ACT	;only one magnet allowed at a time.
	DEC	INV_MAGNET
	JSR	DISPLAY_ITEM
	LDA	#01
	STA	REDRAW_WINDOW
	LDA	#06		;move sound
	JSR	PLAY_SOUND	;SOUND PLAY
	RTS

BOMB_MAGNET_COMMON1:
	LDA	#0
	STA	CURSOR_ON
	JSR	DRAW_MAP_WINDOW		;ERASE THE CURSOR
	LDA	CURSOR_X
	CLC
	ADC	MAP_WINDOW_X
	STA	MAP_X
	STA	MOVTEMP_UX
	LDA	CURSOR_Y
	CLC
	ADC	MAP_WINDOW_Y
	STA	MAP_Y
	STA	MOVTEMP_UY
	JSR	GET_TILE_FROM_MAP
	LDA	TILE
	TAY
	LDA	TILE_ATTRIB,Y
	AND	#%00000001		;is that spot available	
	CMP	#%00000001		;for something to move onto it?
	RTS

BOMB_MAGNET_COMMON2:
	LDA	#<MSG_BLOCKED
	STA	$FB
	LDA	#>MSG_BLOCKED
	STA	$FC
	JSR	PRINT_INFO
	LDA	#11		;ERROR SOUND
	JSR	PLAY_SOUND	;SOUND PLAY
	RTS	

USE_EMP:
	LDA	#10
	STA	BGFLASH
	LDA	#3		;EMP sound
	JSR	PLAY_SOUND	;SOUND PLAY
	DEC	INV_EMP
	JSR	DISPLAY_ITEM
	LDX	#1	;start with unit#1 (skip player)
EMP1:	;CHECK THAT UNIT EXISTS
	LDA	UNIT_TYPE,X
	CMP	#0
	BEQ	EMP5
	;CHECK HORIZONTAL POSITION
	LDA	UNIT_LOC_X,X
	CMP	MAP_WINDOW_X
	BCC	EMP5
	LDA	MAP_WINDOW_X
	CLC
	ADC	#6 	;reduced screen width on VIC-20
	CMP	UNIT_LOC_X,X
	BCC	EMP5
	;NOW CHECK VERTICAL
	LDA	UNIT_LOC_Y,X
	CMP	MAP_WINDOW_Y
	BCC	EMP5
	LDA	MAP_WINDOW_Y
	CLC
	ADC	#6
	CMP	UNIT_LOC_Y,X
	BCC	EMP5
	LDA	#255
	STA	UNIT_TIMER_A,X
	;test to see if unit is above water
	LDA	UNIT_LOC_X,X
	STA	MAP_X
	LDA	UNIT_LOC_Y,X
	STA	MAP_Y
	JSR	GET_TILE_FROM_MAP
	LDA	TILE
	CMP	#204	;WATER
	BNE	EMP5
	LDA	#5
	STA	UNIT_TYPE,X
	STA	UNIT_TIMER_A,X
	LDA	#60
	STA	UNIT_A,X
	LDA	#140	;Electrocuting tile
	STA	UNIT_TILE,X
EMP5:	INX	
	CPX	#28
	BNE	EMP1
	LDA	#<MSG_EMPUSED
	STA	$FB
	LDA	#>MSG_EMPUSED
	STA	$FC
	JSR	PRINT_INFO
	RTS

USE_MEDKIT:
	LDA	UNIT_HEALTH
	CMP	#12	;Do we even need the medkit?
	BNE	UMK1
	RTS
UMK1:	;Now figure out how many HP we need to be healthy.
	LDA	#12
	SEC
	SBC	UNIT_HEALTH
	STA	TEMP_A		;how many we need.
	LDA	INV_MEDKIT	;how many do we have?
	SEC
	SBC	TEMP_A
	BCC	UMK2
	;we had more than we need, so go to full health.
	LDA	#12
	STA	UNIT_HEALTH
	LDA	INV_MEDKIT
	SEC
	SBC	TEMP_A
	STA	INV_MEDKIT
	JMP	UMK3
UMK2:	;we had less than we need, so we'll use what is available.
	LDA	INV_MEDKIT
	CLC
	ADC	UNIT_HEALTH
	STA	UNIT_HEALTH
	LDA	#0
	STA	INV_MEDKIT
UMK3:	JSR	DISPLAY_PLAYER_HEALTH
	JSR	DISPLAY_ITEM
	LDA	#2		;MEDKIT SOUND
	JSR	PLAY_SOUND	;SOUND PLAY
	LDA	#<MSG_MUCHBET
	STA	$FB
	LDA	#>MSG_MUCHBET
	STA	$FC
	JSR	PRINT_INFO
	RTS

FIRE_UP:
	LDA	SELECTED_WEAPON
	CMP	#0
	BNE	FRU0
	RTS
FRU0:	CMP	#1
	BNE	FRU1
	JMP	FIRE_UP_PISTOL
FRU1:	JMP	FIRE_UP_PLASMA

FIRE_UP_PISTOL:
	LDA	AMMO_PISTOL
	CMP	#0
	BNE	FU00
	RTS
FU00:	LDX	#28
FU01:	LDA	UNIT_TYPE,X
	CMP	#0
	BEQ	FU02
	INX
	CPX	#32	;max unit for weaponsfire
	BNE	FU01
	RTS
FU02:	LDA	#12	;Fire pistol up AI routine
	STA	UNIT_TYPE,X
	LDA	#244	;tile for vertical weapons fire
	STA	UNIT_TILE,X
	LDA	#3		;travel distance.
	STA	UNIT_A,X
	LDA	#0		;weapon-type = pistol
	STA	UNIT_B,X
	JMP	AFTER_FIRE	

FIRE_UP_PLASMA:
	LDA	BIG_EXP_ACT
	CMP	#1
	BEQ	FUP3
	LDA	PLASMA_ACT
	CMP	#1
	BEQ	FUP3
	LDA	AMMO_PLASMA
	CMP	#0
	BNE	FUP0
FUP3:	RTS
FUP0:	LDX	#28
FUP1:	LDA	UNIT_TYPE,X
	CMP	#0
	BEQ	FUP2
	INX
	CPX	#32	;max unit for weaponsfire
	BNE	FUP1
	RTS
FUP2:	LDA	#12	;Fire pistol up AI routine
	STA	UNIT_TYPE,X
	LDA	#240	;tile for vertical plasma bolt
	STA	UNIT_TILE,X
	LDA	#3		;travel distance.
	STA	UNIT_A,X
	LDA	#1		;weapon-type = plasma
	STA	UNIT_B,X
	STA	PLASMA_ACT
	JMP	AFTER_FIRE

FIRE_DOWN:
	LDA	SELECTED_WEAPON
	CMP	#0
	BNE	FRD0
	RTS
FRD0:	CMP	#1
	BNE	FRD1
	JMP	FIRE_DOWN_PISTOL
FRD1:	JMP	FIRE_DOWN_PLASMA

FIRE_DOWN_PISTOL:
	LDA	AMMO_PISTOL
	CMP	#0
	BNE	FD00
	RTS
FD00:	LDX	#28
FD01:	LDA	UNIT_TYPE,X
	CMP	#0
	BEQ	FD02
	INX
	CPX	#32	;max unit for weaponsfire
	BNE	FD01
	RTS	
FD02:	LDA	#13	;Fire pistol DOWN AI routine
	STA	UNIT_TYPE,X
	LDA	#244	;tile for vertical weapons fire
	STA	UNIT_TILE,X
	LDA	#3		;travel distance.
	STA	UNIT_A,X
	LDA	#0		;weapon-type = pistol
	STA	UNIT_B,X
	JMP	AFTER_FIRE

FIRE_DOWN_PLASMA:
	LDA	BIG_EXP_ACT
	CMP	#1
	BEQ	FDP3
	LDA	PLASMA_ACT
	CMP	#1
	BEQ	FDP3
	LDA	AMMO_PLASMA
	CMP	#0
	BNE	FDP0
FDP3:	RTS
FDP0:	LDX	#28
FDP1:	LDA	UNIT_TYPE,X
	CMP	#0
	BEQ	FDP2
	INX
	CPX	#32	;max unit for weaponsfire
	BNE	FDP1
	RTS	
FDP2:	LDA	#13	;Fire pistol DOWN AI routine
	STA	UNIT_TYPE,X
	LDA	#240	;tile for vertical weapons fire
	STA	UNIT_TILE,X
	LDA	#3		;travel distance.
	STA	UNIT_A,X
	LDA	#1		;weapon-type = plasma
	STA	UNIT_B,X
	STA	PLASMA_ACT
	JMP	AFTER_FIRE

FIRE_LEFT:
	LDA	SELECTED_WEAPON
	CMP	#0
	BNE	FRL0
	RTS
FRL0:	CMP	#1
	BNE	FRL1
	JMP	FIRE_LEFT_PISTOL
FRL1:	JMP	FIRE_LEFT_PLASMA

FIRE_LEFT_PISTOL:
	LDA	AMMO_PISTOL
	CMP	#0
	BNE	FL00
	RTS
FL00:	LDX	#28
FL01:	LDA	UNIT_TYPE,X
	CMP	#0
	BEQ	FL02
	INX
	CPX	#32	;max unit for weaponsfire
	BNE	FL01
	RTS	
FL02:	LDA	#14	;Fire pistol LEFT AI routine
	STA	UNIT_TYPE,X
	LDA	#245	;tile for horizontal weapons fire
	STA	UNIT_TILE,X
	LDA	#3		;travel distance.
	STA	UNIT_A,X
	LDA	#0		;weapon-type = pistol
	STA	UNIT_B,X
	JMP	AFTER_FIRE

FIRE_LEFT_PLASMA:
	LDA	BIG_EXP_ACT
	CMP	#1
	BEQ	FLP3
	LDA	PLASMA_ACT
	CMP	#1
	BEQ	FLP3
	LDA	AMMO_PLASMA
	CMP	#0
	BNE	FLP0
FLP3:	RTS
FLP0:	LDX	#28
FLP1:	LDA	UNIT_TYPE,X
	CMP	#0
	BEQ	FLP2
	INX
	CPX	#32	;max unit for weaponsfire
	BNE	FLP1
	RTS	
FLP2:	LDA	#14	;Fire pistol LEFT AI routine
	STA	UNIT_TYPE,X
	LDA	#241	;tile for horizontal weapons fire
	STA	UNIT_TILE,X
	LDA	#3		;travel distance.
	STA	UNIT_A,X
	LDA	#1		;weapon-type = plasma
	STA	UNIT_B,X
	STA	PLASMA_ACT
	JMP	AFTER_FIRE

FIRE_RIGHT:
	LDA	SELECTED_WEAPON
	CMP	#0
	BNE	FRR0
	RTS
FRR0:	CMP	#1
	BNE	FRR1
	JMP	FIRE_RIGHT_PISTOL
FRR1:	JMP	FIRE_RIGHT_PLASMA
	
FIRE_RIGHT_PISTOL:
	LDA	AMMO_PISTOL
	CMP	#0
	BNE	FR00
	RTS
FR00:	LDX	#28
FR01:	LDA	UNIT_TYPE,X
	CMP	#0
	BEQ	FR02
	INX
	CPX	#32	;max unit for weaponsfire
	BNE	FR01
	RTS	
FR02:	LDA	#15	;Fire pistol RIGHT AI routine
	STA	UNIT_TYPE,X
	LDA	#245	;tile for horizontal weapons fire
	STA	UNIT_TILE,X
	LDA	#3		;travel distance.
	STA	UNIT_A,X
	LDA	#0		;weapon-type = pistol
	STA	UNIT_B,X
	JMP	AFTER_FIRE

FIRE_RIGHT_PLASMA:
	LDA	BIG_EXP_ACT
	CMP	#1
	BEQ	FRP3
	LDA	PLASMA_ACT
	CMP	#1
	BEQ	FRP3
	LDA	AMMO_PLASMA
	CMP	#0
	BNE	FRP0
FRP3:	RTS
FRP0:	LDX	#28
FRP1:	LDA	UNIT_TYPE,X
	CMP	#0
	BEQ	FRP2
	INX
	CPX	#32	;max unit for weaponsfire
	BNE	FRP1
	RTS	
FRP2:	LDA	#15	;Fire pistol RIGHT AI routine
	STA	UNIT_TYPE,X
	LDA	#241	;tile for horizontal weapons fire
	STA	UNIT_TILE,X
	LDA	#3		;travel distance.
	STA	UNIT_A,X
	LDA	#1		;weapon-type = plasma
	STA	UNIT_B,X
	STA	PLASMA_ACT
	JMP	AFTER_FIRE

AFTER_FIRE:
	LDA	#0
	STA	UNIT_TIMER_A,X
	LDA	UNIT_LOC_X
	STA	UNIT_LOC_X,X
	LDA	UNIT_LOC_Y
	STA	UNIT_LOC_Y,X
	STX	UNIT
	LDA	#20
	STA	KEYTIMER
	LDA	SELECTED_WEAPON
	CMP	#2
	BEQ	AF01
	LDA	#09		;PISTOL-SOUND
	JSR	PLAY_SOUND	;SOUND PLAY
	DEC	AMMO_PISTOL
	JSR	DISPLAY_WEAPON
	RTS
AF01:	LDA	#08		;PLASMA-GUN-SOUND
	JSR	PLAY_SOUND	;SOUND PLAY
	DEC	AMMO_PLASMA
	JSR	DISPLAY_WEAPON
	RTS

KEY_REPEAT:
	LDA	#16
	STA	$028C	;reset kernal repeat timer (to prevent repeats) 
	LDA	KEYTIMER
	CMP	#0
	BNE	KEYR2
	LDA	$C5
	CMP	#64	;no key pressed
	BEQ	KEYR1
	LDA	#64	;clear LSTX register
	STA	$C5	;clear LSTX register
	LDA	#7
	STA	KEYTIMER
	RTS
KEYR1:	;No key pressed, reset all to defaults
	LDA	#0	
	STA	KEY_FAST
	LDA	#7
	STA	KEYTIMER
KEYR2:	RTS

;This routine handles things that are in common to
;all 4 directions of movement.
AFTER_MOVE:
	LDA	MOVE_RESULT
	CMP	#1
	BNE	AM01
	JSR	ANIMATE_PLAYER
	JSR	CACULATE_AND_REDRAW
AM01:	;now reset key-repeat rate
	LDA	KEY_FAST
	CMP	#0
	BNE	KEYR3
	;FIRST REPEAT
	LDA	#15
	STA	KEYTIMER
	INC	KEY_FAST
KEYR4:	JMP	MAIN_GAME_LOOP
KEYR3:	;SUBSEQUENT REPEATS
	LDA	#7
	STA	KEYTIMER
	JMP	MAIN_GAME_LOOP
KEY_FAST	!BYTE	0	;0=DEFAULT STATE

;This routine is invoked when the user presses S to search
;an object such as a crate, chair, or plant.
SEARCH_OBJECT:
	JSR	USER_SELECT_OBJECT
	LDA	#1
	STA	REDRAW_WINDOW
CHS1:	;first check of object is searchable
	JSR	CALC_COORDINATES
	JSR	GET_TILE_FROM_MAP
	LDX	TILE
	LDA	TILE_ATTRIB,X
	AND	#%01000000	;can search attribute
	CMP	#%01000000
	BEQ	CHS2
	LDA	#0
	STA	CURSOR_ON
	JMP	CHS3
CHS2:	;is the tile a crate?
	LDX	TILE
	CPX	#041	;BIG CRATE
	BEQ	CHS2B
	CPX	#045	;small CRATE
	BEQ	CHS2B
	CPX	#199	;"Pi" CRATE
	BEQ	CHS2B
	JMP	CHS2C
CHS2B:	LDA	DESTRUCT_PATH,X
	STA	TILE
	JSR	PLOT_TILE_TO_MAP
CHS2C:	;Now check if there is an object there.
	LDA	#0
	STA	SEARCHBAR
	LDA	#<MSG_SEARCHING
	STA	$FB
	LDA	#>MSG_SEARCHING
	STA	$FC
	JSR	PRINT_INFO
SOBJ1:	LDA	#18	;delay time between search periods
	STA	BGTIMER2
SOBJ2:	JSR	BACKGROUND_TASKS
	LDA	BGTIMER2
	CMP	#0
	BNE	SOBJ2
	LDX	SEARCHBAR
	LDA	#46	;PERIOD
	STA	$1261,X
	INC	SEARCHBAR
	LDA	SEARCHBAR
	CMP	#8
	BNE	SOBJ1
	LDA	#0
	STA	CURSOR_ON
	JSR	DRAW_MAP_WINDOW		;ERASE THE CURSOR
	JSR	CALC_COORDINATES
	JSR	CHECK_FOR_HIDDEN_UNIT
	LDA	UNIT_FIND
	CMP	#255
	BNE	SOBJ5
CHS3:	LDA	#<MSG_NOTFOUND
	STA	$FB
	LDA	#>MSG_NOTFOUND
	STA	$FC
	JSR	PRINT_INFO
	RTS
SOBJ5:	LDX	UNIT_FIND
	LDA	UNIT_TYPE,X
	STA	TEMP_A		;store object type
	LDA	UNIT_A,X
	STA	TEMP_B		;store secondary info
	LDA	#0	;DELETE ITEM ONCE FOUND
	STA	UNIT_TYPE,X

	;***NOW PROCESS THE ITEM FOUND***
	LDA	#10		;ITEM-FOUND-SOUND
	JSR	PLAY_SOUND	;SOUND PLAY
	LDA	TEMP_A
	CMP	#128	;key
	BEQ	SOBJ10
	JMP	SOBJ15
SOBJ10:	LDA	TEMP_B		;WHICH SORT OF KEY?
	CMP	#00
	BNE	SOBJK1
	LDA	KEYS
	ORA	#%00000001	;Add spade key
	STA	KEYS
	JMP	SOBJ12
SOBJK1:	CMP	#01
	BNE	SOBJK2
	LDA	KEYS
	ORA	#%00000010	;Add heart key
	STA	KEYS
	JMP	SOBJ12
SOBJK2:	LDA	KEYS
	ORA	#%00000100	;Add star key
	STA	KEYS
SOBJ12:	LDA	#<MSG_FOUNDKEY
	STA	$FB
	LDA	#>MSG_FOUNDKEY
	STA	$FC
	JSR	PRINT_INFO
	JSR	DISPLAY_KEYS
	RTS
SOBJ15:	CMP	#129	;TIME BOMB
	BNE	SOBJ17
	LDA	TEMP_B
	CLC
	ADC	INV_BOMBS
	STA	INV_BOMBS
	LDA	#<MSG_FOUNDBOMB
	STA	$FB
	LDA	#>MSG_FOUNDBOMB
	STA	$FC
	JSR	PRINT_INFO
	JSR	DISPLAY_ITEM
	RTS	
SOBJ17:	CMP	#130	;EMP	
	BNE	SOBJ20
	LDA	TEMP_B
	CLC
	ADC	INV_EMP
	STA	INV_EMP
	LDA	#<MSG_FOUNDEMP
	STA	$FB
	LDA	#>MSG_FOUNDEMP
	STA	$FC
	JSR	PRINT_INFO
	JSR	DISPLAY_ITEM
	RTS	
SOBJ20:	CMP	#131	;PISTOL
	BNE	SOBJ21
	LDA	TEMP_B
	CLC
	ADC	AMMO_PISTOL
	STA	AMMO_PISTOL
	BCC	SOBJ2A	;If we rolled over past 255
	LDA	#255	;set it to 255.
	STA	AMMO_PISTOL
SOBJ2A:	LDA	#<MSG_FOUNDGUN
	STA	$FB
	LDA	#>MSG_FOUNDGUN
	STA	$FC
	JSR	PRINT_INFO
	JSR	DISPLAY_WEAPON	
SOBJ21:	CMP	#132	;PLASMA GUN
	BNE	SOBJ22
	LDA	TEMP_B
	CLC
	ADC	AMMO_PLASMA
	STA	AMMO_PLASMA
	LDA	#<MSG_FOUNDPLAS
	STA	$FB
	LDA	#>MSG_FOUNDPLAS
	STA	$FC
	JSR	PRINT_INFO
	JSR	DISPLAY_WEAPON
SOBJ22:	CMP	#133	;MEDKIT
	BNE	SOBJ23
	LDA	TEMP_B
	CLC
	ADC	INV_MEDKIT
	STA	INV_MEDKIT
	LDA	#<MSG_FOUNDMED
	STA	$FB
	LDA	#>MSG_FOUNDMED
	STA	$FC
	JSR	PRINT_INFO
	JSR	DISPLAY_ITEM
SOBJ23:	CMP	#134	;MAGNET
	BNE	SOBJ99
	LDA	TEMP_B
	CLC
	ADC	INV_MAGNET
	STA	INV_MAGNET
	LDA	#<MSG_FOUNDMAG
	STA	$FB
	LDA	#>MSG_FOUNDMAG
	STA	$FC
	JSR	PRINT_INFO
	JSR	DISPLAY_ITEM
SOBJ99:	;ADD CODE HERE FOR OTHER OBJECT TYPES
	RTS
SEARCHBAR	!BYTE 00	;to count how many periods to display.

;combines cursor location with window location
;to determine coordinates for MAP_X and MAP_Y
CALC_COORDINATES:
	LDA	CURSOR_X
	CLC
	ADC	MAP_WINDOW_X
	STA	MAP_X
	LDA	CURSOR_Y
	CLC
	ADC	MAP_WINDOW_Y
	STA	MAP_Y
	RTS

;This routine is called by routines such as the move, search,
;or use commands.  It displays a cursor and allows the user
;to pick a direction of an object.
USER_SELECT_OBJECT:
	LDA	#16		;beep sound
	JSR	PLAY_SOUND	;SOUND PLAY
	LDA	#3
	STA	CURSOR_X
	LDA	#3
	STA	CURSOR_Y
	LDA	#1
	STA	CURSOR_ON
	JSR	REVERSE_TILE
	;First ask user which object to move
MV01:	JSR	BACKGROUND_TASKS
	LDA	UNIT_TYPE
	CMP	#0	;Did player die wile moving something?
	BNE	MVCONT
	LDA	#0
	STA	CURSOR_ON
	RTS
MVCONT:	LDA	CONTROL
	CMP	#2
	BNE	MV01A
	JMP	MVSNES
MV01A:	JSR	$FFE4
	CMP	#$00
	BEQ	MV02
MV02:	CMP	#$1D	;CURSOR RIGHT
	BNE	MV03
	INC	CURSOR_X
	RTS
MV03:	CMP	#$9D	;CURSOR LEFT
	BNE	MV04
	DEC	CURSOR_X
	RTS	
MV04:	CMP	#$11	;CURSOR DOWN
	BNE	MV05
	INC	CURSOR_Y
	RTS
MV05:	CMP	#$91	;CURSOR UP
	BNE	MV06
	DEC	CURSOR_Y
	RTS
MV06:	CMP	KEY_MOVE_LEFT
	BNE	MV07
	DEC	CURSOR_X
	RTS	
MV07:	CMP	KEY_MOVE_DOWN
	BNE	MV08
	INC	CURSOR_Y
	RTS
MV08:	CMP	KEY_MOVE_RIGHT
	BNE	MV09
	INC	CURSOR_X
	RTS
MV09:	CMP	KEY_MOVE_UP
	BNE	MV0A
	DEC	CURSOR_Y
	RTS
MV0A:	JMP	MV01

MVSNES:	;SNES controls for this routine
	JSR	SNES_CONTROLER_READ
	LDA	NEW_RIGHT
	CMP	#1
	BNE	MVS03
	INC	CURSOR_X
	LDA	#0
	STA	NEW_RIGHT
	RTS
MVS03:	LDA	NEW_LEFT
	CMP	#1
	BNE	MVS04
	DEC	CURSOR_X
	LDA	#0
	STA	NEW_LEFT
	RTS	
MVS04:	LDA	NEW_DOWN
	CMP	#1
	BNE	MVS05
	INC	CURSOR_Y
	LDA	#0
	STA	NEW_DOWN
	RTS
MVS05:	LDA	NEW_UP
	CMP	#1
	BNE	MVS06
	DEC	CURSOR_Y
	LDA	#0
	STA	NEW_UP
	RTS
MVS06:	JMP	MV01

MOVE_OBJECT:
	JSR	USER_SELECT_OBJECT
	LDA	UNIT
	;now test that object to see if it
	;is allowed to be moved.
MV10:	LDA	#0
	STA	CURSOR_ON
	JSR	DRAW_MAP_WINDOW		;ERASE THE CURSOR
	JSR	CALC_COORDINATES
	JSR	CHECK_FOR_HIDDEN_UNIT
	LDA	UNIT_FIND
	STA	MOVTEMP_U
	JSR	GET_TILE_FROM_MAP
	LDA	TILE
	TAY
	LDA	TILE_ATTRIB,Y
	AND	#%00000100		;can it be moved?	
	CMP	#%00000100		
	BEQ	MV11
	LDA	#<MSG_CANTMOVE
	STA	$FB
	LDA	#>MSG_CANTMOVE
	STA	$FC
	JSR	PRINT_INFO
	LDA	#11		;ERROR SOUND
	JSR	PLAY_SOUND	;SOUND PLAY
	RTS
MV11:	LDA	TILE
	STA	MOVTEMP_O	;Store which tile it is we are moving
	LDA	MAP_X
	STA	MOVTEMP_X	;Store original location of object
	LDA	MAP_Y
	STA	MOVTEMP_Y
	LDA	#1
	STA	CURSOR_ON
	JSR	REVERSE_TILE
	;NOW ASK THE USER WHICH DIRECTION TO MOVE IT TO
MV15:	JSR	BACKGROUND_TASKS
	LDA	UNIT_TYPE
	CMP	#0	;Did player die wile moving something?
	BNE	MVCONT2
	LDA	#0
	STA	CURSOR_ON
	RTS
MVCONT2:	;which controller are we using?
	LDA	CONTROL
	CMP	#2
	BNE	MV15B
	JMP	SMV30
MV15B:	;KEYBOARD CONTROL
	JSR	$FFE4
	CMP	#$00
	BEQ	MV15
MV16:	CMP	#$1D	;CURSOR RIGHT
	BNE	MV17
	INC	CURSOR_X
	JMP	MV25
MV17:	CMP	#$9D	;CURSOR LEFT
	BNE	MV18
	DEC	CURSOR_X
	JMP	MV25	
MV18:	CMP	#$11	;CURSOR DOWN
	BNE	MV19
	INC	CURSOR_Y
	JMP	MV25
MV19:	CMP	#$91	;CURSOR UP
	BNE	MV20
	DEC	CURSOR_Y
	JMP	MV25
MV20:	CMP	KEY_MOVE_LEFT
	BNE	MV2A
	DEC	CURSOR_X
	JMP	MV25
MV2A:	CMP	KEY_MOVE_DOWN
	BNE	MV2B
	INC	CURSOR_Y
	JMP	MV25
MV2B:	CMP	KEY_MOVE_RIGHT
	BNE	MV2C
	INC	CURSOR_X
	JMP	MV25
MV2C:	CMP	KEY_MOVE_UP
	BNE	MV2D
	DEC	CURSOR_Y
	JMP	MV25
MV2D:	JMP	MV15	
SMV30:	;SNES controls
	JSR	SNES_CONTROLER_READ
	LDA	NEW_RIGHT
	CMP	#1
	BNE	SMV31
	INC	CURSOR_X
	LDA	#0
	STA	NEW_RIGHT
	JMP	MV25
SMV31:	LDA	NEW_LEFT
	CMP	#1
	BNE	SMV32
	DEC	CURSOR_X
	LDA	#0
	STA	NEW_LEFT
	JMP	MV25	
SMV32:	LDA	NEW_DOWN
	CMP	#1
	BNE	SMV33
	INC	CURSOR_Y
	LDA	#0
	STA	NEW_DOWN
	JMP	MV25
SMV33:	LDA	NEW_UP
	CMP	#1
	BNE	SMV34
	DEC	CURSOR_Y
	LDA	#0
	STA	NEW_UP
	JMP	MV25
SMV34:	JMP	MV15
	
	;NOW TEST TO SEE IF THAT SPOT IS OPEN
MV25:	LDA	#0
	STA	CURSOR_ON
	JSR	DRAW_MAP_WINDOW		;ERASE THE CURSOR
	LDA	CURSOR_X
	CLC
	ADC	MAP_WINDOW_X
	STA	MAP_X
	STA	MOVTEMP_UX
	LDA	CURSOR_Y
	CLC
	ADC	MAP_WINDOW_Y
	STA	MAP_Y
	STA	MOVTEMP_UY
	JSR	GET_TILE_FROM_MAP
	LDA	TILE
	TAY
	LDA	TILE_ATTRIB,Y
	AND	#%00100000		;is that spot available	
	CMP	#%00100000		;for something to move onto it?
	BEQ	MV30	
	JMP	MV3A				;If not, then exit routine.
MV30:	;Now scan for any units at that location:
	JSR	CHECK_FOR_UNIT
	LDA	UNIT_FIND
	CMP	#255			;255 means no unit found.
	BEQ	MV31
MV3A:	LDA	#<MSG_BLOCKED
	STA	$FB
	LDA	#>MSG_BLOCKED
	STA	$FC
	JSR	PRINT_INFO
	LDA	#11		;ERROR SOUND
	JSR	PLAY_SOUND	;SOUND PLAY
	RTS
MV31:	LDA	#06		;move sound
	JSR	PLAY_SOUND	;SOUND PLAY
	LDY	#0
	LDA	($FD),Y			;Grab current object
	STA	MOVTEMP_D
	LDA	MOVTEMP_O
	STA	($FD),Y			;replace with obect we are moving	
	LDA	MOVTEMP_X		;RETRIEVE original location of object
	STA	MAP_X
	LDA	MOVTEMP_Y
	STA	MAP_Y
	JSR	GET_TILE_FROM_MAP
	LDA	MOVTEMP_D
	CMP	#148		;trash compactor tile
	BNE	MV31A
	LDA	#09		;Floor tile
MV31A:	STA	($FD),Y			;Replace former location
	LDA	#1
	STA	REDRAW_WINDOW		;See the result
	LDA	MOVTEMP_U
	CMP	#255
	BNE	MV32
	RTS	
MV32:	LDX	MOVTEMP_U
	LDA	MOVTEMP_UX
	STA	UNIT_LOC_X,X
	LDA	MOVTEMP_UY
	STA	UNIT_LOC_Y,X
	RTS
MOVTEMP_O:	!BYTE 00	;origin tile
MOVTEMP_D:	!BYTE 00	;destination tile
MOVTEMP_X:	!BYTE 00	;x-coordinate
MOVTEMP_Y:	!BYTE 00	;y-coordinate
MOVTEMP_U:	!BYTE 00	;unit number (255=none)
MOVTEMP_UX	!BYTE 00
MOVTEMP_UY	!BYTE 00

CACULATE_AND_REDRAW:
	LDA	UNIT_LOC_X	;no index needed since it's player unit
	SEC
	SBC	#3
	STA	MAP_WINDOW_X
	LDA	UNIT_LOC_Y	;no index needed since it's player unit
	SEC
	SBC	#3
	STA	MAP_WINDOW_Y
	LDA	#1
	STA	REDRAW_WINDOW
	RTS

;This routine checks all units from 0 to 31 and figures out if it should be dislpayed
;on screen, and then grabs that unit's tile and stores it in the MAP_PRECALC array
;so that when the window is drawn, it does not have to search for units during the
;draw, speeding up the display routine.
MAP_PRE_CALCULATE:
	;CLEAR OLD BUFFER
	LDA	#0
	LDY	#0
PREC0:	STA	MAP_PRECALC,Y
	INY
	CPY	#49
	BNE	PREC0
	LDX	#0
	JMP	PREC2	;skip the check for unit zero, always draw it.
PREC1:	;CHECK THAT UNIT EXISTS
	LDA	UNIT_TYPE,X
	CMP	#0
	BEQ	PREC5
	;CHECK HORIZONTAL POSITION
	LDA	UNIT_LOC_X,X
	CMP	MAP_WINDOW_X
	BCC	PREC5
	LDA	MAP_WINDOW_X
	CLC
	ADC	#6
	CMP	UNIT_LOC_X,X
	BCC	PREC5
	;NOW CHECK VERTICAL
	LDA	UNIT_LOC_Y,X
	CMP	MAP_WINDOW_Y
	BCC	PREC5
	LDA	MAP_WINDOW_Y
	CLC
	ADC	#6
	CMP	UNIT_LOC_Y,X
	BCC	PREC5
	;Unit found in map window, now add that unit's
	;tile to the precalc map.
PREC2:	LDA	UNIT_LOC_Y,X
	SEC
	SBC	MAP_WINDOW_Y
	TAY
	LDA	UNIT_LOC_X,X
	SEC
	SBC	MAP_WINDOW_X
	CLC
	ADC	PRECALC_ROWS,Y	
	TAY
	LDA	UNIT_TILE,X
	CMP	#130	;is it a bomb
	BEQ	PREC6
	CMP	#134	;is it a magnet?
	BEQ	PREC6
PREC4:	STA	MAP_PRECALC,Y
PREC5:	;continue search
	INX	
	CPX	#32
	BNE	PREC1
	RTS
PREC6:	;What to do in case of bomb or magnet that should
	;go underneath the unit or robot.
	LDA	MAP_PRECALC,Y
	CMP	#0
	BNE	PREC5
	LDA	UNIT_TILE,X
	JMP	PREC4		

PRECALC_ROWS:	!BYTE	0,7,14,21,28,35,42

;This routine is where the MAP is displayed on the screen
;This is a temporary routine, taken from the map editor.
DRAW_MAP_WINDOW:
	JSR	MAP_PRE_CALCULATE
	LDA	#0
	STA	REDRAW_WINDOW
	STA	TEMP_X
	STA	TEMP_Y
	STA	PRECALC_COUNT
DM01:	;FIRST CALCULATE WHERE THE BYTE IS STORED IN THE MAP
	LDY	#0
	LDA	TEMP_Y
	CLC
	ADC	MAP_WINDOW_Y	
	ROR
	PHP
	CLC
	ADC	#>MAP
	STA	$FE	;HIGH BYTE OF MAP SOURCE
	LDA	#$0
	PLP
	ROR
	CLC
	ADC	TEMP_X
	ADC	MAP_WINDOW_X
	STA	$FD	;LOW BYTE OF MAP SOURCE
	LDA	($FD),Y
	STA	TILE
	;NOW FIGURE OUT WHERE TO PLACE IT ON SCREEN.
	LDX	TEMP_Y
	LDA	MAP_CHART_L,X
	STA	$FB	;LOW BYTE OF SCREEN AREA
	LDA	MAP_CHART_H,X
	STA	$FC	;HIGH BYTE OF SCREEN AREA
	LDA	TEMP_X
	ASL	;MULTIPLY BY 2
	CLC
	ADC	TEMP_X	;ADD ANOTHER TO MAKE X3
	ADC	$FB
	STA	$FB
	LDA	$FC
	ADC	#00	;CARRY FLAG
	STA	$FC
	JSR	PLOT_TILE
	;now check for sprites in this location
	LDY	PRECALC_COUNT
	LDA	MAP_PRECALC,Y
	CMP	#00
	BEQ	DM02
	STA	TILE
	LDX	TEMP_Y
	LDA	MAP_CHART_L,X
	STA	$FB	;LOW BYTE OF SCREEN AREA
	LDA	MAP_CHART_H,X
	STA	$FC	;HIGH BYTE OF SCREEN AREA
	LDA	TEMP_X
	ASL	;MULTIPLY BY 2
	CLC
	ADC	TEMP_X	;ADD ANOTHER TO MAKE X3
	ADC	$FB
	STA	$FB
	LDA	$FC
	ADC	#00	;CARRY FLAG
	STA	$FC
	JSR	PLOT_TRANSPARENT_TILE
DM02:	INC	TEMP_X
	INC	PRECALC_COUNT
	LDA	TEMP_X
	CMP	#7
	BNE	DM01
	;CHECK FOR CURSOR
DM03:	LDA	CURSOR_ON
	CMP	#1	;Is cursor even on?
	BNE	DM04
	LDA	TEMP_Y
	CMP	CURSOR_Y	;is cursor on the same row that were drawing?
	BNE	DM04
	JSR	REVERSE_TILE
DM04:	LDA	#0
	STA	TEMP_X
	INC	TEMP_Y
	LDA	TEMP_Y
	CMP	#7
	BEQ	DM10
	JMP	DM01
DM10:	RTS

;This routine plots a 3x3 tile from the tile database anywhere
;on screen.  But first you must define the tile number in the
;TILE variable, as well as the starting screen address must
;be defined in $FB.
PLOT_TILE:
	LDA	$FB	;Grab the starting address, and adjust it for
	STA	$FD	;the color RAM before we get started.
	LDA	$FC
	STA	$FE
	LDX	TILE
	;DRAW THE TOP 3 CHARACTERS
	LDA	TILE_DATA_TL,X
	LDY	#0
	STA	($FB),Y
	LDA	TILE_DATA_TM,X
	INY
	STA	($FB),Y	
	LDA	TILE_DATA_TR,X
	INY
	STA	($FB),Y	
	;MOVE DOWN TO NEXT LINE
	LDY	#25
	;DRAW THE MIDDLE 3 CHARACTERS
	LDA	TILE_DATA_ML,X
	STA	($FB),Y
	LDA	TILE_DATA_MM,X
	INY
	STA	($FB),Y	
	LDA	TILE_DATA_MR,X
	INY
	STA	($FB),Y	
	;MOVE DOWN TO NEXT LINE
	LDY	#50
	;DRAW THE BOTTOM 3 CHARACTERS
	LDA	TILE_DATA_BL,X
	STA	($FB),Y
	LDA	TILE_DATA_BM,X
	INY
	STA	($FB),Y	
	LDA	TILE_DATA_BR,X
	INY
	STA	($FB),Y
	;NOW DO THE COLOR
	LDA	$FE
	CLC
	ADC	#$84	;adjust to color RAM area by adding $D400	
	STA	$FE
	;DRAW THE TOP 3 COLORS
	LDA	TILE_COLOR_TL,X
	LDY	#0
	STA	($FD),Y
	LDA	TILE_COLOR_TM,X
	INY
	STA	($FD),Y	
	LDA	TILE_COLOR_TR,X
	INY
	STA	($FD),Y	
	;MOVE DOWN TO NEXT LINE
	LDY	#25
	;DRAW THE MIDDLE 3 COLORS
	LDA	TILE_COLOR_ML,X
	STA	($FD),Y
	LDA	TILE_COLOR_MM,X
	INY
	STA	($FD),Y	
	LDA	TILE_COLOR_MR,X
	INY
	STA	($FD),Y	
	;MOVE DOWN TO NEXT LINE
	LDY	#50
	;DRAW THE BOTTOM 3 COLORS
	LDA	TILE_COLOR_BL,X
	STA	($FD),Y
	LDA	TILE_COLOR_BM,X
	INY
	STA	($FD),Y	
	LDA	TILE_COLOR_BR,X
	INY
	STA	($FD),Y	
	RTS	

;This routine plots a transparent tile from the tile database
;anywhere on screen.  But first you must define the tile number
;in the TILE variable, as well as the starting screen address must
;be defined in $FB.  Also, this routine is slower than the usual
;tile routine, so is only used for sprites.  The ":" character ($3A)
;is not drawn.
PLOT_TRANSPARENT_TILE:
	LDA	$FB	;Grab the starting address, and adjust it for
	STA	$FD	;the color RAM before we get started.
	LDA	$FC
	STA	$FE
	LDX	TILE
	;DRAW THE TOP 3 CHARACTERS
	LDA	TILE_DATA_TL,X
	LDY	#0
	CMP	#$3A
	BEQ	PTT01
	STA	($FB),Y
PTT01:	LDA	TILE_DATA_TM,X
	INY
	CMP	#$3A
	BEQ	PTT02
	STA	($FB),Y	
PTT02:	LDA	TILE_DATA_TR,X
	INY
	CMP	#$3A
	BEQ	PTT03
	STA	($FB),Y	
	;MOVE DOWN TO NEXT LINE
PTT03:	LDY	#25
	;DRAW THE MIDDLE 3 CHARACTERS
	LDA	TILE_DATA_ML,X
	CMP	#$3A
	BEQ	PTT04
	STA	($FB),Y
PTT04:	LDA	TILE_DATA_MM,X
	INY
	CMP	#$3A
	BEQ	PTT05
	STA	($FB),Y	
PTT05:	LDA	TILE_DATA_MR,X
	INY
	CMP	#$3A
	BEQ	PTT06
	STA	($FB),Y	
	;MOVE DOWN TO NEXT LINE
PTT06:	LDY	#50
	;DRAW THE BOTTOM 3 CHARACTERS
	LDA	TILE_DATA_BL,X
	CMP	#$3A
	BEQ	PTT07
	STA	($FB),Y
PTT07:	LDA	TILE_DATA_BM,X
	INY
	CMP	#$3A
	BEQ	PTT08
	STA	($FB),Y	
PTT08:	LDA	TILE_DATA_BR,X
	INY
	CMP	#$3A
	BEQ	PTT09
	STA	($FB),Y	
PTT09:	;****NOW DO THE COLOR****
	LDA	$FE
	CLC
	ADC	#$84	;adjust to color RAM area by adding $8400	
	STA	$FE
	;DRAW THE TOP 3 COLORS
	LDA	TILE_COLOR_TL,X
	LDY	#0
	CMP	#$00	;If it is black, don't draw it.
	BEQ	PTT10
	STA	($FD),Y
PTT10:	LDA	TILE_COLOR_TM,X
	INY
	CMP	#$00	;If it is black, don't draw it.
	BEQ	PTT11
	STA	($FD),Y	
PTT11:	LDA	TILE_COLOR_TR,X
	INY
	CMP	#$00	;If it is black, don't draw it.
	BEQ	PTT12
	STA	($FD),Y	
	;MOVE DOWN TO NEXT LINE
PTT12:	LDY	#25
	;DRAW THE MIDDLE 3 COLORS
	LDA	TILE_COLOR_ML,X
	CMP	#$00	;If it is black, don't draw it.
	BEQ	PTT13
	STA	($FD),Y
PTT13:	LDA	TILE_COLOR_MM,X
	INY
	CMP	#$00	;If it is black, don't draw it.
	BEQ	PTT14
	STA	($FD),Y	
PTT14:	LDA	TILE_COLOR_MR,X
	INY
	CMP	#$00	;If it is black, don't draw it.
	BEQ	PTT15
	STA	($FD),Y	
	;MOVE DOWN TO NEXT LINE
PTT15:	LDY	#50
	;DRAW THE BOTTOM 3 COLORS
	LDA	TILE_COLOR_BL,X
	CMP	#$00	;If it is black, don't draw it.
	BEQ	PTT16
	STA	($FD),Y
PTT16:	LDA	TILE_COLOR_BM,X
	INY
	CMP	#$00	;If it is black, don't draw it.
	BEQ	PTT17
	STA	($FD),Y	
PTT17:	LDA	TILE_COLOR_BR,X
	INY
	CMP	#$00	;If it is black, don't draw it.
	BEQ	PTT18
	STA	($FD),Y	
PTT18:	RTS	


;This routine puts the cursor on the game map. Originally it reversed
;the characters, but after moving to a custom character set, there was
;no reverse set to use anymore, so now it draws a box.
REVERSE_TILE:
	LDX	CURSOR_Y
	LDA	MAP_CHART_L,X
	STA	$FB	;LOW BYTE OF SCREEN AREA
	LDA	MAP_CHART_H,X
	STA	$FC	;HIGH BYTE OF SCREEN AREA
	LDA	CURSOR_X
	ASL	;MULTIPLY BY 2
	CLC
	ADC	CURSOR_X	;ADD ANOTHER TO MAKE X3
	ADC	$FB
	STA	$FB
	LDA	$FC
	ADC	#00	;CARRY FLAG
	STA	$FC
	LDY	#00
	LDA	#$70
	STA	($FB),Y
	INY
	INY	
	LDA	#$6E
	STA	($FB),Y
	LDY	#50
	LDA	#$6D
	STA	($FB),Y
	INY
	INY	
	LDA	#$7D
	STA	($FB),Y
	LDX	CURSOR_Y
	LDA	MAP_CHART_L,X
	STA	$FB	;LOW BYTE OF SCREEN AREA
	LDA	MAP_CHART_H,X
	STA	$FC	;HIGH BYTE OF SCREEN AREA
	LDA	CURSOR_X
	ASL	;MULTIPLY BY 2
	CLC
	ADC	CURSOR_X	;ADD ANOTHER TO MAKE X3
	ADC	$FB
	STA	$FB
	LDA	$FC
	ADC	#$84	;CARRY FLAG AND $D4 TO MOVE TO COLOR RAM
	STA	$FC
	LDY	#00
	LDA	#01	;WHITE ON BLACK
	STA	($FB),Y
	INY
	INY	
	STA	($FB),Y
	LDY	#50
	LDA	#01	;WHITE ON BLACK
	STA	($FB),Y
	INY
	INY	
	STA	($FB),Y
	RTS

;SOURCE_CHAR	!BYTE	00
;DEST_CAR	!BYTE	00

;REVERSE_CHAR:
;	LDA	SOURCE_CHAR
	

;This routine checks to see if UNIT is occupying any space
;that is currently visible in the window.  If so, the
;flag for redrawing the window will be set.
CHECK_FOR_WINDOW_REDRAW:
	LDX	UNIT
	;FIRST CHECK HORIZONTAL
	LDA	UNIT_LOC_X,X
	CMP	MAP_WINDOW_X
	BCC	CFR1
	LDA	MAP_WINDOW_X
	CLC
	ADC	#6		;this number is unique to VIC-20 due to smaller screen
	CMP	UNIT_LOC_X,X
	BCC	CFR1
	;NOW CHECK VERTICAL
	LDA	UNIT_LOC_Y,X
	CMP	MAP_WINDOW_Y
	BCC	CFR1
	LDA	MAP_WINDOW_Y
	CLC
	ADC	#6
	CMP	UNIT_LOC_Y,X
	BCC	CFR1
	LDA	#1
	STA	REDRAW_WINDOW
CFR1:	RTS

DECWRITE:
	LDA	#$00
	STA	SCREENPOS
	LDA	DECNUM
	LDX 	#2
	LDY 	#$4C
DEC1	STY 	DECB
	LSR
DEC2	ROL
	BCS 	DEC3
	CMP	DECA,X
	BCC 	DEC4
DEC3	SBC 	DECA,X
	SEC
DEC4	ROL 	DECB
	BCC 	DEC2
	STA	DECTEMP
	LDA 	DECB
	LDY	SCREENPOS
	STA	($FB),Y
	INC	SCREENPOS
	LDA	DECTEMP
	LDY 	#$13
	DEX
	BPL 	DEC1
	RTS
DECA		!BYTE  	128,160,200
DECB		!BYTE  	1
SCREENPOS	!BYTE	$00
DECTEMP		!BYTE	$00

; The following routine loads the tileset from disk
TILE_LOAD_ROUTINE:	
	LDA	#11	;LENGTH OF FILENAME
	LDX	#<TILENAME
	LDY	#>TILENAME
	JSR	$FFBD	;SETNAM A=FILE NAME LENGTH X/Y=POINTER TO FILENAME
	LDA	#$02
	LDX	#$08
	LDY	#$00
	JSR	$FFBA	;SETFLS A=LOGICAL NUMBER X=DEVICE NUMBER Y=SECONDARY
	LDX	#$00	;LOW BYTE FOR LOAD ADDRESS
	LDY	#$A0	;HIGH BYTE FOR LOAD ADDRESS
	LDA	#$00
	JSR	$FFD5	;LOAD FILE A=0 FOR LOAD X/Y=LOAD ADDRESS
	JSR	$FFC3	;CLOSE FILE	
	RTS

; The following routine loads the map from disk
MAP_LOAD_ROUTINE:	
	LDA	#7	;LENGTH OF FILENAME
	LDX	#<MAPNAME
	LDY	#>MAPNAME
	JSR	$FFBD	;SETNAM A=FILE NAME LENGTH X/Y=POINTER TO FILENAME
	LDA	#$02
	LDX	#$08
	LDY	#$00
	JSR	$FFBA	;SETFLS A=LOGICAL NUMBER X=DEVICE NUMBER Y=SECONDARY
	LDX	#$00	;LOW BYTE FOR LOAD ADDRESS
	LDY	#$5D	;HIGH BYTE FOR LOAD ADDRESS
	LDA	#$00
	JSR	$FFD5	;LOAD FILE A=0 FOR LOAD X/Y=LOAD ADDRESS
	JSR	$FFC3	;CLOSE FILE	
	RTS

; The following routine loads the sound routines from disk
SOUND_LOAD_ROUTINE:	
	;load sound driver to $0400
	LDA	#8	;LENGTH OF FILENAME
	LDX	#<SNDNAME
	LDY	#>SNDNAME
	JSR	$FFBD	;SETNAM A=FILE NAME LENGTH X/Y=POINTER TO FILENAME
	LDA	#$02
	LDX	#$08
	LDY	#$00
	JSR	$FFBA	;SETFLS A=LOGICAL NUMBER X=DEVICE NUMBER Y=SECONDARY
	LDX	#$00	;LOW BYTE FOR LOAD ADDRESS
	LDY	#$04	;HIGH BYTE FOR LOAD ADDRESS
	LDA	#$00
	JSR	$FFD5	;LOAD FILE A=0 FOR LOAD X/Y=LOAD ADDRESS
	JSR	$FFC3	;CLOSE FILE
	;load music to $B400
	LDA	#10	;LENGTH OF FILENAME
	LDX	#<MUSICNAME
	LDY	#>MUSICNAME
	JSR	$FFBD	;SETNAM A=FILE NAME LENGTH X/Y=POINTER TO FILENAME
	LDA	#$02
	LDX	#$08
	LDY	#$00
	JSR	$FFBA	;SETFLS A=LOGICAL NUMBER X=DEVICE NUMBER Y=SECONDARY
	LDX	#$00	;LOW BYTE FOR LOAD ADDRESS
	LDY	#$B4	;HIGH BYTE FOR LOAD ADDRESS
	LDA	#$00
	JSR	$FFD5	;LOAD FILE A=0 FOR LOAD X/Y=LOAD ADDRESS
	JSR	$FFC3	;CLOSE FILE
	RTS

DISPLAY_GAME_SCREEN:
	LDA	#$CD
	STA	$9005	;enabled custom charset at $1400
	;SET SOURCE
	LDA	#<SCR_TEXT
	STA	$FB
	LDA	#>SCR_TEXT
	STA	$FC
	;SET DESTINATION
	LDA	#$00
	STA	$FD
	LDA	#$10
	STA	$FE
	;SET END
	LDA	#$12
	STA	DGS5+1
	LDA	#$70
	STA	DGS6+1
	JSR	DECOMPRESS_SCREEN
	;SET SOURCE
	LDA	#<SCR_COLOR
	STA	$FB
	LDA	#>SCR_COLOR
	STA	$FC
	;SET DESTINATION
	LDA	#$00
	STA	$FD
	LDA	#$94
	STA	$FE
	;SET END
	LDA	#$96
	STA	DGS5+1
	LDA	#$70
	STA	DGS6+1
	JSR	DECOMPRESS_SCREEN
	RTS

DISPLAY_INTRO_SCREEN:
	LDA	#$C0
	STA	$9005	; Turn off custom character set.
	;SET SOURCE
	LDA	#<INTRO_TEXT
	STA	$FB
	LDA	#>INTRO_TEXT
	STA	$FC
	;SET DESTINATION
	LDA	#$00
	STA	$FD
	LDA	#$10
	STA	$FE
	;SET END
	LDA	#$12
	STA	DGS5+1
	LDA	#$70
	STA	DGS6+1
	JSR	DECOMPRESS_SCREEN
	;SET SOURCE
	LDA	#<INTRO_COLOR
	STA	$FB
	LDA	#>INTRO_COLOR
	STA	$FC
	;SET DESTINATION
	LDA	#$00
	STA	$FD
	LDA	#$94
	STA	$FE
	;SET END
	LDA	#$96
	STA	DGS5+1
	LDA	#$70
	STA	DGS6+1
	JSR	DECOMPRESS_SCREEN
	RTS

DISPLAY_ENDGAME_SCREEN:
	;first clear the color RAM.
	LDA	#05;	GREEN
	LDX	#0
DESA:	STA	$9400,X
	STA	$9500,X
	INX
	CPX	#0
	BNE	DESA
DESB:	STA	$9600,X
	INX
	CPX	#113
	BNE	DESB
	;Now decompress text
	;SET SOURCE
	LDA	#<SCR_ENDGAME
	STA	$FB
	LDA	#>SCR_ENDGAME
	STA	$FC
	;SET DESTINATION
	LDA	#$00
	STA	$FD
	LDA	#$10
	STA	$FE
	;SET END
	LDA	#$12
	STA	DGS5+1
	LDA	#$70
	STA	DGS6+1
	JSR	DECOMPRESS_SCREEN
	;display map number
	LDA	#$D3
	STA	$FB
	LDA	#$10
	STA	$FC
	LDA	SELECTED_MAP
	STA	DECNUM
	INC	DECNUM
	JSR	DECWRITE
	;count robots remaining
	LDX	#1
	LDA	#0
	STA	DECNUM
DEG7:	LDA	UNIT_TYPE,X
	CMP	#0
	BEQ	DEG8
	INC	DECNUM
DEG8:	INX
	CPX	#28
	BNE	DEG7
	LDA	#$11
	STA	$FC
	LDA	#$69
	STA	$FB
	JSR	DECWRITE
	;Count secrets remaining
	LDA	#0
	STA	DECNUM
	LDX	#48
DEG9:	LDA	UNIT_TYPE,X
	CMP	#0
	BEQ	DEG10
	INC	DECNUM
DEG10:	INX
	CPX	#64
	BNE	DEG9
	LDA	#$11
	STA	$FC
	LDA	#$B4
	STA	$FB
	JSR	DECWRITE
	RTS

DECOMPRESS_SCREEN:
	LDY	#00
DGS1:	LDA	($FB),Y
	CMP	#96	;REPEAT FLAG
	BEQ	DGS10	
DGS2:	STA	($FD),Y
	;CHECK TO SEE IF WE REACHED $83E7 YET.	
DGS4:	LDA	$FE
DGS5:	CMP	#$83	;SELF MODIFYING CODE
	BNE	DGS3
	LDA	$FD
DGS6:	CMP	#$E7	;SELF MODIFYING CODE
	BNE	DGS3
	RTS
DGS3:	JSR	INC_SOURCE
	JSR	INC_DEST
	JMP	DGS1
DGS10:	;REPEAT CODE
	JSR	INC_SOURCE
	LDA	($FB),Y
	STA	RPT
	JSR	INC_SOURCE
	LDA	($FB),Y
	TAX
DGS11:	LDA	RPT
	STA	($FD),Y
	JSR	INC_DEST
	DEX
	CPX	#$FF
	BNE	DGS11
	LDA	$FD
	SEC
	SBC	#01
	STA	$FD
	LDA	$FE
	SBC	#00
	STA	$FE
	JMP	DGS4	
INC_SOURCE:
	LDA	$FB
	CLC
	ADC	#01
	STA	$FB
	LDA	$FC
	ADC	#00
	STA	$FC
	RTS
INC_DEST:
	LDA	$FD
	CLC
	ADC	#01
	STA	$FD
	LDA	$FE
	ADC	#00
	STA	$FE
	RTS
RPT	!BYTE 00	;repeat value

DISPLAY_PLAYER_HEALTH:
	LDA	UNIT_HEALTH	;No index needed because it is the player
	LSR			;divide by two
	STA	TEMP_A
	LDY	#00
DPH01:	CPY	TEMP_A
	BEQ	DPH02	
	LDA	#$66		;GRAY BLOCK
	STA	$1252,Y
	INY	
	JMP	DPH01	
DPH02:	LDA	UNIT_HEALTH
	AND	#%00000001
	CMP	#%00000001
	BNE	DPH03
	LDA	#$5C		;HALF GRAY BLOCK
	STA	$1252,Y
	INY
DPH03:	CPY	#6
	BEQ	DPH04
	LDA	#$20		;SPACE
	STA	$1252,Y	
	INY
	JMP	DPH03
DPH04:	RTS

DISPLAY_KEYS:
	LDA	#32
	STA	$11A6	;ERASE ALL 3 SPOTS
	STA	$11A7
	STA	$11A8	
	LDA	KEYS
	AND	#%00000001
	CMP	#%00000001	;Spade key
	BNE	DKS1	
	LDA	#$41
	STA	$11A6
DKS1:	LDA	KEYS
	AND	#%00000010
	CMP	#%00000010	;heart key
	BNE	DKS2
	LDA	#$53
	STA	$11A7
DKS2:	LDA	KEYS
	AND	#%00000100
	CMP	#%00000100	;star key
	BNE	DKS3
	LDA	#$2A
	STA	$11A8
DKS3:	RTS

CYCLE_ITEM:	
	LDA	#13		;CHANGE-ITEM-SOUND
	JSR	PLAY_SOUND	;SOUND PLAY
	LDA	#20
	STA	KEYTIMER
	INC	SELECTED_ITEM
	LDA	SELECTED_ITEM
	CMP	#5
	BEQ	CYIT1
	JMP	DISPLAY_ITEM
CYIT1:	LDA	#0
	STA	SELECTED_ITEM
	JMP	DISPLAY_ITEM

DISPLAY_ITEM:
	JSR	PRESELECT_ITEM
DSIT00:	LDA	SELECTED_ITEM
	CMP	#0	;no items to show
	BNE	DSIT01
	;add routine to draw blank space
	RTS
DSIT01:	CMP	#5	;number too high!
	BNE	DSIT0A
	LDA	#0
	STA	SELECTED_ITEM
	RTS
DSIT0A:	CMP	#1	;bomb
	BNE	DSIT03
	LDA	INV_BOMBS
	CMP	#0	;did we run out?
	BNE	DSIT02
	INC	SELECTED_ITEM
	JMP	DSIT00
DSIT02:	JSR	DISPLAY_TIMEBOMB
	RTS
DSIT03:	CMP	#2	;emp
	BNE	DSIT05
	LDA	INV_EMP
	CMP	#0	;did we run out?
	BNE	DSIT04
	INC	SELECTED_ITEM
	JMP	DSIT00
DSIT04:	JSR	DISPLAY_EMP
	RTS
DSIT05:	CMP	#3	;medkit
	BNE	DSIT07
	LDA	INV_MEDKIT
	CMP	#0	;did we run out?
	BNE	DSIT06
	INC	SELECTED_ITEM
	JMP	DSIT00
DSIT06:	JSR	DISPLAY_MEDKIT
	RTS
DSIT07:	CMP	#4	;magnet
	BNE	DSIT09
	LDA	INV_MAGNET
	CMP	#0	;did we run out?
	BNE	DSIT08
	INC	SELECTED_ITEM
	JMP	DSIT09
DSIT08:	JSR	DISPLAY_MAGNET
	RTS
DSIT09:	LDA	#0
	STA	SELECTED_ITEM
	JSR	PRESELECT_ITEM
	JMP	DISPLAY_ITEM

;This routine checks to see if currently selected
;item is zero.  And if it is, then it checks inventories
;of other items to decide which item to automatically
;select for the user.
PRESELECT_ITEM:
	LDA	SELECTED_ITEM
	CMP	#0		;If item already selected, return
	BEQ	PRSI01
	RTS	
PRSI01:	LDA	INV_BOMBS
	CMP	#0
	BEQ	PRSI02
	LDA	#1	;BOMB
	STA	SELECTED_ITEM
	RTS
PRSI02:	LDA	INV_EMP
	CMP	#0
	BEQ	PRSI03
	LDA	#2	;EMP
	STA	SELECTED_ITEM
	RTS
PRSI03:	LDA	INV_MEDKIT
	CMP	#0
	BEQ	PRSI04
	LDA	#3	;MEDKIT
	STA	SELECTED_ITEM
	RTS
PRSI04:	LDA	INV_MAGNET
	CMP	#0
	BEQ	PRSI05
	LDA	#4	;MAGNET
	STA	SELECTED_ITEM
	RTS
PRSI05:	;Nothing found in inventory at this point, so set
	;selected-item to zero.
	LDA	#0	;nothing in inventory
	STA	SELECTED_ITEM
	JSR	DISPLAY_BLANK_ITEM
	RTS

DISPLAY_TIMEBOMB:
	LDY	#0
DTB1:	LDA	TBOMB1A,Y
	STA	$10DE,Y
	LDA	TBOMB1B,Y
	STA	$10F7,Y
	LDA	TBOMB1C,Y
	STA	$1110,Y
	LDA	TBOMB1D,Y
	STA	$1129,Y
	LDA	TBOMB1E,Y
	STA	$94DE,Y
	LDA	TBOMB1F,Y
	STA	$94F7,Y
	LDA	TBOMB1G,Y
	STA	$9510,Y
	LDA	TBOMB1H,Y
	STA	$9529,Y
	INY
	CPY	#3
	BNE	DTB1
	LDA	INV_BOMBS
	STA	DECNUM
	LDA	#$42
	STA	$FB
	LDA	#$11
	STA	$FC
	JSR	DECWRITE	
	RTS

DISPLAY_EMP:
	LDY	#0
DEM1:	LDA	EMP1A,Y
	STA	$10DE,Y
	LDA	EMP1B,Y
	STA	$10F7,Y
	LDA	EMP1C,Y
	STA	$1110,Y
	LDA	EMP1D,Y
	STA	$1129,Y
	LDA	EMP1E,Y
	STA	$94DE,Y
	LDA	EMP1F,Y
	STA	$94F7,Y
	LDA	EMP1G,Y
	STA	$9510,Y
	LDA	EMP1H,Y
	STA	$9529,Y
	INY
	CPY	#3
	BNE	DEM1
	LDA	INV_EMP
	STA	DECNUM
	LDA	#$42
	STA	$FB
	LDA	#$11
	STA	$FC
	JSR	DECWRITE	
	RTS

DISPLAY_MEDKIT:
	LDY	#0
DMK1:	LDA	MED1A,Y
	STA	$10DE,Y
	LDA	MED1B,Y
	STA	$10F7,Y
	LDA	MED1C,Y
	STA	$1110,Y
	LDA	MED1D,Y
	STA	$1129,Y
	LDA	MED1E,Y
	STA	$94DE,Y
	LDA	MED1F,Y
	STA	$94F7,Y
	LDA	MED1G,Y
	STA	$9510,Y
	LDA	MED1H,Y
	STA	$9529,Y
	INY
	CPY	#3
	BNE	DMK1
	LDA	INV_MEDKIT
	STA	DECNUM
	LDA	#$42
	STA	$FB
	LDA	#$11
	STA	$FC
	JSR	DECWRITE	
	RTS

DISPLAY_MAGNET:
	LDY	#0
DMG1:	LDA	MAG1A,Y
	STA	$10DE,Y
	LDA	MAG1B,Y
	STA	$10F7,Y
	LDA	MAG1C,Y
	STA	$1110,Y
	LDA	MAG1D,Y
	STA	$1129,Y
	LDA	MAG1E,Y
	STA	$94DE,Y
	LDA	MAG1F,Y
	STA	$94F7,Y
	LDA	MAG1G,Y
	STA	$9510,Y
	LDA	MAG1H,Y
	STA	$9529,Y
	INY
	CPY	#3
	BNE	DMG1
	LDA	INV_MAGNET
	STA	DECNUM
	LDA	#$42
	STA	$FB
	LDA	#$11
	STA	$FC
	JSR	DECWRITE	
	RTS

DISPLAY_BLANK_ITEM:
	LDY	#0
DBI1:	LDA	#32
	STA	$10DE,Y
	STA	$10F7,Y
	STA	$1110,Y
	STA	$1129,Y
	STA	$1142,Y
	INY
	CPY	#3
	BNE	DBI1
	RTS

CYCLE_WEAPON:
	LDA	#12		;CHANGE WEAPON-SOUND
	JSR	PLAY_SOUND	;SOUND PLAY
	LDA	#20
	STA	KEYTIMER
	INC	SELECTED_WEAPON
	LDA	SELECTED_WEAPON
	CMP	#2
	BNE	CYWE1
	JMP	DISPLAY_WEAPON
CYWE1:	LDA	#0
	STA	SELECTED_WEAPON
	JMP	DISPLAY_WEAPON

DISPLAY_WEAPON:
	JSR	PRESELECT_WEAPON
	LDA	SELECTED_WEAPON
	CMP	#0	;no weapon to show
	BNE	DSWP01
	;add routine to draw blank space
	RTS
DSWP01:	CMP	#1	;PISTOL
	BNE	DSWP03
	LDA	AMMO_PISTOL
	CMP	#0	;did we run out?
	BNE	DSWP02
	LDA	#0
	STA	SELECTED_WEAPON
	JMP	DISPLAY_WEAPON
DSWP02:	JSR	DISPLAY_PISTOL
	RTS
DSWP03:	CMP	#2	;PLASMA GUN
	BNE	DSWP05
	LDA	AMMO_PLASMA
	CMP	#0	;did we run out?
	BNE	DSWP04
	LDA	#0
	STA	SELECTED_WEAPON
	JMP	DISPLAY_WEAPON
DSWP04:	JSR	DISPLAY_PLASMA_GUN
	RTS
DSWP05:	LDA	#0
	STA	SELECTED_WEAPON	;should never happen
	JMP	DISPLAY_WEAPON
	
;This routine checks to see if currently selected
;weapon is zero.  And if it is, then it checks inventories
;of other weapons to decide which item to automatically
;select for the user.
PRESELECT_WEAPON:
	LDA	SELECTED_WEAPON
	CMP	#0		;If item already selected, return
	BEQ	PRSW01
	RTS	
PRSW01:	LDA	AMMO_PISTOL
	CMP	#0
	BEQ	PRSW02
	LDA	#1	;PISTOL
	STA	SELECTED_WEAPON
	RTS
PRSW02:	LDA	AMMO_PLASMA
	CMP	#0
	BEQ	PRSW04
	LDA	#2	;PLASMAGUN
	STA	SELECTED_WEAPON
	RTS
PRSW04:	;Nothing found in inventory at this point, so set
	;selected-item to zero.
	LDA	#0	;nothing in inventory
	STA	SELECTED_WEAPON
	JSR	DISPLAY_BLANK_WEAPON
	RTS

DISPLAY_PISTOL:
	LDY	#0
DW2:	LDA	PISTOL1A,Y
	STA	$102F,Y
	LDA	PISTOL1B,Y
	STA	$1048,Y
	LDA	PISTOL1C,Y
	STA	$1061,Y
	LDA	PISTOL1D,Y
	STA	$107A,Y
	LDA	PISTOL1E,Y
	STA	$942F,Y
	LDA	PISTOL1F,Y
	STA	$9448,Y
	LDA	PISTOL1G,Y
	STA	$9461,Y
	LDA	PISTOL1H,Y
	STA	$947A,Y
	INY
	CPY	#3
	BNE	DW2
	LDA	AMMO_PISTOL
	STA	DECNUM
	LDA	#$93
	STA	$FB
	LDA	#$10
	STA	$FC
	JSR	DECWRITE	
	RTS

DISPLAY_PLASMA_GUN:
	LDY	#0
DW1:	LDA	WEAPON1A,Y
	STA	$102F,Y
	LDA	WEAPON1B,Y
	STA	$1048,Y
	LDA	WEAPON1C,Y
	STA	$1061,Y
	LDA	WEAPON1D,Y
	STA	$107A,Y
	LDA	WEAPON1E,Y
	STA	$942F,Y
	LDA	WEAPON1F,Y
	STA	$9448,Y
	LDA	WEAPON1G,Y
	STA	$9461,Y
	LDA	WEAPON1H,Y
	STA	$947A,Y
	INY
	CPY	#3
	BNE	DW1
	LDA	AMMO_PLASMA
	STA	DECNUM
	LDA	#$93
	STA	$FB
	LDA	#$10
	STA	$FC
	JSR	DECWRITE	
	RTS

DISPLAY_BLANK_WEAPON:
	LDY	#0
DBW2:	LDA	#32
	STA	$102F,Y
	STA	$1048,Y
	STA	$1061,Y
	STA	$107A,Y
	STA	$1093,Y
	INY
	CPY	#6
	BNE	DBW2
	RTS	

GAME_OVER:
	;Did player die or win?
	LDA	UNIT_TYPE
	CMP	#0
	BNE	GOM0
	LDA	#111	;dead player tile
	STA	UNIT_TILE
	LDA	#100
	STA	KEYTIMER
GOM0:	JSR	BACKGROUND_TASKS
	LDA	KEYTIMER
	CMP	#0
	BNE	GOM0
	;stop screen shake
	LDA	#0
	STA	SCREEN_SHAKE
	LDX	#0
GOM1:	LDA	GAMEOVER1,X
	STA	$10E6,X
	LDA	GAMEOVER2,X
	STA	$10FF,X
	LDA	GAMEOVER3,X
	STA	$1118,X
	LDA	#01	;COLOR WHITE
	STA	$94E6,X
	STA	$94FF,X
	STA	$9518,X
	INX
	CPX	#11
	BNE	GOM1
	LDA	#100
	STA	KEYTIMER
GOM2:	LDA	KEYTIMER
	CMP	#0
	BNE	GOM2
	LDA	#0
	STA	$00C6	;CLEAR KEYBOARD BUFFER
GOM3:	JSR	$FFE4
	CMP	#$00
	BEQ	GOM3
GOM4:	LDA	#0
	STA	$00C6	;CLEAR KEYBOARD BUFFER
	LDA	#15		;menu beep
	JSR	PLAY_SOUND	;SOUND PLAY
	JSR	DISPLAY_ENDGAME_SCREEN
GOM5:	JSR	$FFE4
	CMP	#$00
	BEQ	GOM5
	LDA	#0
	STA	$009E	;CLEAR KEYBOARD BUFFER	
	JMP	INTRO_SCREEN

GAMEOVER1:	!BYTE	$70,$40,$40,$40,$40,$40,$40,$40,$40,$40,$6e
GAMEOVER2:	!BYTE	$5d,$07,$01,$0d,$05,$20,$0f,$16,$05,$12,$5d
GAMEOVER3:	!BYTE	$6d,$40,$40,$40,$40,$40,$40,$40,$40,$40,$7d

PRINT_INTRO_MESSAGE:
	LDA	#<INTRO_MESSAGE
	STA	$FB
	LDA	#>INTRO_MESSAGE
	STA	$FC
	JSR	PRINT_INFO
	RTS

;This routine will print something to the "information" window
;at the bottom left of the screen.  You must first define the 
;source of the text in $FB. The text should terminate with
;a null character.
PRINT_INFO:
	JSR	SCROLL_INFO	;New text always causes a scroll
	LDY	#0
	STY	PRINTX
PI01:	LDA	($FB),Y
	CMP	#0	;null terminates string
	BNE	PI02
	RTS
PI02:	CMP	#255	;return
	BNE	PI03
	LDX	#0
	STX	PRINTX
	JSR	SCROLL_INFO
	JMP	PI04
PI03:	LDX	PRINTX
	STA	$1258,X
	INC	PRINTX
PI04:	INY
	JMP	PI01
PRINTX:	!BYTE 00	;used to store X-cursor location

;This routine scrolls the info screen by one row, clearing
;a new row at the bottom.
SCROLL_INFO:
	LDX	#0
SCI1:	LDA	$123F,X
	STA	$1226,X
	LDA	$1258,X	;BOTTOM ROW
	STA	$123F,X
	INX
	CPX	#18
	BNE	SCI1
	;NOW CLEAR BOTTOM ROW
	LDX	#0
	LDA	#32
SCI2:	STA	$1258,X;BOTTOM ROW
	INX
	CPX	#18
	BNE	SCI2
	RTS

RESET_KEYS_AMMO:
	LDA	#$00
	STA	KEYS
	STA	AMMO_PISTOL
	STA	AMMO_PLASMA
	STA	INV_BOMBS
	STA	INV_EMP		
	STA	INV_MEDKIT
	STA	INV_MAGNET	
	STA	SELECTED_WEAPON
	STA	SELECTED_ITEM
	STA	MAGNET_ACT
	STA	PLASMA_ACT
	STA	BIG_EXP_ACT
	RTS

INTRO_SCREEN:
	LDX	#$B4	;find music at $B400
	LDA	#$00
	JSR	PEST_SOUND+$09	;PEST MUSIC LOAD
	JSR	PEST_SOUND+$0C	;PEST MUSIC PLAY
	JSR	DISPLAY_INTRO_SCREEN
	JSR	DISPLAY_MAP_NAME
	JSR	CHANGE_DIFFICULTY_LEVEL
	LDA	#0
	STA	MENUY
	JSR	REVERSE_MENU_OPTION
ISLOOP	JSR	$FFE4
	CMP	#00
	BEQ	ISLOOP
	CMP	#$11	;CURSOR DOWN
	BNE	IS001
IS001A:	LDA	MENUY
	CMP	#3
	BEQ	ISLOOP
	JSR	REVERSE_MENU_OPTION
	INC	MENUY
	JSR	REVERSE_MENU_OPTION
	LDA	#15
	JSR	PEST_SOUND+$15	;SOUND PLAY
	JMP	ISLOOP
IS001:	CMP	#$91	;CURSOR UP
	BNE	IS002
IS002A:	LDA	MENUY
	CMP	#0
	BEQ	ISLOOP
	JSR	REVERSE_MENU_OPTION
	DEC	MENUY
	JSR	REVERSE_MENU_OPTION
	LDA	#15
	JSR	PLAY_SOUND	;SOUND PLAY
	JMP	ISLOOP
IS002:	CMP	#32	;SPACE
	BNE	IS003
	JMP	EXEC_COMMAND
IS003:	CMP	KEY_MOVE_UP
	BNE	IS004
	JMP	IS002A
IS004:	CMP	KEY_MOVE_DOWN
	BNE	IS005
	JMP	IS001A
IS005:	CMP	#13	;RETURN
	BNE	IS006
	LDA	#15		;menu beep
	JSR	PLAY_SOUND	;SOUND PLAY
	JMP	EXEC_COMMAND	
IS006:	JMP	ISLOOP


EXEC_COMMAND:
	LDA	MENUY
	CMP	#00	;START GAME
	BNE	EXEC1
	JSR	SET_CONTROLS
	JSR	PEST_SOUND+$0F	;MUSIC STOP
	LDA	#0
	STA	MUSIC_STATE
	JMP	INIT_GAME
EXEC1:	CMP	#2	;DIFF LEVEL
	BNE	EXEC05
	INC	DIFF_LEVEL
	LDA	DIFF_LEVEL
	CMP	#3
	BNE	EXEC02
	LDA	#0
	STA	DIFF_LEVEL
EXEC02:	JSR	CHANGE_DIFFICULTY_LEVEL
	JMP	ISLOOP
EXEC05:	CMP	#1	;cycle map
	BNE	EXEC06
	JSR	CYCLE_MAP
EXEC06:	CMP	#3
	BNE	EXEC07
	JSR	CYCLE_CONTROLS
EXEC07:	JMP	ISLOOP

CYCLE_CONTROLS:
	INC	CONTROL
	LDA	CONTROL
	CMP	#3
	BNE	CCON2
	LDA	#0
	STA	CONTROL
CCON2:	;display control method on screen
	LDY	CONTROL
	LDA	CONTROLSTART,Y
	TAY
	LDX	#0
CCON3:	LDA	CONTROLTEXT,Y
	ORA	#%10000000
	STA	$105C,X
	INX
	INY
	CPX	#8
	BNE	CCON3
	RTS

CONTROLTEXT:	!SCR"keyset 1"
		!SCR"keyset 2"
		!SCR"snes pad"
CONTROLSTART:	!BYTE 00,8,16

CYCLE_MAP:
	INC	SELECTED_MAP
	LDA	SELECTED_MAP
	CMP	#10	;max number of maps
	BNE	CYM1
	LDA	#0
	STA	SELECTED_MAP
CYM1:	JSR	DISPLAY_MAP_NAME
	RTS

DISPLAY_MAP_NAME:
	LDA	SELECTED_MAP
	STA	DECNUM
	INC	DECNUM
	LDA	#$1A
	STA	$FB
	LDA	#$10
	STA	$FC
	JSR	DECWRITE
	;now set the mapname for the filesystem load
	LDA	SELECTED_MAP
	CLC
	ADC	#65
	STA	MAPNAME+6
	RTS	

REVERSE_MENU_OPTION:
	LDY	MENUY
	LDA	MENU_CHART_L,Y
	STA	$FB
	LDA	#$10
	STA	$FC
	LDY	#0
RMO1:	LDA	($FB),Y
	EOR	#%10000000
	STA	($FB),Y
	INY
	CPY	#8
	BNE	RMO1	
	RTS
MENUY	!BYTE	$00	;CURRENT MENU SELECTION
MENU_CHART_L:
	!BYTE $11,$2A,$43,$5C

CHANGE_DIFFICULTY_LEVEL:
	LDY	DIFF_LEVEL
	LDA	FACE_LEVEL,Y
	TAY
	;DO CHARACTERS FIRST
	LDA	ROBOT_FACE,Y
	STA	$1083
	INY
	LDA	ROBOT_FACE,Y
	STA	$1084
	INY
	LDA	ROBOT_FACE,Y
	STA	$1085
	INY
	LDA	ROBOT_FACE,Y
	STA	$1087
	INY
	LDA	ROBOT_FACE,Y
	STA	$1088
	INY
	LDA	ROBOT_FACE,Y
	STA	$1089
	INY
	LDA	ROBOT_FACE,Y
	STA	$109E
	INY
	LDA	ROBOT_FACE,Y
	STA	$10A0
	;NOW DO COLORS
	INY
	LDA	ROBOT_FACE,Y
	STA	$9483
	INY
	LDA	ROBOT_FACE,Y
	STA	$9484
	INY
	LDA	ROBOT_FACE,Y
	STA	$9485
	INY
	LDA	ROBOT_FACE,Y
	STA	$9487
	INY
	LDA	ROBOT_FACE,Y
	STA	$9488
	INY
	LDA	ROBOT_FACE,Y
	STA	$9489
	RTS
DIFF_LEVEL	!BYTE 01	;default is medium

ROBOT_FACE:
	!BYTE	$3A,$43,$49,$55,$43,$3A,$49,$55,$06,$01,$01,$01,$01,$06	;EASY LEVEL
	!BYTE	$40,$40,$6E,$70,$40,$40,$49,$55,$01,$01,$01,$01,$01,$01	;MEDIUM LEVEL
	!BYTE	$3A,$4D,$3A,$3A,$4E,$3A,$4D,$4E,$02,$01,$02,$02,$01,$02	;HARD LEVEL
FACE_LEVEL:
	!BYTE	0,14,28

;This routine is run after the map is loaded, but before the
;game starts.  If the diffulcty is set to normal, nothing 
;actually happens.  But if it is set to easy or hard, then
;some changes occur accordingly.
SET_DIFF_LEVEL:
	LDA	DIFF_LEVEL
	CMP	#0	;easy
	BNE	SDLE1
	JMP	SET_DIFF_EASY
SDLE1:	CMP	#2	;hard
	BNE	SDLE2
	JMP	SET_DIFF_HARD
SDLE2:	RTS

SET_DIFF_EASY:
	;Find all hidden items and double the quantity.
	LDX	#48
SDE1:	LDA	UNIT_TYPE,X
	CMP	#0
	BEQ	SDE2
	CMP	#128	;KEY
	BEQ	SDE2
	ASL	UNIT_A,X	;item qty
SDE2:	INX
	CPX	#64
	BNE	SDE1	
	RTS

SET_DIFF_HARD:
	;Find all hoverbots and change AI
	LDX	#0
SDH1:	LDA	UNIT_TYPE,X
	CMP	#2	;hoverbot left/right
	BEQ	SDH4
	CMP	#3	;hoverbot up/down
	BEQ	SDH4
SDH2:	INX	
	CPX	#28
	BNE	SDH1
	RTS
SDH4:	LDA	#4	;hoverbot attack mode
	STA	UNIT_TYPE,X
	JMP	SDH2

;This chart contains the left-most staring position for each
;row of tiles on the map-editor. 7 Rows.
MAP_CHART_L:
	!BYTE $00,$4B,$96,$E1,$2C,$77,$C2

MAP_CHART_H:
	!BYTE $10,$10,$10,$10,$11,$11,$11

;This routine animates the tile #204 (water) 
;and also tile 148 (trash compactor)
ANIMATE_WATER:
	LDA	ANIMATE
	CMP	#1
	BEQ	AW00
	RTS
AW00:	INC	WATER_TIMER
	LDA	WATER_TIMER
	CMP	#20
	BEQ	AW01
	RTS
AW01:	LDA	#0
	STA	WATER_TIMER

	LDA	TILE_DATA_BR+204
	STA	WATER_TEMP1
	LDA	TILE_DATA_MM+204
	STA	TILE_DATA_BR+204
	STA	TILE_DATA_BR+221
	LDA	TILE_DATA_TL+204
	STA	TILE_DATA_MM+204
	LDA	WATER_TEMP1
	STA	TILE_DATA_TL+204

	LDA	TILE_DATA_BL+204
	STA	WATER_TEMP1
	LDA	TILE_DATA_MR+204
	STA	TILE_DATA_BL+204
	STA	TILE_DATA_BL+221
	LDA	TILE_DATA_TM+204
	STA	TILE_DATA_MR+204
	LDA	WATER_TEMP1
	STA	TILE_DATA_TM+204
	STA	TILE_DATA_TM+221

	LDA	TILE_DATA_BM+204
	STA	WATER_TEMP1
	LDA	TILE_DATA_ML+204
	STA	TILE_DATA_BM+204
	STA	TILE_DATA_BM+221
	LDA	TILE_DATA_TR+204
	STA	TILE_DATA_ML+204
	LDA	WATER_TEMP1
	STA	TILE_DATA_TR+204
	STA	TILE_DATA_TR+221

		;now do trash compactor
	LDA	TILE_COLOR_TR+148
	STA	WATER_TEMP1
	LDA	TILE_COLOR_TM+148
	STA	TILE_COLOR_TR+148
	LDA	TILE_COLOR_TL+148
	STA	TILE_COLOR_TM+148
	LDA	WATER_TEMP1
	STA	TILE_COLOR_TL+148

	LDA	TILE_COLOR_MR+148
	STA	WATER_TEMP1
	LDA	TILE_COLOR_MM+148
	STA	TILE_COLOR_MR+148
	LDA	TILE_COLOR_ML+148
	STA	TILE_COLOR_MM+148
	LDA	WATER_TEMP1
	STA	TILE_COLOR_ML+148

	LDA	TILE_COLOR_BR+148
	STA	WATER_TEMP1
	LDA	TILE_COLOR_BM+148
	STA	TILE_COLOR_BR+148
	LDA	TILE_COLOR_BL+148
	STA	TILE_COLOR_BM+148
	LDA	WATER_TEMP1
	STA	TILE_COLOR_BL+148

	;Now do HVAC fan
	LDA	HVAC_STATE
	CMP	#0
	BEQ	HVAC1
	LDA	#$CD
	STA	TILE_DATA_MM+196
	STA	TILE_DATA_TL+201
	LDA	#$CE
	STA	TILE_DATA_ML+197
	STA	TILE_DATA_TM+200
	LDA	#$A0
	STA	TILE_DATA_MR+196	
	STA	TILE_DATA_BM+196	
	STA	TILE_DATA_BL+197
	STA	TILE_DATA_TR+200
	LDA	#0
	STA	HVAC_STATE
	JMP	HVAC2
HVAC1:
	LDA	#$A0
	STA	TILE_DATA_MM+196
	STA	TILE_DATA_TL+201
	STA	TILE_DATA_ML+197
	STA	TILE_DATA_TM+200
	LDA	#$C2
	STA	TILE_DATA_MR+196
	STA	TILE_DATA_TR+200
	LDA	#$C0
	STA	TILE_DATA_BM+196	
	STA	TILE_DATA_BL+197
	LDA	#1
	STA	HVAC_STATE
HVAC2:	;now do cinema screen tiles
;	;FIRST COPY OLD LETTERS TO THE LEFT.
;	LDA	TILE_DATA_MR+20	;#2
;	STA	TILE_DATA_MM+20	;#1
;	LDA	TILE_DATA_ML+21	;#3
;	STA	TILE_DATA_MR+20	;#2
;	LDA	TILE_DATA_MM+21	;#4
;	STA	TILE_DATA_ML+21	;#3
;	LDA	TILE_DATA_MR+21	;#5
;	STA	TILE_DATA_MM+21	;#4
;	LDA	TILE_DATA_ML+22	;#6
;	STA	TILE_DATA_MR+21	;#5
;	;now insert new character.
;	LDY	CINEMA_STATE
;	LDA	CINEMA_MESSAGE,Y
;	STA	TILE_DATA_ML+22	;#6
;	INC	CINEMA_STATE
;	LDA	CINEMA_STATE
;	CMP	#197
;	BNE	CINE2
;	LDA	#0
;	STA	CINEMA_STATE
;CINE2:	;Now animate light on server computers
;	LDA	TILE_DATA_MR+143
;	CMP	#$D7
;	BNE	CINE3
;	LDA	#$D1
;	JMP	CINE4
;CINE3:	LDA	#$D7
;CINE4:	STA	TILE_DATA_MR+143
	LDA	#1
	STA	REDRAW_WINDOW
	RTS
WATER_TIMER	!BYTE 00
WATER_TEMP1	!BYTE 00
HVAC_STATE	!BYTE 00
;CINEMA_STATE	!BYTE 00

;This is the routine that allows a person to select
;a level and highlights the selection in the information
;display. It is unique to each computer since it writes
;to the screen directly.
ELEVATOR_SELECT:
	JSR	DRAW_MAP_WINDOW
	LDX	UNIT
	LDA	UNIT_D,X	;get max levels
	STA	ELEVATOR_MAX_FLOOR
	;Now draw available levels on screen
	LDY	#0
	LDA	#$31
ELS1:	STA	$125E,Y
	CLC
	ADC	#01
	INY
	CPY	ELEVATOR_MAX_FLOOR
	BNE	ELS1
	LDA	UNIT_C,X		;what level are we on now?
	STA	ELEVATOR_CURRENT_FLOOR
	;Now highlight current level
	JSR	ELEVATOR_INVERT
	;Now get user input
	LDA	CONTROL	
	CMP	#2
	BNE	ELS5
	JMP	SELS5
ELS5:	;KEYBOARD INPUT
	JSR	$FFE4
	CMP	#$00
	BEQ	ELS5
	CMP	KEY_MOVE_LEFT
	BNE	ELS6
	JSR	ELEVATOR_DEC
	JMP	ELS5
ELS6:	CMP	KEY_MOVE_RIGHT
	BNE	ELS7
	JSR	ELEVATOR_INC
	JMP	ELS5
ELS7:	CMP	#$9D	;CURSOR LEFT
	BNE	ELS8
	JSR	ELEVATOR_DEC
	JMP	ELS5
ELS8:	CMP	#$1D	;CURSOR RIGHT
	BNE	ELS9
	JSR	ELEVATOR_INC
	JMP	ELS5
ELS9:	CMP	#$11	;CURSOR DOWN
	BNE	ELS10
ELS9B:	JSR	SCROLL_INFO
	JSR	SCROLL_INFO
	JSR	SCROLL_INFO
	JSR	CLEAR_KEY_BUFFER
	RTS
ELS10:	CMP	KEY_MOVE_DOWN
	BEQ	ELS9B
ELS11:	JMP	ELS5

SELS5:	;SNES INPUT
	JSR	SNES_CONTROLER_READ
	LDA	NEW_LEFT
	CMP	#1	
	BNE	SELS8
	JSR	ELEVATOR_DEC
	LDA	#0
	STA	NEW_LEFT
	JMP	SELS5
SELS8:	LDA	NEW_RIGHT
	CMP	#1
	BNE	SELS9
	JSR	ELEVATOR_INC
	LDA	#0
	STA	NEW_RIGHT
	JMP	SELS5
SELS9:	LDA	NEW_DOWN
	CMP	#1	
	BNE	SELS10
	JSR	SCROLL_INFO
	JSR	SCROLL_INFO
	JSR	SCROLL_INFO
	LDA	#15
	STA	KEYTIMER
	LDA	#0
	STA	NEW_DOWN
	RTS
SELS10:	JMP	SELS5

ELEVATOR_MAX_FLOOR	!BYTE 00
ELEVATOR_CURRENT_FLOOR	!BYTE 00

ELEVATOR_INVERT:
	LDY	ELEVATOR_CURRENT_FLOOR
	LDA	$125D,Y
	EOR	#%10000000
	STA	$125D,Y	
	RTS
ELEVATOR_INC:
	LDA	ELEVATOR_CURRENT_FLOOR
	CMP	ELEVATOR_MAX_FLOOR
	BNE	ELVIN1
	RTS
ELVIN1:	JSR	ELEVATOR_INVERT
	INC	ELEVATOR_CURRENT_FLOOR
	JSR	ELEVATOR_INVERT
	JSR	ELEVATOR_FIND_XY
	RTS
ELEVATOR_DEC:
	LDA	ELEVATOR_CURRENT_FLOOR
	CMP	#1
	BNE	ELVDE1
	RTS
ELVDE1:	JSR	ELEVATOR_INVERT
	DEC	ELEVATOR_CURRENT_FLOOR
	JSR	ELEVATOR_INVERT
	JSR	ELEVATOR_FIND_XY
	RTS

ELEVATOR_FIND_XY:
	LDX	#32	;start of doors
ELXY1:	LDA	UNIT_TYPE,X
	CMP	#19	;elevator
	BNE	ELXY5
	LDA	UNIT_C,X
	CMP	ELEVATOR_CURRENT_FLOOR
	BNE	ELXY5
	JMP	ELXY10
ELXY5:	INX
	CPX	#48
	BNE	ELXY1
	RTS
ELXY10:	LDA	UNIT_LOC_X,X	;new elevator location
	STA	UNIT_LOC_X	;player location
	SEC
	SBC	#3
	STA	MAP_WINDOW_X
	LDA	UNIT_LOC_Y,X	;new elevator location
	STA	UNIT_LOC_Y	;player location
	DEC	UNIT_LOC_Y
	SEC
	SBC	#4
	STA	MAP_WINDOW_Y
	JSR	DRAW_MAP_WINDOW
	LDA	#17	;elevator sound
	JSR	PLAY_SOUND	;SOUND PLAY
	RTS

SET_CONTROLS:
	LDA	CONTROL
	CMP	#1	;alternate keyset
	BNE	SETC1
	LDY	#0
SETC3:	LDA	ALTERNATE_CONTROLS,Y
	STA	KEY_MOVE_UP,Y
	INY
	CPY	#13
	BNE	SETC3
	RTS		
SETC1:	;load standard values for key controls
	LDY	#0
SETC2:	LDA	STANDARD_CONTROLS,Y
	STA	KEY_MOVE_UP,Y
	INY
	CPY	#13
	BNE	SETC2
	RTS

;This is technically part of a background routine, but it has to
;be here in the main code because the screen effects are unique
;to each system.
DEMATERIALIZE:
	LDX	UNIT
	LDA	UNIT_TIMER_B,X
	AND	#%00000001
	CLC
	ADC	#160	;dematerialize tile
	STA	UNIT_TILE
	LDA	UNIT_TIMER_B,X
	AND	#%00001000
	LSR
	LSR
	LSR
	ADC	UNIT_TILE
	STA	UNIT_TILE
	INC	UNIT_TIMER_B,X
	LDA	UNIT_TIMER_B,X
	CMP	#%00010000
	BEQ	DEMA1
	LDA	#1
	STA	UNIT_TIMER_A,X
	LDA	#1
	STA	REDRAW_WINDOW
	JMP	AILP
DEMA1:	;TRANSPORT COMPLETE
	LDA	UNIT_B,X
	CMP	#1		;transport somewhere
	BEQ	DEMA2
	LDA	#2		;this means game over condition
	STA	UNIT_TYPE	;player type
	LDA	#7		;Normal transporter pad
	STA	UNIT_TYPE,X
	JMP	AILP
DEMA2:	LDA	#97
	STA	UNIT_TILE
	LDA	UNIT_C,X	;target X coordinates
	STA	UNIT_LOC_X
	LDA	UNIT_D,X	;target Y coordinates
	STA	UNIT_LOC_Y
	LDA	#7		;Normal transporter pad
	STA	UNIT_TYPE,X
	JSR	CACULATE_AND_REDRAW
	JMP	AILP

STANDARD_CONTROLS:
	!BYTE	73	;MOVE UP
	!BYTE	75	;MOVE DOWN
	!BYTE	74	;MOVE LEFT
	!BYTE	76	;MOVE RIGHT
	!BYTE	87	;FIRE UP
	!BYTE	83	;FIRE DOWN
	!BYTE	65	;FIRE LEFT
	!BYTE	68	;FIRE RIGHT
	!BYTE	133	;CYCLE WEAPONS
	!BYTE	134	;CYCLE ITEMS
	!BYTE	32	;USE ITEM
	!BYTE	90	;SEARCH OBEJCT
	!BYTE	77	;MOVE OBJECT

ALTERNATE_CONTROLS:
	!BYTE	87	;MOVE UP
	!BYTE	83	;MOVE DOWN
	!BYTE	65	;MOVE LEFT
	!BYTE	68	;MOVE RIGHT
	!BYTE	73	;FIRE UP
	!BYTE	75	;FIRE DOWN
	!BYTE	74	;FIRE LEFT
	!BYTE	76	;FIRE RIGHT
	!BYTE	133	;CYCLE WEAPONS
	!BYTE	134	;CYCLE ITEMS
	!BYTE	32	;USE ITEM
	!BYTE	90	;SEARCH OBEJCT
	!BYTE	77	;MOVE OBJECT

TOGGLE_MUSIC:
	LDA	MUSIC_STATE
	CMP	#0
	BEQ 	TMU1
	LDA	#0
	STA	MUSIC_STATE
	JSR	PEST_SOUND+$0F
	RTS
TMU1:	LDA	#1
	STA	MUSIC_STATE
	JSR	PEST_SOUND+$0C
	RTS

ANIMATE_PLAYER:
	LDA	PLAYER_ANI
	CMP	#0
	BEQ	PANI1
	LDA	#0
	STA	PLAYER_ANI
	JMP	PANI2	
PANI1:	LDA	#56
	STA	PLAYER_ANI
PANI2:	LDX	#0
	LDY	PLAYER_ANI
	LDA	PLAYER_DIR
	CMP	#0
	BEQ	APU1
	CMP	#1
	BEQ	APD1
	CMP	#2
	BEQ	APL1
	JMP	APR1
APU1:	LDA	PLAYER_UP_1A,Y
	STA	$1400+$0480,X
	LDA	PLAYER_UP_1B,Y
	STA	$1400+$0488,X	
	LDA	PLAYER_UP_1C,Y
	STA	$1400+$04C0,X
	LDA	PLAYER_UP_1D,Y
	STA	$1400+$04D8,X
	LDA	PLAYER_UP_1E,Y
	STA	$1400+$04E0,X
	LDA	PLAYER_UP_1F,Y
	STA	$1400+$04E8,X
	LDA	PLAYER_UP_1G,Y
	STA	$1400+$0510,X
	INY
	INX
	CPX	#8
	BNE	APU1
	RTS
APD1:	LDA	PLAYER_DOWN_1A,Y
	STA	$1400+$0480,X
	LDA	PLAYER_DOWN_1B,Y
	STA	$1400+$0488,X	
	LDA	PLAYER_DOWN_1C,Y
	STA	$1400+$04C0,X
	LDA	PLAYER_DOWN_1D,Y
	STA	$1400+$04D8,X
	LDA	PLAYER_DOWN_1E,Y
	STA	$1400+$04E0,X
	LDA	PLAYER_DOWN_1F,Y
	STA	$1400+$04E8,X
	LDA	PLAYER_DOWN_1G,Y
	STA	$1400+$0510,X
	INY
	INX
	CPX	#8
	BNE	APD1
	RTS
APL1:	LDA	PLAYER_LEFT_1A,Y
	STA	$1400+$0480,X
	LDA	PLAYER_LEFT_1B,Y
	STA	$1400+$0488,X	
	LDA	PLAYER_LEFT_1C,Y
	STA	$1400+$04C0,X
	LDA	PLAYER_LEFT_1D,Y
	STA	$1400+$04D8,X
	LDA	PLAYER_LEFT_1E,Y
	STA	$1400+$04E0,X
	LDA	PLAYER_LEFT_1F,Y
	STA	$1400+$04E8,X
	LDA	PLAYER_LEFT_1G,Y
	STA	$1400+$0510,X
	INY
	INX
	CPX	#8
	BNE	APL1
	RTS
APR1:	LDA	PLAYER_RIGHT_1A,Y
	STA	$1400+$0480,X
	LDA	PLAYER_RIGHT_1B,Y
	STA	$1400+$0488,X	
	LDA	PLAYER_RIGHT_1C,Y
	STA	$1400+$04C0,X
	LDA	PLAYER_RIGHT_1D,Y
	STA	$1400+$04D8,X
	LDA	PLAYER_RIGHT_1E,Y
	STA	$1400+$04E0,X
	LDA	PLAYER_RIGHT_1F,Y
	STA	$1400+$04E8,X
	LDA	PLAYER_RIGHT_1G,Y
	STA	$1400+$0510,X
	INY
	INX
	CPX	#8
	BNE	APR1
	RTS
;CHARACTER $90,$91,$98,$9B,$9C,$9D,$A2

!SOURCE "BACKGROUND_TASKS.ASM"

;These are the included binary files that contain the screen
;image for the main editor.
SCR_TEXT: 
	!BYTE	$60, $20, $14, $5D, $17, $10, $0E, $60, $20, $14, $5D, $60, $20, $02, $60
	!BYTE	$20, $14, $5D, $60, $20, $02, $60, $20, $14, $5D, $60, $20, $02, $60, $20
	!BYTE	$14, $5D, $60, $20, $02, $60, $20, $14, $5D, $60, $20, $02, $60, $20, $14
	!BYTE	$6B, $60, $40, $02, $60, $20, $14, $5D, $09, $14, $0D, $60, $20, $14, $5D
	!BYTE	$60, $20, $02, $60, $20, $14, $5D, $60, $20, $02, $60, $20, $14, $5D, $60
	!BYTE	$20, $02, $60, $20, $14, $5D, $60, $20, $02, $60, $20, $14, $5D, $60, $20
	!BYTE	$02, $60, $20, $14, $6B, $60, $40, $02, $60, $20, $14, $5D, $0B, $05, $19
	!BYTE	$60, $20, $14, $5D, $60, $20, $02, $60, $20, $14, $5D, $60, $20, $02, $60
	!BYTE	$20, $14, $6B, $60, $40, $02, $60, $20, $14, $5D, $60, $20, $02, $60, $20
	!BYTE	$14, $5D, $60, $20, $02, $60, $20, $14, $5D, $60, $20, $02, $73, $09, $0E
	!BYTE	$06, $0F, $6B, $60, $40, $0B, $72, $40, $40, $71, $60, $40, $02, $60, $20
	!BYTE	$11, $5D, $08, $05, $01, $0C, $14, $08, $60, $20, $11, $5D, $60, $20, $17
	!BYTE	$5D, $60, $71, $05, $22

SCR_COLOR: 
	!BYTE	$60, $11, $FF, $60, $11, $A6, $12, $15, $60, $11, $7C, $60, $15, $11
	!BYTE	$60, $11, $06, $60, $15, $11, $60, $11, $06, $60, $15, $11, $11, $12, $12
	!BYTE	$17, $17, $15, $15

;These are the included binary files that contain the screen
;image for the main editor.
INTRO_TEXT: 
	!BYTE	$20, $0D, $01, $10, $60, $20, $03, $E9, $CE, $20, $20, $E9, $CE, $60, $20
	!BYTE	$02, $13, $14, $01, $12, $14, $60, $20, $02, $20, $30, $30, $31, $60, $20
	!BYTE	$03, $66, $A0, $20, $20, $66, $A0, $60, $20, $02, $0D, $01, $10, $20, $13
	!BYTE	$05, $0C, $60, $20, $07, $E9, $66, $CE, $A0, $A0, $66, $CE, $CE, $20, $20
	!BYTE	$13, $0B, $09, $0C, $0C, $60, $20, $08, $E9, $A0, $E3, $60, $A0, $02, $E3
	!BYTE	$60, $CE, $02, $20, $03, $0F, $0E, $14, $12, $0F, $0C, $13, $60, $20, $04
	!BYTE	$E9, $60, $66, $06, $CE, $CE, $A0, $60, $20, $0D, $66, $3A, $43, $49, $3A
	!BYTE	$55, $43, $3A, $66, $A0, $A0, $60, $20, $02, $E9, $CE, $20, $20, $E9, $CE
	!BYTE	$60, $20, $04, $66, $55, $43, $49, $3A, $55, $43, $49, $66, $A0, $A0, $60
	!BYTE	$20, $02, $66, $A0, $20, $20, $66, $A0, $60, $20, $04, $66, $42, $51, $48
	!BYTE	$3A, $42, $51, $48, $66, $A0, $69, $60, $20, $02, $66, $A0, $20, $20, $66
	!BYTE	$A0, $60, $20, $04, $66, $4A, $46, $4B, $3A, $4A, $46, $4B, $66, $CE, $60
	!BYTE	$20, $03, $66, $CE, $A0, $A0, $66, $A0, $60, $20, $05, $60, $66, $06, $A0
	!BYTE	$A0, $60, $20, $03, $60, $66, $04, $69, $60, $20, $05, $66, $60, $D0, $04
	!BYTE	$66, $A0, $A0, $60, $20, $05, $66, $A0, $20, $20, $60, $43, $05, $66, $60
	!BYTE	$D0, $04, $66, $A0, $69, $60, $43, $05, $66, $A0, $43, $43, $60, $3A, $05
	!BYTE	$60, $66, $06, $CE, $A0, $A0, $CE, $60, $3A, $03, $66, $A0, $60, $3A, $07
	!BYTE	$E9, $A0, $A0, $E7, $D0, $CE, $60, $A0, $02, $CE, $A0, $60, $3A, $03, $66
	!BYTE	$A0, $60, $3A, $06, $E9, $60, $A0, $03, $E3, $60, $A0, $02, $CE, $A0, $A0
	!BYTE	$60, $3A, $03, $66, $A0, $60, $3A, $02, $E9, $CE, $DF, $3A, $60, $66, $08
	!BYTE	$D5, $C0, $C9, $60, $3A, $03, $66, $CE, $DF, $3A, $E9, $A0, $CD, $CE, $A0
	!BYTE	$66, $51, $60, $66, $04, $51, $66, $DD, $CE, $E3, $60, $A0, $02, $CE, $A0
	!BYTE	$CD, $CE, $3A, $A0, $D1, $E7, $60, $66, $0A, $DD, $60, $66, $04, $A0, $D1
	!BYTE	$E7, $69, $3A, $5F, $A0, $CE, $3A, $3A, $60, $66, $08, $CA, $C0, $CB, $60
	!BYTE	$3A, $02, $5F, $E4, $69, $3A, $3A, $E9, $A0, $A0, $CE, $3A, $E9, $A0, $A0
	!BYTE	$CE, $E9, $A0, $CE, $3A, $E9, $A0, $A0, $CE, $E9, $A0, $A0, $CE, $E9, $A0
	!BYTE	$A0, $CE, $60, $66, $02, $CE, $CE, $60, $66, $02, $A0, $66, $66, $CE, $CE
	!BYTE	$60, $66, $02, $A0, $60, $66, $02, $69, $60, $66, $02, $69, $66, $CE, $A0
	!BYTE	$66, $CE, $66, $A0, $66, $A0, $66, $CE, $66, $69, $66, $A0, $66, $A0, $3A
	!BYTE	$66, $A0, $3A, $66, $CE, $A0, $CE, $60, $66, $02, $CE, $CE, $66, $A0, $66
	!BYTE	$A0, $66, $66, $CE, $CE, $66, $A0, $66, $A0, $3A, $66, $A0, $3A, $60, $66
	!BYTE	$02, $A0, $66, $A0, $3A, $66, $A0, $66, $CE, $66, $A0, $66, $CE, $66, $69
	!BYTE	$66, $CE, $66, $A0, $3A, $66, $A0, $3A, $3A, $E9, $66, $A0, $66, $69, $3A
	!BYTE	$66, $69, $60, $66, $02, $69, $66, $66, $69, $3A, $60, $66, $02, $69, $3A
	!BYTE	$66, $69, $3A, $60, $66, $02, $69

INTRO_COLOR: 
	!BYTE	$60, $25, $03, $60, $21, $03, $23, $23, $21, $21, $23, $23, $60, $21, $02
	!BYTE	$60, $25, $0B, $60, $21, $02, $2C, $22, $23, $21, $21, $22, $23, $60, $21
	!BYTE	$02, $60, $25, $09, $60, $21, $04, $23, $22, $60, $23, $02, $22, $23, $23
	!BYTE	$21, $21, $60, $25, $09, $60, $21, $03, $60, $23, $09, $21, $60, $25, $09
	!BYTE	$60, $21, $02, $23, $60, $22, $06, $60, $23, $02, $60, $21, $08, $25, $25
	!BYTE	$60, $21, $02, $22, $26, $21, $21, $22, $21, $21, $26, $22, $23, $23, $60
	!BYTE	$21, $02, $23, $23, $21, $21, $23, $23, $25, $25, $60, $21, $02, $22, $60
	!BYTE	$21, $02, $22, $60, $21, $02, $22, $23, $23, $60, $21, $02, $22, $23, $21
	!BYTE	$21, $22, $23, $25, $60, $21, $03, $22, $21, $22, $21, $22, $21, $22, $21
	!BYTE	$22, $23, $23, $60, $21, $02, $22, $23, $21, $23, $22, $23, $25, $60, $21
	!BYTE	$03, $22, $60, $21, $02, $22, $60, $21, $02, $22, $23, $2C, $60, $21, $02
	!BYTE	$22, $60, $23, $02, $22, $23, $60, $25, $04, $21, $60, $22, $06, $23, $23
	!BYTE	$60, $21, $03, $60, $22, $04, $23, $60, $21, $05, $22, $60, $21, $04, $22
	!BYTE	$23, $23, $60, $21, $05, $22, $23, $21, $21, $60, $26, $05, $22, $60, $21
	!BYTE	$04, $22, $23, $23, $60, $26, $05, $22, $23, $60, $26, $07, $60, $22, $06
	!BYTE	$60, $23, $03, $60, $26, $03, $22, $23, $60, $26, $07, $60, $23, $03, $28
	!BYTE	$60, $23, $05, $60, $26, $03, $22, $23, $60, $26, $06, $60, $23, $0B, $60
	!BYTE	$26, $03, $22, $23, $60, $26, $02, $60, $23, $02, $26, $60, $22, $08, $60
	!BYTE	$23, $02, $60, $26, $03, $22, $23, $23, $26, $60, $23, $04, $22, $21, $60
	!BYTE	$22, $04, $21, $22, $60, $23, $09, $26, $60, $23, $02, $60, $22, $0A, $23
	!BYTE	$60, $22, $04, $60, $23, $03, $26, $60, $23, $02, $26, $26, $60, $22, $08
	!BYTE	$60, $23, $02, $60, $26, $02, $60, $23, $02, $60, $26, $1A, $60, $21, $02
	!BYTE	$26, $26, $60, $21, $02, $26, $21, $21, $26, $26, $60, $21, $02, $26, $60
	!BYTE	$21, $02, $26, $60, $21, $02, $26, $21, $26, $26, $21, $26, $21, $26, $21
	!BYTE	$26, $21, $26, $21, $26, $21, $26, $21, $26, $26, $21, $26, $26, $21, $60
	!BYTE	$26, $02, $60, $21, $02, $26, $26, $21, $26, $21, $26, $21, $21, $26, $26
	!BYTE	$21, $26, $21, $26, $26, $21, $26, $26, $60, $21, $02, $26, $21, $26, $26
	!BYTE	$21, $26, $21, $26, $21, $26, $21, $26, $21, $26, $21, $26, $21, $26, $26
	!BYTE	$21, $60, $26, $03, $21, $26, $21, $26, $26, $21, $26, $60, $21, $02, $26
	!BYTE	$21, $21, $26, $26, $60, $21, $02, $26, $26, $21, $26, $26, $60, $21, $02
	!BYTE	$26

SCR_ENDGAME:
	!BYTE	$55, $60, $40, $03, $73, $16, $09, $03, $2D, $32, $30, $20, $12, $0F, $02
	!BYTE	$0F, $14, $13, $6B, $60, $40, $03, $49, $5D, $60, $20, $16, $5D, $5D, $60
	!BYTE	$20, $16, $5D, $5D, $60, $20, $16, $5D, $5D, $60, $20, $16, $5D, $5D, $60
	!BYTE	$20, $16, $5D, $5D, $60, $20, $16, $5D, $5D, $60, $20, $06, $13, $03, $05
	!BYTE	$0E, $01, $12, $09, $0F, $60, $20, $07, $5D, $5D, $60, $20, $16, $5D, $5D
	!BYTE	$60, $20, $16, $5D, $5D, $60, $20, $10 
	!BYTE	$60, $20, $05, $5D, $5D, $60, $20, $16, $5D, $5D
	!BYTE	$60, $20, $16, $5D, $5D, $60, $20, $02, $12, $0F, $02, $0F, $14, $13, $20
	!BYTE	$12, $05, $0D, $01, $09, $0E, $09, $0E, $07, $60, $20, $03, $5D, $5D, $60
	!BYTE	$20, $16, $5D, $5D, $60, $20, $16, $5D, $5D, $60, $20, $02, $13, $05, $03
	!BYTE	$12, $05, $14, $13, $20, $12, $05, $0D, $01, $09, $0E, $09, $0E, $07, $60
	!BYTE	$20, $02, $5D, $5D, $60, $20, $16, $5D, $5D, $60, $20, $16, $5D, $5D, $60
	!BYTE	$20, $16, $5D, $5D, $60, $20, $16, $5D, $5D, $60, $20, $16, $5D, $5D, $60
	!BYTE	$20, $16, $5D, $5D, $60, $20, $16, $5D, $4A, $60, $40, $16, $4B

;CINEMA_MESSAGE:
;	!SCR"coming soon: space balls 2 - the search for more money, "
;	!SCR"attack of the paperclips: clippy's revenge, "
;	!SCR"it came from planet earth, "
;	!SCR"rocky 5000, all my circuits the movie, "
;	!SCR"conan the librarian, and more! " 

;Pistol (VIC-20)
PISTOL1A	!BYTE	$20,$20,$20
PISTOL1B	!BYTE	$E2,$F5,$F6
PISTOL1C	!BYTE	$20,$20,$F4
PISTOL1D	!BYTE	$20,$20,$20
;Color for Blaster Gun (VIC-20)
PISTOL1E	!BYTE	$01,$01,$01
PISTOL1F	!BYTE	$05,$05,$05
PISTOL1G	!BYTE	$01,$01,$01
PISTOL1H	!BYTE	$01,$01,$01

;Blaster Gun (VIC-20)
WEAPON1A	!BYTE	$20,$20,$2c
WEAPON1B	!BYTE	$e2,$ef,$66
WEAPON1C	!BYTE	$20,$20,$F4
WEAPON1D	!BYTE	$20,$20,$20
;Color for Blaster Gun (VIC-20)
WEAPON1E	!BYTE	$01,$01,$01
WEAPON1F	!BYTE	$03,$03,$06
WEAPON1G	!BYTE	$01,$01,$01
WEAPON1H	!BYTE	$01,$01,$01

;Time Bomb  (VIC-20)
TBOMB1A	!BYTE	$20,$55,$2a
TBOMB1B	!BYTE	$55,$66,$49
TBOMB1C	!BYTE	$42,$20,$48
TBOMB1D	!BYTE	$4a,$46,$4b
;Color for Time Bomb (VIC-20)
TBOMB1E	!BYTE	$01,$02,$07
TBOMB1F	!BYTE	$03,$03,$03
TBOMB1G	!BYTE	$03,$01,$03
TBOMB1H	!BYTE	$03,$03,$03

;EMP (VIC-20)
EMP1A	!BYTE	$55,$43,$49
EMP1B	!BYTE	$DF,$51,$E9
EMP1C	!BYTE	$69,$57,$5F
EMP1D	!BYTE	$4A,$46,$4B
;Color for EMP (VIC-20)
EMP1E	!BYTE	$02,$02,$02
EMP1F	!BYTE	$03,$07,$03
EMP1G	!BYTE	$03,$07,$03
EMP1H	!BYTE	$02,$02,$02

;Magnet (VIC-20)
MAG1A	!BYTE	$4D,$20,$4E
MAG1B	!BYTE	$70,$E0,$6E
MAG1C	!BYTE	$42,$52,$48
MAG1D	!BYTE	$4A,$46,$4B
;Color for EMP (VIC-20)
MAG1E	!BYTE	$01,$01,$01
MAG1F	!BYTE	$07,$07,$07
MAG1G	!BYTE	$02,$02,$02
MAG1H	!BYTE	$02,$02,$02

;Medkit (VIC-20)
MED1A	!BYTE	$55,$43,$49
MED1B	!BYTE	$A0,$A0,$A0
MED1C	!BYTE	$A0,$E1,$A0
MED1D	!BYTE	$E4,$E4,$E4
;Color for Medkit (VIC-20)
MED1E	!BYTE	$01,$01,$01
MED1F	!BYTE	$01,$01,$01
MED1G	!BYTE	$01,$01,$01
MED1H	!BYTE	$01,$01,$01

;****PLAYER TILE BITMAPS****
;CHARACTER $90,$91,$98,$9B,$9C,$9D,$A2

PLAYER_DOWN_1A:			;facing down step 1
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000111
	!BYTE	%00001111
	!BYTE	%00011111
	!BYTE	%00011111
PLAYER_DOWN_1B:
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%11000000 
	!BYTE	%11100000
	!BYTE	%11100000
	!BYTE	%11101100
PLAYER_DOWN_1C:
	!BYTE	%00011111
	!BYTE	%00010111
	!BYTE	%00001000
	!BYTE	%00000100
	!BYTE	%00000011
	!BYTE	%00000011
	!BYTE	%00000001
	!BYTE	%00000001
PLAYER_DOWN_1D:
	!BYTE	%11100011
	!BYTE	%10100000
	!BYTE	%00100010
	!BYTE	%01000011
	!BYTE	%10000111
	!BYTE	%10011001
	!BYTE	%10000000
	!BYTE	%10100001
PLAYER_DOWN_1E:
	!BYTE	%00000000
	!BYTE	%10000000
	!BYTE	%01000000
	!BYTE	%10100000
	!BYTE	%01010000
	!BYTE	%10111000
	!BYTE	%10011000
	!BYTE	%11001000
PLAYER_DOWN_1F:
	!BYTE	%11010011
	!BYTE	%11001111
	!BYTE	%01000111
	!BYTE	%00000001
	!BYTE	%00000001
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
PLAYER_DOWN_1G:
	!BYTE	%11100000
	!BYTE	%01110000
	!BYTE	%10111000
	!BYTE	%10011100
	!BYTE	%10000110
	!BYTE	%00000110
	!BYTE	%00000000
	!BYTE	%00000000

PLAYER_DOWN_2A:			;facing down step 2
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000111
	!BYTE	%00001111
	!BYTE	%00011111
	!BYTE	%00011111
PLAYER_DOWN_2B:
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%11000000
	!BYTE	%11100000
	!BYTE	%11100000
	!BYTE	%11100000
PLAYER_DOWN_2C:
	!BYTE	%00011111
	!BYTE	%00010111
	!BYTE	%00001000
	!BYTE	%00000100
	!BYTE	%00000111
	!BYTE	%00000011
	!BYTE	%00000000
	!BYTE	%00000000
PLAYER_DOWN_2D:
	!BYTE	%11101000
	!BYTE	%10100100
	!BYTE	%00100010
	!BYTE	%01000001
	!BYTE	%10001001
	!BYTE	%10111100
	!BYTE	%10000110
	!BYTE	%01000010
PLAYER_DOWN_2E:
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%10000000
	!BYTE	%10000000
	!BYTE	%11000000
PLAYER_DOWN_2F:
	!BYTE	%00100111
	!BYTE	%00011100
	!BYTE	%00011100
	!BYTE	%00001110
	!BYTE	%00001111
	!BYTE	%00000011
	!BYTE	%00000011
	!BYTE	%00000000
PLAYER_DOWN_2G:
	!BYTE	%11111000
	!BYTE	%01111000
	!BYTE	%00011000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000

PLAYER_UP_1A:			;facing up step 1
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000111
	!BYTE	%00001110
	!BYTE	%00011111
	!BYTE	%00011111
PLAYER_UP_1B:			
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%11000000
	!BYTE	%00100000
	!BYTE	%10010000
	!BYTE	%11010000
PLAYER_UP_1C:			
	!BYTE	%00011111
	!BYTE	%00011111
	!BYTE	%00001111
	!BYTE	%00000111
	!BYTE	%00000011
	!BYTE	%00000011
	!BYTE	%00000001
	!BYTE	%00000000
PLAYER_UP_1D:			
	!BYTE	%11111100
	!BYTE	%11110010
	!BYTE	%11100001
	!BYTE	%10000000
	!BYTE	%10000011
	!BYTE	%11000011
	!BYTE	%11100001
	!BYTE	%11110001
PLAYER_UP_1E:			
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%10000000
	!BYTE	%01000000
	!BYTE	%10100000
	!BYTE	%11110000
	!BYTE	%11110000
PLAYER_UP_1F:			
	!BYTE	%01111111
	!BYTE	%00011110
	!BYTE	%00001111
	!BYTE	%00000111
	!BYTE	%00000011
	!BYTE	%00000001
	!BYTE	%00000000
	!BYTE	%00000000
PLAYER_UP_1G:			
	!BYTE	%11110000
	!BYTE	%11111000
	!BYTE	%11111000
	!BYTE	%10111000
	!BYTE	%10011000
	!BYTE	%10000000
	!BYTE	%00000000
	!BYTE	%00000000

PLAYER_UP_2A:			;facing up step 2
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000111
	!BYTE	%00001110
	!BYTE	%00011111
	!BYTE	%00011111
PLAYER_UP_2B:	
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000		
	!BYTE	%11000000
	!BYTE	%00100000
	!BYTE	%10010000
	!BYTE	%11010000
PLAYER_UP_2C:			
	!BYTE	%00011111
	!BYTE	%00011111
	!BYTE	%00001111
	!BYTE	%00001111
	!BYTE	%00000111
	!BYTE	%00000111
	!BYTE	%00000011
	!BYTE	%00000011
PLAYER_UP_2D:			
	!BYTE	%11111000
	!BYTE	%11110110
	!BYTE	%11100001
	!BYTE	%10000111
	!BYTE	%10000111
	!BYTE	%11000010
	!BYTE	%11000001
	!BYTE	%11100001
PLAYER_UP_2E:			
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%10000000
	!BYTE	%01100000
	!BYTE	%11100000
	!BYTE	%00100000
	!BYTE	%00000000
	!BYTE	%00000000
PLAYER_UP_2F:			
	!BYTE	%11110001
	!BYTE	%10111111
	!BYTE	%10011111
	!BYTE	%10000111
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
PLAYER_UP_2G:			
	!BYTE	%10000000
	!BYTE	%11000000
	!BYTE	%11100000
	!BYTE	%11110000
	!BYTE	%01110000
	!BYTE	%00110000
	!BYTE	%00000000
	!BYTE	%00000000

PLAYER_LEFT_1A:			;facing LEFT step 1
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000111
	!BYTE	%00001111
	!BYTE	%00011111
	!BYTE	%00011111
PLAYER_LEFT_1B:			
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%10000000
	!BYTE	%11000000
	!BYTE	%11100000
	!BYTE	%11110000
PLAYER_LEFT_1C:			
	!BYTE	%00010111
	!BYTE	%00010111
	!BYTE	%00010011
	!BYTE	%00001001
	!BYTE	%00000111
	!BYTE	%00000001
	!BYTE	%00000001
	!BYTE	%00000000
PLAYER_LEFT_1D:			
	!BYTE	%11111100
	!BYTE	%11101110
	!BYTE	%11100111
	!BYTE	%11000011
	!BYTE	%10000001
	!BYTE	%00000000
	!BYTE	%10000000
	!BYTE	%10011000
PLAYER_LEFT_1E:			
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%10000000
	!BYTE	%11000000
	!BYTE	%10000000
	!BYTE	%11000000
	!BYTE	%11000000
PLAYER_LEFT_1F:			
	!BYTE	%11001101
	!BYTE	%01111111
	!BYTE	%00111111
	!BYTE	%00011101
	!BYTE	%00001110
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
PLAYER_LEFT_1G:			
	!BYTE	%11100000
	!BYTE	%01100000
	!BYTE	%10000000
	!BYTE	%11000000
	!BYTE	%11100000
	!BYTE	%11110000
	!BYTE	%11110000
	!BYTE	%00000000

PLAYER_LEFT_2A:			;facing LEFT step 2
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000111
	!BYTE	%00001111
	!BYTE	%00011111
	!BYTE	%00011111
PLAYER_LEFT_2B:			
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%10000000
	!BYTE	%11000000
	!BYTE	%11100000
	!BYTE	%11111000
PLAYER_LEFT_2C:			
	!BYTE	%00010111
	!BYTE	%00010111
	!BYTE	%00010011
	!BYTE	%00001001
	!BYTE	%00000111
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
PLAYER_LEFT_2D:			
	!BYTE	%11111100
	!BYTE	%11101110
	!BYTE	%11100010
	!BYTE	%11000001
	!BYTE	%10000000
	!BYTE	%11001100
	!BYTE	%01100110
	!BYTE	%01110011
PLAYER_LEFT_2E:			
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%10000000
	!BYTE	%11000000
	!BYTE	%11100000
	!BYTE	%11111000
PLAYER_LEFT_2F:			
	!BYTE	%00111111
	!BYTE	%00011111
	!BYTE	%00011100
	!BYTE	%00011100
	!BYTE	%00001111
	!BYTE	%00001111
	!BYTE	%00000000
	!BYTE	%00000000
PLAYER_LEFT_2G:			
	!BYTE	%01111000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%10000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000

PLAYER_RIGHT_1A:			;facing RIGHT step 1
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000111
	!BYTE	%00001111
	!BYTE	%00011111
	!BYTE	%00011111
PLAYER_RIGHT_1B:
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%10000000
	!BYTE	%11000000
	!BYTE	%10100000
	!BYTE	%10011000
PLAYER_RIGHT_1C:
	!BYTE	%00011111
	!BYTE	%00011111
	!BYTE	%00001111
	!BYTE	%00000111
	!BYTE	%00000011
	!BYTE	%00000011
	!BYTE	%00000011
	!BYTE	%00000001
PLAYER_RIGHT_1D:
	!BYTE	%10010111
	!BYTE	%10010001
	!BYTE	%00100101
	!BYTE	%11000110
	!BYTE	%10000101
	!BYTE	%10000000
	!BYTE	%11000000
	!BYTE	%11110001
PLAYER_RIGHT_1E:
	!BYTE	%00000000
	!BYTE	%10000000
	!BYTE	%11000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%10000000
	!BYTE	%11000000
	!BYTE	%11110000
PLAYER_RIGHT_1F:
	!BYTE	%11111011
	!BYTE	%11101111
	!BYTE	%01110011
	!BYTE	%00111000
	!BYTE	%00011100
	!BYTE	%00001110
	!BYTE	%00000000
	!BYTE	%00000000
PLAYER_RIGHT_1G:
	!BYTE	%01110000
	!BYTE	%10000000
	!BYTE	%11000000
	!BYTE	%11100000
	!BYTE	%01111000
	!BYTE	%00111000
	!BYTE	%00000000
	!BYTE	%00000000

PLAYER_RIGHT_2A:			;facing RIGHT step 2
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000111
	!BYTE	%00001111
	!BYTE	%00011111
	!BYTE	%00011111
PLAYER_RIGHT_2B:		
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%10000000
	!BYTE	%11000000
	!BYTE	%10100000
	!BYTE	%10010000
PLAYER_RIGHT_2C:		
	!BYTE	%00011111
	!BYTE	%00011111
	!BYTE	%00001111
	!BYTE	%00000111
	!BYTE	%00000011
	!BYTE	%00000001
	!BYTE	%00000000
	!BYTE	%00000000
PLAYER_RIGHT_2D:		
	!BYTE	%10010000
	!BYTE	%10010100
	!BYTE	%00100110
	!BYTE	%11000001
	!BYTE	%11000000
	!BYTE	%11100000
	!BYTE	%11111001
	!BYTE	%01111111
PLAYER_RIGHT_2E:		
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%11000000
	!BYTE	%11110000
	!BYTE	%11111100
	!BYTE	%00011100
PLAYER_RIGHT_2F:		
	!BYTE	%00111111
	!BYTE	%00001111
	!BYTE	%00000011
	!BYTE	%00000001
	!BYTE	%00000001
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000
PLAYER_RIGHT_2G:		
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%10000000
	!BYTE	%11000000
	!BYTE	%11000000
	!BYTE	%00000000
	!BYTE	%00000000
	!BYTE	%00000000

;*****Documentation for Alex Semenov's PEST sound system*******
;+$00 pest_init:
; Initialize sound system. Call it once when program starts.
; Clears all variables, init hardware, set up timer IRQ (if required)
; in:  none
; out: none
;  
;+$03 pest_done
; De-initialize sound system. It may be needed before disk operations, so I kept it here just in case.
; Stop sound, restore timer IRQ (if required)
; in:  none
; out: none
; 
;+$06 pest_update
; Update sound system state and produce sounds
; Should be called 50 or 60 times per second, normally from frame interrupt
; in:  none
; out: none
;
;+$09 pest_music_load
; Load music data, initialize music player vars
; in:  X:A pointer to music data, can be located anywhere (music data is relocatable)
; out: none
;
;+$0c pest_music_play
; Start playing music from beginning
; in:  none
; out: none
;
;+$0f pest_music_stop
; Stop playing music
; in:  none
; out: none
; 
;+$12 pest_music_pause
; Pause and resume music
; in:  A=0 unpause, !0 pause
; out: none
; 
;+$15 pest_sound_play
; Request sound effect to be played
; in:  A sound effect number, 0..63
; out: none
; 
;+$18 pest_stop_all
; Stop all sounds, including music and sound effect
; in:  none
; out: none
;
;+$1b pest_detect_rate
; Detect framerate (50/60Hz). Actual detection happens during pest_init, this is just a readback.
; Used internally for music tempo compensation, can be used externally too
; in:  none
; out: A=0 for 60Hz, !0 for 50Hz
