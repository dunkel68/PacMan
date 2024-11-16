INCLUDE Irvine32.inc

.data

start db "P A C - M A N!", 0
strName db "Enter your Name: ", 0
inputName db 255 dup(?), 0
play db "PLAY! (P)", 0
instructions db "INSTRUCTIONS (H)", 0
choice db ?
cnt db 0
udlr db ?
levE dw 0
levE2 dw 0
keyStatus db 0

;ground BYTE "------------------------------------------------------------------------------------------------------------------------",0
maze01 db ",______________________________________________________________________________________________________________________,", 13, 10
	   db "|                                                                                                                      |", 13, 10
	   db "|   ,__________,   ,_____________________________________,   ,____________,   ,__________________,   ,_______,         |", 13, 10
	   db "|   |          |   |                                     |   |           /   /                   |   |       |         |", 13, 10
	   db "|   |  ,____,  |   |     ,_________________________,     |   |          /   /                    |   |       |         |", 13, 10
	   db "|   |  |    |  |   |     |                         |     |   |_________/   /                     |   |       |         |", 13, 10
	   db "|   |  |    |  |   |     |   ,_________________,   |     |                /______________________|  /        |   ,_____|", 13, 10
	   db "|   |  |    |  |   |     |   |                 |   |     |    _____                                /         |   |     |", 13, 10
	   db "|   |  |    |  |   |     |   |                 |   |     |   /     \   ,_____________________,    /          |   |     |", 13, 10
	   db "|   |  |    |  |   |     |   |                 |   |     |   |     |   |                     |   |           |   |     |", 13, 10
	   db "|   |__|    |__|   \_____/   |_________________|   \_____/   \_____/   |                     |   |_______,   |   |_____|", 13, 10
	   db "|                                                                      |                     |           |   |         |", 13, 10
	   db "|   ,_________________________,   ,_________   ,_____________,   ,_,   |_____________________|   ,___,   |   |_________|", 13, 10
	   db "|   |                         |   |         \   \            |   | |                             |   |   |             |", 13, 10
	   db "|   |                         |   |          \   \           |   | |__________________,   ,__,   |   |   |_____________|", 13, 10
	   db "|   |                         |   |           \   \          |   |                    |   |  |   |   |                 |", 13, 10
	   db "|   |_________________________|   |___________|   |__________|   |____________________|   |  |   |   |   ,_____________|", 13, 10
	   db "|                                                                                         |  |   |   |   |             |", 13, 10
	   db "|____,   ,___________________________,     ________       ,________,   ,__________________|  |   |___|   |_____________|", 13, 10
	   db "|    |   |___________________________|    /        \     /         |   |_____________________|                         |", 13, 10
	   db "|    |                                   /          \   /          |                                                   |", 13, 10
	   db "|    |   ,___________________________,   |          |   |          |   ,_______________________________________________|", 13, 10
	   db "|    |   |                           |   |          |   |          |   |                                               |", 13, 10
	   db "|____|   |___________________________|   |__________|   |__________|   |_______________________________________________|", 13, 10
	   db "|                                                                                                                      |", 13, 10
	   db "|                                                                                                                      |", 13, 10
	   db "|______________________________________________________________________________________________________________________|", 0
maze02 db "_", 0
Xmaze02 db 546 dup(0)
Ymaze02 db 546 dup(0)
maze03 db " ", 0

help db "1. You can control the Pac Man (blue) with the following keys on keyboard: ", 13, 10, 13, 10
	 db "    A --> LEFT", 13, 10
	 db "    D --> RIGHT", 13, 10
	 db "    W --> UP", 13, 10
	 db "    S --> DOWN", 13, 10, 13, 10
	 db "    P --> PAUSE the game", 13, 10, 13, 10
	 DB "2. You have to beware of red ghosts. If you collide with any of the ghosts, you'll lose a life.", 13, 10, 13, 10
	 db "3. Once you've eaten all the fruits in the maze, you'll move to the next level.", 13, 10, 13, 10
	 db "4. Eating fruits will increase your points.", 13, 10, 13, 10, 13, 10
	 db "5. Press 'B' to go back.", 0

food db "*", 0

xFood db 2,2,2,2,2,2,2,2,2, 2, 2, 2 ,2, 2, 2, 2		;l1
	  db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40
	  db 42,44,46,48,50,52,54,56,58,60,62,64,66,68,70,72,74,76,78,80,82,84,86,88,90,92,94,96,98,100
	  db 102,104,106,108,110,112,114,116,118,17,17,17,17,17,17,17,17,17		;l3
	  db  2, 4, 6, 8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60,62,64,66,68,70,94,96,98,100,102,104,110,112,114,116,118		;l4
	  db  2, 4, 6, 8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60,62,64,66,68,70,72,74,76,78,80,82,84,86,88,94,96,102,104		;l5
	  db  6, 8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,54,68,70,72,74,76,78,80,82,84,86,88,90,92,94,96,98,100,102,104,106,108,110,112,114,116,118		;l6
	  db  2, 4, 6, 8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,62,64,66,68,70
	  db 72,74,76,78,80,82,84,86,88,90,92,94,96,98,100,102,104,106,108,110,112,114,116,118		;l7
	  db 75,99,110,112,114,116,118,59,59,59,59,59,59,59,59,59, 7, 7, 7, 7, 7,54,54,54,54,54		;l11
	  db 39,39,39,39,39,69,69,69,69,69,26,28,30,32,34,36,38,40,42,44,46,48,50,27,27,27,27,27		;l15
	  db 32,32,32,32,32,63,63,63,63,63,49,49,49,49,49,61,63,65,67,69,71,73,69,69,69,69,69,69		;l20
	  db 71,73,75,77,79,81,83,85,87,89,91,93,95		;l21
	  db 71,73,75,77,79,81,83,85,87,89,91,93,95,97		;l22
	  db 95,95,95,95,95,95,95,95,95,95		;l23
	  db 103,103,103,103,103,103,103		;l24
	  db 105,107,109,111,113,115,117		;l25
	  db 111,111,111,111,111,111,111,111,113,113,113,115,115,115,117,117,117,99,99,99,98,76,74,73,45,46,47,48,48		;l35
	  db 88,88,88,9,9,9,9,9,9,11,11,11,11,11,11		;l36

yFood db 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17		;l1
	  db 1,1,1,1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
	  db 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,  1,  1
	  db   1,  1,  1,  1,  1,  1,  1,  1,  1, 2, 3, 4, 5, 6, 7, 8, 9,10		;l3
	  db 11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11, 11, 11, 11, 11, 11, 11, 11, 11		;l4
	  db 17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17, 17, 17		;l5
	  db 20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20		;l6
	  db 24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24
	  db 24,24,24,24,24,24,24,24,24,24,24,24,24,24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24		;l7
	  db  3, 3,  3,  3,  3,  3,  3, 2, 3, 4, 5, 6, 7, 8, 9,10,18,19,21,22,23,18,19,21,22,23		;l11
	  db 18,19,21,22,23,18,19,21,22,23, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 7, 8, 9,10		;l15
	  db 12,13,14,15,16,12,13,14,15,16, 6, 7, 8, 9,10, 6, 6, 6, 6, 6, 6, 6, 7, 8, 9,10,12,13		;l20
	  db 13,13,13,13,13,13,13,13,13,13,13,13,13		;l21
	  db  7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7		;l22
	  db  8, 9,10,12,13,14,15,16,18,19		;l23
	  db  12, 13, 14, 15, 16, 18, 19		;l24
	  db  15, 15, 15, 15, 15, 15, 15		;l25
	  db   2,  4,  5,  6,  7,  8,  9, 10,  2,  4,  5,  2,  4,  5,  2,  4,  5, 2, 4, 5, 6,  2, 4, 5,12,13,14,15,16		;l35
	  db  14,15,16,5,6,7,8,9,10,5,6,7,8,9,10		;l36

xFood2 db 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,38,40,42,44,46,48,50,52
	   db 54,56,58,60,62,64,66,68,70,74,76,78,80,82,84,86,88,90,92,94,96,98,100,102,104,106,108,110,112,114,116
	   db 2,2,2,2,2,2,2,2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 4, 6, 8,10,12,14,16,18,20,22,24, 2, 4, 6, 8,10,12,14,16,18,20,22,24
	   db 34,34,34,34,34,34,34,34,38,38,38,38,38,38,38,38, 2, 4, 6, 8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40
	   db 40,42,44,46,48,50,52,54,56,58,60,62,64,40,42,44,46,48,50,52,54,56,58,60,62,64,13,13,13,13,13,13,13,13,13,13,13
	   db 13,15,17,19,21,23,25,27,29,31,46,48,50,52,54,56,58,60,62,64,66,76,78,80,82,84,86,88,90,92,94,96,98,100
	   db 76,78,80,82,84,86,88,90,92,94,96,98,100,96,98,100,102,104,106,108,110,112,114,116,116,116,116,116,116,116,116,116,116
	   db 116,116,116,116,116,116,116,116,116,82,84,86,88,90,92,94,96,98,100,102,104,106,108,110,112,114,116

yFood2 db 1,1,1,1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
	   db  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,  1,  1,  1,  1,  1,  1,  1,  1,  1
	   db 2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,19,19,19,19,19,19,19,19,19,19,19,21,21,21,21,21,21,21,21,21,21,21,21
	   db  2, 3, 4, 5, 6, 7, 8, 9, 2, 3, 4, 5, 6, 7, 8, 9,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24
	   db 19,19,19,19,19,19,19,19,19,19,19,19,19,21,21,21,21,21,21,21,21,21,21,21,21,21, 5, 6, 7, 8, 9,10,11,12,13,14,15
	   db 16,16,16,16,16,16,16,16,16,16, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7,  7
	   db 19,19,19,19,19,19,19,19,19,19,19,19, 19, 4, 4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13
	   db  15, 16, 17, 18, 19, 20, 21, 22, 23,24,24,24,24,24,24,24,24,24, 24, 24, 24, 24, 24, 24, 24, 24, 24

strScore BYTE "Score: ",0
score WORD 0

strLives BYTE "Lives: ", 0
lives byte 3

strLevel BYTE "Level: ", 0
level byte 1
level2 db "L E V E L   T W O", 0
levelFailed db "L E V E L   F A I L E D", 0

PauseMsg db "GAME PAUSED", 0
ResumeMsg db "Press 'R' to resume", 0
endGame db 0

xPos BYTE 60
yPos BYTE 24

xHurdle BYTE ?
yHurdle BYTE ?

xGhost BYTE 55
yGhost BYTE 1

inputChar BYTE ?

collide BYTE 0
boundary BYTE 0
finLevel BYTE 0

x db 56
y db 18

.code
main PROC
	
	;_______________________1st Page_______________________
	mov eax, lightcyan + (black * 16)
	call SetTextColor

	mov dl, 50
	mov dh, 10
	call Gotoxy
	mov edx, offset start
	call writeString

	mov dl, 46
	mov dh, 12
	call Gotoxy
	mov edx, offset strName
	call writeString
	mov ecx, lengthof inputName
	mov eax, offset inputName
	call readString

	;call waitmsg
	call clrscr

	;_______________________2nd Page_______________________
	mov eax, lightcyan + (black * 16)
	call SetTextColor
	Page2:
	call clrscr
	mov dl, 55
	mov dh, 10
	call Gotoxy
	mov edx, offset play
	call writeString

	mov dl, 51
	mov dh, 12
	call Gotoxy
	mov edx, offset instructions
	call writeString

	call readChar
	call clrscr

	CMP al, 'h'
	JE helpPage
	CMP al, 'p'
	JE playGame
	JMP Page2
	helpPage:
		call clrscr
		call help_instructions
		call readChar
		CMP al, 'b'
		JE Page2
		JMP helpPage
		
playGame:
	;call waitmsg
	call clrscr


	
	; drawing maze
	cmp level, 1
	JE lev1
	cmp level, 2
	JE lev2
	cmp level, 3
	JE lev3
	JMP GAMEEND
	lev1:
	mov eax,Magenta +(Black*16)
	call SetTextColor
	call clrscr
	mov edx, offset maze01
	call writeString
	JMP le1
	lev2:
	call mazeTwo
	JMP le2
	lev3:
	mov edx, offset maze03
	call writeString
	JMP le3
	GAMEEND:
	call clrScr
	mov eax, lightCyan + (Black * 16)
	mov dl, 55
	mov dh, 10
	call gotoxy
	mov edx, offset endGame
	call WriteString

	le1:
	call DrawPlayer
	call DrawFood
	call DrawGhost
	JMP le3
	le2:
	call DrawPlayer
	call DrawFood2
	call DrawGhost
	le3:


	comment @
	; red block
	mov eax,red+(red * 16)
	call SetTextColor
	mov dl,x
	mov dh,y
	call Gotoxy
	mov al,"O"
	call WriteChar
	@
	
	
	cmp level, 1
	JE gameLoop
	cmp level, 2
	JE gameLoop2
	nextLevel:
		call clrscr
		cmp level, 1
		JE l1
		l1:
		mov level, 2
		mov lives, 3
		mov finLevel, 0
		mov eax, lightcyan + (black * 16)
		call SetTextColor
		LevelTwo:
		call clrscr
		mov dl, 55
		mov dh, 10
		call Gotoxy
		mov edx, offset level2
		call writeString
		call ReadCHar
		JMP playGame
	
	FailLevel:
		call clrscr
		cmp level, 1
		JE l2
		l2:
		mov level, 2
		mov finLevel, 0
		mov eax, lightcyan + (black * 16)
		call SetTextColor
		LevelFail:
		call clrscr
		mov dl, 50
		mov dh, 10
		call Gotoxy
		mov edx, offset levelFailed
		call writeString
		mov dl, 40
		mov dh, 11
		call Gotoxy
		call waitmsg
		call ReadCHar
		JMP exitGame

	PauseScreen:
		mov eax, lightcyan + (black * 16)
		call setTextColor
		mov dl, 55
		mov dh, 10
		call Gotoxy
		mov edx, offset PauseMsg
		call WriteString
		mov dl, 52
		mov dh, 12
		call Gotoxy
		mov edx, offset ResumeMsg
		call writeString
		call ReadChar
		cmp al, "r"
		JNE PauseScreen
		JMP playGame

	gameLoop:
		cmp lives, 0		; checking for lives
		JE FailLevel		; check if the player has failed the game
		call LevelEnd		; check if all the food is finished in level 1
		CMP finLevel, 1
		JE nextLevel
		call CollisionWithGhost
		CMP collide, 1
		JE gameLoop
		mov boundary, 0
		mov cnt, 0
		

		; draw score:
		mov eax,white+(black * 16)
		call SetTextColor
		mov dl,2
		mov dh,27
		call Gotoxy
		mov edx,OFFSET strScore
		call WriteString
		mov ax,score
		call WriteDec

		; draw lives:
		mov eax,white+(black * 16)
		call SetTextColor
		mov dl,34
		mov dh,27
		call Gotoxy
		mov edx,OFFSET strLives
		call WriteString
		mov al,lives
		call WriteDec

		; draw level no.
		mov eax,white+(black * 16)
		call SetTextColor
		mov dl,64
		mov dh,27
		call Gotoxy
		mov edx,OFFSET strLevel
		call WriteString
		mov al,level
		call WriteDec
		



	; Making ghost
		call RandomizeGhost
		mov bl, 5
		l3:
		setGhost:
		cmp udlr, "u"
		JE ghostUp
		cmp udlr, "r"
		JE ghostRight
		cmp udlr, "l"
		JE ghostLeft
		ghostDown:
		mov dl, xGhost
		mov dh, yGhost
		call boundaryCheck
		cmp boundary, 1
		JE gameLoop
		call collisionWithWall
		CMP cnt,2 
		JE gameLoop
		call UpdateGhost
		INC yGhost
		JMP dGhost
		ghostLeft:
		mov dl, xGhost
		mov dh, yGhost
		call boundaryCheck
		cmp boundary, 1
		JE gameLoop
		call collisionWithWall
		CMP cnt,2 
		JE gameLoop
		call UpdateGhost
		dec xGhost
		JMP dGhost
		ghostRight:
		mov dl, xGhost
		mov dh, yGhost
		call boundaryCheck
		cmp boundary, 1
		JE gameLoop
		call collisionWithWall
		CMP cnt,2 
		JE gameLoop
		call UpdateGhost
		inc xGhost
		JMP dGhost
		ghostUp:
		mov dl, xGhost
		mov dh, yGhost
		call boundaryCheck
		cmp boundary, 1
		JE gameLoop
		call collisionWithWall
		CMP cnt,2 
		JE gameLoop
		call UpdateGhost
		dec yGhost
		dGhost:
		call DrawGhost
		mov eax,40
		call Delay
		dec bl
		cmp bl, 0
		JNE l3




		; get user key input:
		;call ReadChar
		mov eax, 40
		call delay
		call ReadKey
		cmp al, 1
		JE gameLoop
		mov inputChar,al

		
		mov dl, xPos
		mov dh, yPos

		; exit game if user types 'x':
		cmp inputChar,"x"
		je exitGame

		cmp inputChar,"w"
		je moveUp

		cmp inputChar,"s"
		je moveDown

		cmp inputChar,"a"
		je moveLeft

		cmp inputChar,"d"
		je moveRight

		cmp inputChar,"p"
		je PauseScreen
		JMP gameLoop

		moveUp:
		mov udlr, 'u'
		call boundaryCheck
		cmp boundary, 1
		JE gameLoop
		call collisionWithWall
		CMP cnt,2 
		JE gameLoop
		call UpdatePlayer
		dec yPos
		call DrawPlayer
		jmp gameLoop

		moveDown:
		mov udlr, 'd'
		call boundaryCheck
		cmp boundary, 1
		JE gameLoop
		call collisionWithWall
		CMP cnt,2 
		JE gameLoop
		call UpdatePlayer
		inc yPos
		call DrawPlayer
		jmp gameLoop

		moveLeft:
		mov udlr, 'l'
		call boundaryCheck
		cmp boundary, 1
		JE gameLoop
		call collisionWithWall
		CMP cnt,2 
		JE gameLoop
		call UpdatePlayer
		dec xPos
		call DrawPlayer
		jmp gameLoop

		moveRight:
		mov udlr, 'r'
		call boundaryCheck
		cmp boundary, 1
		JE gameLoop
		call collisionWithWall
		CMP cnt,2 
		JE gameLoop
		call UpdatePlayer
		inc xPos
		call DrawPlayer
		jmp gameLoop

	jmp gameLoop

	gameLoop2:
		cmp lives, 0		; checking for lives
		JE FailLevel		; check if the player has failed the game
		call LevelEnd		; check if all the food is finished in level 1
		CMP finLevel, 1
		JE nextLevel
		call CollisionWithGhost2
		CMP collide, 1
		JE gameLoop2
		mov boundary, 0
		mov cnt, 0
		

		; draw score:
		mov eax,white+(black * 16)
		call SetTextColor
		mov dl,2
		mov dh,27
		call Gotoxy
		mov edx,OFFSET strScore
		call WriteString
		mov ax,score
		call WriteDec

		; draw lives:
		mov eax,white+(black * 16)
		call SetTextColor
		mov dl,34
		mov dh,27
		call Gotoxy
		mov edx,OFFSET strLives
		call WriteString
		mov al,lives
		call WriteDec

		; draw level no.
		mov eax,white+(black * 16)
		call SetTextColor
		mov dl,64
		mov dh,27
		call Gotoxy
		mov edx,OFFSET strLevel
		call WriteString
		mov al,level
		call WriteDec


		; Making ghost
		call RandomizeGhost
		mov bl, 5
		l3t:
		setGhost2:
		cmp udlr, "u"
		JE ghostUp2
		cmp udlr, "r"
		JE ghostRight2
		cmp udlr, "l"
		JE ghostLeft2
		ghostDown2:
		mov dl, xGhost
		mov dh, yGhost
		call boundaryCheck
		cmp boundary, 1
		JE gameLoop2
		call collisionWithWall2
		CMP cnt,2 
		JE gameLoop2
		call UpdateGhost2
		INC yGhost
		JMP dGhost2
		ghostLeft2:
		mov dl, xGhost
		mov dh, yGhost
		call boundaryCheck
		cmp boundary, 1
		JE gameLoop2
		call collisionWithWall2
		CMP cnt,2 
		JE gameLoop2
		call UpdateGhost2
		dec xGhost
		JMP dGhost
		ghostRight2:
		mov dl, xGhost
		mov dh, yGhost
		call boundaryCheck
		cmp boundary, 1
		JE gameLoop2
		call collisionWithWall2
		CMP cnt,2 
		JE gameLoop2
		call UpdateGhost2
		inc xGhost
		JMP dGhost2
		ghostUp2:
		mov dl, xGhost
		mov dh, yGhost
		call boundaryCheck
		cmp boundary, 1
		JE gameLoop2
		call collisionWithWall2
		CMP cnt,2 
		JE gameLoop2
		call UpdateGhost2
		dec yGhost
		dGhost2:
		call DrawGhost
		mov eax,40
		call Delay
		dec bl
		cmp bl, 0
		JNE l3t


		; get user key input:
		;call ReadChar
		mov eax, 40
		call delay
		call ReadKey
		cmp al, 1
		JE gameLoop2
		mov inputChar,al

		
		mov dl, xPos
		mov dh, yPos

		; exit game if user types 'x':
		cmp inputChar,"x"
		je exitGame

		cmp inputChar,"w"
		je moveUp2

		cmp inputChar,"s"
		je moveDown2

		cmp inputChar,"a"
		je moveLeft2

		cmp inputChar,"d"
		je moveRight2

		cmp inputChar,"p"
		je PauseScreen
		JMP gameLoop2

		moveUp2:
		mov udlr, 'u'
		call boundaryCheck
		cmp boundary, 1
		JE gameLoop2
		call collisionWithWall2
		CMP cnt,2 
		JE gameLoop2
		call UpdatePlayer
		dec yPos
		call DrawPlayer
		jmp gameLoop2

		moveDown2:
		mov udlr, 'd'
		call boundaryCheck
		cmp boundary, 1
		JE gameLoop2
		call collisionWithWall2
		CMP cnt,2 
		JE gameLoop2
		call UpdatePlayer
		inc yPos
		call DrawPlayer
		jmp gameLoop2

		moveLeft2:
		mov udlr, 'l'
		call boundaryCheck
		cmp boundary, 1
		JE gameLoop2
		call collisionWithWall2
		CMP cnt,2 
		JE gameLoop2
		call UpdatePlayer
		dec xPos
		call DrawPlayer
		jmp gameLoop2

		moveRight2:
		mov udlr, 'r'
		call boundaryCheck
		cmp boundary, 1
		JE gameLoop2
		call collisionWithWall2
		CMP cnt,2 
		JE gameLoop2
		call UpdatePlayer
		inc xPos
		call DrawPlayer
		jmp gameLoop2
	JMP gameLoop2

	exitGame:
	exit
main ENDP

DrawPlayer PROC
	mov eax,lightcyan + (lightcyan * 16)
	call SetTextColor
	; draw player at (xPos,yPos):
	mov dl,xPos
	mov dh,yPos
	call Gotoxy
	mov al,"O"
	call WriteChar
	cmp level, 2
	je lev2
	call FoodCheck
	JMP finish
	lev2:
	call FoodCheck2
	finish:
	ret
DrawPlayer ENDP

UpdatePlayer PROC
	mov eax,black+(black * 16)
	call SetTextColor
	mov dl,xPos
	mov dh,yPos
	call Gotoxy
	mov al," "
	call WriteChar
	ret
UpdatePlayer ENDP

DrawFood PROC
	mov eax, green + (black * 16)
	call SetTextColor
	mov ecx, 17
	mov esi, 0
	l1:
	cmp xFood[esi] ,-1
	JE l1a
	mov dl, xFood[esi]
	mov dh, yFood[esi]
	call Gotoxy
	mov edx, offset food
	call WriteString
	l1a:
	INC esi
	loop l1

	mov ecx, 67
	l3:
	cmp xFood[esi], -1
	JE l3a
	mov dl, xFood[esi]
	mov dh, yFood[esi]
	call Gotoxy
	mov edx, offset food
	call WriteString
	l3a:
	INC esi
	loop l3

	mov ecx, 46
	l4:
	cmp xFood[esi], -1
	JE l4a
	mov dl, xFood[esi]
	mov dh, yFood[esi]
	call Gotoxy
	mov edx, offset food
	call WriteString
	l4a:
	INC esi
	loop l4

	mov ecx, 48
	l5:
	cmp xFood[esi], -1
	JE l5a
	mov dl, xFood[esi]
	mov dh, yFood[esi]
	call Gotoxy
	mov edx, offset food
	call WriteString
	l5a:
	INC esi
	loop l5

	mov ecx, 45
	l6:
	cmp xFood[esi], -1
	JE l6a
	mov dl, xFood[esi]
	mov dh, yFood[esi]
	call Gotoxy
	mov edx, offset food
	call WriteString
	l6a:
	INC esi
	loop l6

	mov ecx, 58
	l7:
	cmp xFood[esi], -1
	JE l7a
	mov dl, xFood[esi]
	mov dh, yFood[esi]
	call Gotoxy
	mov edx, offset food
	call WriteString
	l7a:
	INC esi
	loop l7

	mov ecx, 26
	l11:
	cmp xFood[esi], -1
	JE l11a
	mov dl, xFood[esi]
	mov dh, yFood[esi]
	call Gotoxy
	mov edx, offset food
	call WriteString
	l11a:
	INC esi
	loop l11

	mov ecx, 28
	l15:
	cmp xFood[esi], -1
	JE l15a
	mov dl, xFood[esi]
	mov dh, yFood[esi]
	call Gotoxy
	mov edx, offset food
	call WriteString
	l15a:
	INC esi
	loop l15

	mov ecx, 28
	l20:
	cmp xFood[esi], -1
	JE l20a
	mov dl, xFood[esi]
	mov dh, yFood[esi]
	call Gotoxy
	mov edx, offset food
	call WriteString
	l20a:
	INC esi
	loop l20

	mov ecx, 13
	l21:
	cmp xFood[esi], -1
	JE l21a
	mov dl, xFood[esi]
	mov dh, yFood[esi]
	call Gotoxy
	mov edx, offset food
	call WriteString
	l21a:
	INC esi
	loop l21

	mov ecx, 14
	l22:
	cmp xFood[esi], -1
	JE l22a
	mov dl, xFood[esi]
	mov dh, yFood[esi]
	call Gotoxy
	mov edx, offset food
	call WriteString
	l22a:
	INC esi
	loop l22

	mov ecx, 10
	l23:
	cmp xFood[esi], -1
	JE l23a
	mov dl, xFood[esi]
	mov dh, yFood[esi]
	call Gotoxy
	mov edx, offset food
	call WriteString
	l23a:
	INC esi
	loop l23

	mov ecx, 7
	l24:
	cmp xFood[esi], -1
	JE l24a
	mov dl, xFood[esi]
	mov dh, yFood[esi]
	call Gotoxy
	mov edx, offset food
	call WriteString
	l24a:
	INC esi
	loop l24

	mov ecx, 7
	l25:
	cmp xFood[esi], -1
	JE l25a
	mov dl, xFood[esi]
	mov dh, yFood[esi]
	call Gotoxy
	mov edx, offset food
	call WriteString
	l25a:
	INC esi
	loop l25

	mov ecx, 29
	l35:
	cmp xFood[esi], -1
	JE l35a
	mov dl, xFood[esi]
	mov dh, yFood[esi]
	call Gotoxy
	mov edx, offset food
	call WriteString
	l35a:
	INC esi
	loop l35

	mov ecx, 15
	l36:
	cmp xFood[esi], -1
	JE l36a
	mov dl, xFood[esi]
	mov dh, yFood[esi]
	call Gotoxy
	mov edx, offset food
	call WriteString
	l36a:
	INC esi
	loop l36
	
	ret
DrawFood ENDP

FoodCheck PROC
	mov cnt, 0
	mov ecx, 458
	mov esi, 0
	l1:
		cmp dl, xFood[esi]
		JE l2
		JMP l4
	l2:
		inc cnt
		cmp dh, yFood[esi]
		JE l3
		JMP l4
	l3:
		inc cnt
		JMP l5
	l4:
		inc esi
		mov cnt,0
		loop l1
	l5:
		cmp cnt, 2
		JE finish
		JMP finish1
	finish:
		mov xFood[esi], -1
		mov yFood[esi], -1
		INC score
		ret
	finish1:
	ret
FoodCheck ENDP

DrawGhost PROC
	mov eax,red+(red * 16)
	call SetTextColor
	; draw player at (xPos,yPos):
	mov dl,xGhost
	mov dh,yGhost
	call Gotoxy
	mov al,"X"
	call WriteChar
	ret
DrawGhost ENDP

UpdateGhost PROC
	mov dl,xGhost
	mov dh,yGhost
	call Gotoxy

	mov esi, 0
	mov ecx, 458
	l1:
		cmp dl, xFood[esi]
		JE l2
		inc esi
		loop l1
		JMP l4
	l2:
		cmp dh, yFood[esi]
		JE l3
		inc esi
		loop l1
		JMP l4
	l3:
		mov eax, green + (black * 16)
		call setTextColor
		mov al, "*"
		call writeChar
		JMP finish
	l4:
	mov eax, black + (black * 16)
	call setTextColor
	mov al," "
	call WriteChar
	finish:
	ret
UpdateGhost ENDP

RandomizeGhost PROC
	mov eax, 4
	call randomRange
	inc eax
	cmp al, 1
	JE up
	cmp al, 2
	jE down
	cmp al, 3
	jE right
	cmp al, 4
	jE left
	up:
		mov udlr, "u"
		ret
	down:
		mov udlr, "d"
		ret
	left:
		mov udlr, "l"
		ret
	right:
		mov udlr, "r"
		ret
RandomizeGhost ENDP

SettingGhost PROC
	cmp udlr, "u"
	JE up
	cmp udlr, "d"
	JE down
	cmp udlr, "l"
	JE left
	cmp udlr, "r"
	JE right
	up:
		inc yGhost
		ret
	down:
		dec yGhost
		ret
	left:
		inc xGhost
		ret
	right:
		dec xGhost
		ret
SettingGhost ENDP

help_instructions PROC
	
	mov dl, 50
	mov dh, 2
	call Gotoxy
	mov edx, offset instructions
	call writeString
	mov dl, 0
	mov dh, 6
	call Gotoxy
	mov edx, offset help
	call writeString
	ret
help_instructions ENDP

CollisionWithGhost PROC
	mov collide, 0
	mov dl, xGhost
	mov dh, yGhost
	cmp dl, xPos
	JE l1
	JMP l3
	l1:
		cmp dh, yPos
		JE l2
		JMP l3
	l2:
		dec lives
		call UpdatePlayer
		mov xPos, 60
		mov yPos, 24
		call DrawPlayer
		mov collide, 1
		JMP finish
	l3:
	mov dl, xGhost
	mov dh, yGhost
	dec dl
	cmp dl, xPos
	JE l4
	JMP l6
	l4:
		cmp dh, yPos
		JE l5
		JMP l6
	l5:
		dec lives
		call UpdatePlayer
		mov xPos, 60
		mov yPos, 24
		call DrawPlayer
		mov collide, 1
		JMP finish
	l6:
	mov dl, xGhost
	mov dh, yGhost
	inc dl
	cmp dl, xPos
	JE l7
	JMP l9
	l7:
		cmp dh, yPos
		JE l8
		JMP l9
	l8:
		dec lives
		call UpdatePlayer
		mov xPos, 60
		mov yPos, 24
		call DrawPlayer
		mov collide, 1
		JMP finish
	l9:
	mov dl, xGhost
	mov dh, yGhost
	inc dh
	cmp dl, xPos
	JE l10
	JMP l12
	l10:
		cmp dh, yPos
		JE l11
		JMP l12
	l11:
		dec lives
		call UpdatePlayer
		mov xPos, 60
		mov yPos, 24
		call DrawPlayer
		mov collide, 1
		JMP finish
	l12:
	mov dl, xGhost
	mov dh, yGhost
	dec dh
	cmp dl, xPos
	JE l13
	JMP l15
	l13:
		cmp dh, yPos
		JE l14
		JMP l15
	l14:
		dec lives
		call UpdatePlayer
		mov xPos, 60
		mov yPos, 24
		call DrawPlayer
		mov collide, 1
		JMP finish
	l15:
	finish:
	ret
CollisionWithGhost ENDP

collisionWithWall PROC
	mov collide, 0
	CMP udlr, 'd'
	JE for_d
	CMP udlr, 'u'
	JE for_u
	CMP udlr, 'l'
	JE for_l
	CMP udlr, 'r'
	JE for_r
	JMP finish
for_d:
	CMP dl, 4
	JAE l0
	JMP l4
	l0:
		CMP dl, 15
		JBE l1
		JMP l4
	l1:
		INC cnt
	CMP dh, 1
	JE l3
	JMP l4
	l3:
		INC cnt
	l4:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 19
	JAE l5
	JMP l6
	l5:
		CMP dl, 57
		JBE l7
		JMP l6
	l7:
		INC cnt
	CMP dh, 1
	JE l9
	JMP l6
	l9:
		INC cnt
	l6:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 61
	JAE l10
	JMP l11
	l10:
		CMP dl, 74
		JBE l12
		JMP l11
	l12:
		INC cnt
	CMP dh, 1
	JE l13
	JMP l11
	l13:
		INC cnt
	l11:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 78
	JAE l14
	JMP l15
	l14:
		CMP dl, 97
		JBE l16
		JMP l15
	l16:
		INC cnt
	CMP dh, 1
	JE l17
	JMP l15
	l17:
		INC cnt
	l15:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 100
	JAE l18
	JMP l19
	l18:
		CMP dl, 109
		JBE l20
		JMP l19
	l20:
		INC cnt
	CMP dh, 1
	JE l21
	JMP l19
	l21:
		INC cnt
	l19:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 29
	JAE l22
	JMP l23
	l22:
		CMP dl, 47
		JBE l24
		JMP l23
	l24:
		INC cnt
	CMP dh, 5
	JE l25
	JMP l23
	l25:
		INC cnt
	l23:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 113
	JAE l26
	JMP l27
	l26:
		CMP dl, 118
		JBE l28
		JMP l27
	l28:
		INC cnt
	CMP dh, 5
	JE l29
	JMP l27
	l29:
		INC cnt
	l27:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 61
	JAE l30
	JMP l31
	l30:
		CMP dl, 67
		JBE l32
		JMP l31
	l32:
		INC cnt
	CMP dh, 6
	JE l33
	JMP l31
	l33:
		INC cnt
	l31:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 4
	JAE l34
	JMP l35
	l34:
		CMP dl, 30
		JBE l36
		JMP l35
	l36:
		INC cnt
	CMP dh, 11
	JE l37
	JMP l35
	l37:
		INC cnt
	l35:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 34
	JAE l38
	JMP l39
	l38:
		CMP dl, 43
		JBE l40
		JMP l39
	l40:
		INC cnt
	CMP dh, 11
	JE l41
	JMP l39
	l41:
		INC cnt
	l39:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 47
	JAE l42
	JMP l43
	l42:
		CMP dl, 61
		JBE l44
		JMP l43
	l44:
		INC cnt
	CMP dh, 11
	JE l45
	JMP l43
	l45:
		INC cnt
	l43:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 65
	JAE l46
	JMP l47
	l46:
		CMP dl, 67
		JBE l48
		JMP l47
	l48:
		INC cnt
	CMP dh, 11
	JE l49
	JMP l47
	l49:
		INC cnt
	l47:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 97
	JAE l50
	JMP l51
	l50:
		CMP dl, 101
		JBE l52
		JMP l51
	l52:
		INC cnt
	CMP dh, 11
	JE l53
	JMP l51
	l53:
		INC cnt
	l51:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 110
	JAE l54
	JMP l55
	l54:
		CMP dl, 118
		JBE l56
		JMP l55
	l56:
		INC cnt
	CMP dh, 11
	JE l57
	JMP l55
	l57:
		INC cnt
	l55:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 68
	JAE l58
	JMP l59
	l58:
		CMP dl, 86
		JBE l60
		JMP l59
	l60:
		INC cnt
	CMP dh, 13
	JE l61
	JMP l59
	l61:
		INC cnt
	l59:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 90
	JAE l62
	JMP l63
	l62:
		CMP dl, 93
		JBE l64
		JMP l63
	l64:
		INC cnt
	CMP dh, 13
	JE l65
	JMP l63
	l65:
		INC cnt
	l63:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 105
	JAE l66
	JMP l67
	l66:
		CMP dl, 118
		JBE l68
		JMP l67
	l68:
		INC cnt
	CMP dh, 15
	JE l69
	JMP l67
	l69:
		INC cnt
	l67:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 71
	JAE l70
	JMP l71
	l70:
		CMP dl, 89
		JBE l72
		JMP l71
	l72:
		INC cnt
	CMP dh, 17
	JE l73
	JMP l71
	l73:
		INC cnt
	l71:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 56
	JAE l74
	JMP l75
	l74:
		CMP dl, 67
		JBE l76
		JMP l75
	l76:
		INC cnt
	CMP dh, 17
	JE l77
	JMP l75
	l77:
		INC cnt
	l75:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 41
	JAE l78
	JMP l79
	l78:
		CMP dl, 52
		JBE l80
		JMP l79
	l80:
		INC cnt
	CMP dh, 17
	JE l81
	JMP l79
	l81:
		INC cnt
	l79:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 9
	JAE l82
	JMP l83
	l82:
		CMP dl, 37
		JBE l84
		JMP l83
	l84:
		INC cnt
	CMP dh, 17
	JE l85
	JMP l83
	l85:
		INC cnt
	l83:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 1
	JAE l86
	JMP l87
	l86:
		CMP dl, 5
		JBE l88
		JMP l87
	l88:
		INC cnt
	CMP dh, 17
	JE l89
	JMP l87
	l89:
		INC cnt
	l87:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 9
	JAE l90
	JMP l91
	l90:
		CMP dl, 37
		JBE l92
		JMP l91
	l92:
		INC cnt
	CMP dh, 20
	JE l93
	JMP l91
	l93:
		INC cnt
	l91:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 71
	JAE l94
	JMP l95
	l94:
		CMP dl, 118
		JBE l96
		JMP l95
	l96:
		INC cnt
	CMP dh, 20
	JE l97
	JMP l95
	l97:
		INC cnt
	l95:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 12
	JE ld1
	JMP ld3
	ld1:
		INC cnt
	CMP dl, 44
	JE ld2
	JMP ld3
	ld2:
		INC cnt
	ld3:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 13
	JE ld4
	JMP ld6
	ld4:
		INC cnt
	CMP dl, 45
	JE ld5
	JMP ld6
	ld5:
		INC cnt
	ld6:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 14
	JE ld7
	JMP ld9
	ld7:
		INC cnt
	CMP dl, 46
	JE ld8
	JMP ld9
	ld8:
		INC cnt
	ld9:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 2
	JE ld10
	JMP ld12
	ld10:
		INC cnt
	CMP dl, 77
	JE ld11
	JMP ld12
	ld11:
		INC cnt
	ld12:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 3
	JE ld13
	JMP ld15
	ld13:
		INC cnt
	CMP dl, 76
	JE ld14
	JMP ld15
	ld14:
		INC cnt
	ld15:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 4
	JE ld16
	JMP ld18
	ld16:
		INC cnt
	CMP dl, 75
	JE ld17
	JMP ld18
	ld17:
		INC cnt
	ld18:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 5
	JE ld19
	JMP ld21
	ld19:
		INC cnt
	CMP dl, 74
	JE ld20
	JMP ld21
	ld20:
		INC cnt
	ld21:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 71
	JAE ld22
	JMP ld23
	ld22:
		CMP dl, 93
		JBE ld24
		JMP ld23
	ld24:
		INC cnt
	CMP dh, 7
	JE ld25
	JMP ld23
	ld25:
		INC cnt
	ld23:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 5
	JE ld26
	JMP ld28
	ld26:
		INC cnt
	CMP dl, 100
	JE ld27
	JMP ld28
	ld27:
		INC cnt
	ld28:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 6
	JE ld29
	JMP ld31
	ld29:
		INC cnt
	CMP dl, 99
	JE ld30
	JMP ld31
	ld30:
		INC cnt
	ld31:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 7
	JE ld32
	JMP ld34
	ld32:
		INC cnt
	CMP dl, 98
	JE ld33
	JMP ld34
	ld33:
		INC cnt
	ld34:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 8
	JE ld35
	JMP ld37
	ld35:
		INC cnt
	CMP dl, 97
	JE ld36
	JMP ld37
	ld36:
		INC cnt
	ld37:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	JMP finish

for_u:
	CMP dl, 8
	JAE l100
	JMP l101
	l100:
		CMP dl, 11
		JBE l102
		JMP l101
	l102:
		INC cnt
	CMP dh, 5
	JE l103
	JMP l101
	l103:
		INC cnt
	l101:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 26
	JAE l104
	JMP l105
	l104:
		CMP dl, 50
		JBE l106
		JMP l105
	l106:
		INC cnt
	CMP dh, 5
	JE l107
	JMP l105
	l107:
		INC cnt
	l105:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 61
	JAE l108
	JMP l109
	l108:
		CMP dl, 70
		JBE l110
		JMP l109
	l110:
		INC cnt
	CMP dh, 6
	JE l111
	JMP l109
	l111:
		INC cnt
	l109:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 74
	JAE l112
	JMP l113
	l112:
		CMP dl, 97
		JBE l114
		JMP l113
	l114:
		INC cnt
	CMP dh, 7
	JE l115
	JMP l113
	l115:
		INC cnt
	l113:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 4
	JAE l116
	JMP l117
	l116:
		CMP dl, 7
		JBE l118
		JMP l117
	l118:
		INC cnt
	CMP dh, 11
	JE l119
	JMP l117
	l119:
		INC cnt
	l117:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 12
	JAE l120
	JMP l121
	l120:
		CMP dl, 15
		JBE l122
		JMP l121
	l122:
		INC cnt
	CMP dh, 11
	JE l123
	JMP l121
	l123:
		INC cnt
	l121:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 19
	JAE l124
	JMP l125
	l124:
		CMP dl, 25
		JBE l126
		JMP l125
	l126:
		INC cnt
	CMP dh, 11
	JE l127
	JMP l125
	l127:
		INC cnt
	l125:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 29
	JAE l128
	JMP l129
	l128:
		CMP dl, 47
		JBE l130
		JMP l129
	l130:
		INC cnt
	CMP dh, 11
	JE l131
	JMP l129
	l131:
		INC cnt
	l129:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 51
	JAE l132
	JMP l133
	l132:
		CMP dl, 57
		JBE l134
		JMP l133
	l134:
		INC cnt
	CMP dh, 11
	JE l135
	JMP l133
	l135:
		INC cnt
	l133:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 61
	JAE l136
	JMP l137
	l136:
		CMP dl, 67
		JBE l138
		JMP l137
	l138:
		INC cnt
	CMP dh, 11
	JE l139
	JMP l137
	l139:
		INC cnt
	l137:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 97
	JAE l140
	JMP l141
	l140:
		CMP dl, 104
		JBE l142
		JMP l141
	l142:
		INC cnt
	CMP dh, 11
	JE l143
	JMP l141
	l143:
		INC cnt
	l141:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 113
	JAE l144
	JMP l145
	l144:
		CMP dl, 118
		JBE l146
		JMP l145
	l146:
		INC cnt
	CMP dh, 11
	JE l147
	JMP l145
	l147:
		INC cnt
	l145:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 71
	JAE l148
	JMP l149
	l148:
		CMP dl, 93
		JBE l150
		JMP l149
	l150:
		INC cnt
	CMP dh, 13
	JE l151
	JMP l149
	l151:
		INC cnt
	l149:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 105
	JAE l152
	JMP l153
	l152:
		CMP dl, 118
		JBE l154
		JMP l153
	l154:
		INC cnt
	CMP dh, 15
	JE l155
	JMP l153
	l155:
		INC cnt
	l153:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 4
	JAE l156
	JMP l157
	l156:
		CMP dl, 30
		JBE l158
		JMP l157
	l158:
		INC cnt
	CMP dh, 17
	JE l159
	JMP l157
	l159:
		INC cnt
	l157:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 34
	JAE l160
	JMP l161
	l160:
		CMP dl, 46
		JBE l162
		JMP l161
	l162:
		INC cnt
	CMP dh, 17
	JE l163
	JMP l161
	l163:
		INC cnt
	l161:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 50
	JAE l164
	JMP l165
	l164:
		CMP dl, 61
		JBE l166
		JMP l165
	l166:
		INC cnt
	CMP dh, 17
	JE l167
	JMP l165
	l167:
		INC cnt
	l165:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 65
	JAE l168
	JMP l169
	l168:
		CMP dl, 86
		JBE l170
		JMP l169
	l170:
		INC cnt
	CMP dh, 17
	JE l171
	JMP l169
	l171:
		INC cnt
	l169:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 97
	JAE l172
	JMP l173
	l172:
		CMP dl, 101
		JBE l174
		JMP l173
	l174:
		INC cnt
	CMP dh, 19
	JE l175
	JMP l173
	l175:
		INC cnt
	l173:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 105
	JAE l176
	JMP l177
	l176:
		CMP dl, 118
		JBE l178
		JMP l177
	l178:
		INC cnt
	CMP dh, 19
	JE l179
	JMP l177
	l179:
		INC cnt
	l177:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 9
	JAE l180
	JMP l181
	l180:
		CMP dl, 37
		JBE l182
		JMP l181
	l182:
		INC cnt
	CMP dh, 20
	JE l183
	JMP l181
	l183:
		INC cnt
	l181:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 71
	JAE l184
	JMP l185
	l184:
		CMP dl, 93
		JBE l186
		JMP l185
	l186:
		INC cnt
	CMP dh, 20
	JE l187
	JMP l185
	l187:
		INC cnt
	l185:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 1
	JAE l188
	JMP l189
	l188:
		CMP dl, 5
		JBE l190
		JMP l189
	l190:
		INC cnt
	CMP dh, 24
	JE l191
	JMP l189
	l191:
		INC cnt
	l189:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 9
	JAE l192
	JMP l193
	l192:
		CMP dl, 37
		JBE l194
		JMP l193
	l194:
		INC cnt
	CMP dh, 24
	JE l195
	JMP l193
	l195:
		INC cnt
	l193:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 41
	JAE l196
	JMP l197
	l196:
		CMP dl, 52
		JBE l198
		JMP l197
	l198:
		INC cnt
	CMP dh, 24
	JE l199
	JMP l197
	l199:
		INC cnt
	l197:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 56
	JAE l200
	JMP l201
	l200:
		CMP dl, 67
		JBE l202
		JMP l201
	l202:
		INC cnt
	CMP dh, 24
	JE l203
	JMP l201
	l203:
		INC cnt
	l201:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 71
	JAE l204
	JMP l205
	l204:
		CMP dl, 118
		JBE l206
		JMP l205
	l206:
		INC cnt
	CMP dh, 24
	JE l207
	JMP l205
	l207:
		INC cnt
	l205:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 6
	JE l208
	JMP l210
	l208:
		INC cnt
	CMP dl, 71
	JE l209
	JMP l210
	l209:
		INC cnt
	l210:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 5
	JE l211
	JMP l213
	l211:
		INC cnt
	CMP dl, 72
	JE l212
	JMP l213
	l212:
		INC cnt
	l213:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 4
	JE l214
	JMP l216
	l214:
		INC cnt
	CMP dl, 73
	JE l215
	JMP l216
	l215:
		INC cnt
	l216:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 3
	JE l217
	JMP l219
	l217:
		INC cnt
	CMP dl, 74
	JE l218
	JMP l219
	l218:
		INC cnt
	l219:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 15
	JE l220
	JMP l222
	l220:
		INC cnt
	CMP dl, 49
	JE l221
	JMP l222
	l221:
		INC cnt
	l222:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 14
	JE l223
	JMP l225
	l223:
		INC cnt
	CMP dl, 48
	JE l224
	JMP l225
	l224:
		INC cnt
	l225:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 13
	JE l226
	JMP l228
	l226:
		INC cnt
	CMP dl, 47
	JE l227
	JMP l228
	l227:
		INC cnt
	l228:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	JMP finish

for_l:
	CMP dh, 18
	JAE l300
	JMP l301
	l300:
		CMP dh, 23
		JBE l302
		JMP l301
	l302:
		INC cnt
	CMP dl, 6
	JE l303
	JMP l301
	l303:
		INC cnt
	l301:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 5
	JAE l304
	JMP l305
	l304:
		CMP dh, 10
		JBE l306
		JMP l305
	l306:
		INC cnt
	CMP dl, 8
	JE l307
	JMP l305
	l307:
		INC cnt
	l305:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 2
	JAE l308
	JMP l309
	l308:
		CMP dh, 10
		JBE l310
		JMP l309
	l310:
		INC cnt
	CMP dl, 16
	JE l311
	JMP l309
	l311:
		INC cnt
	l309:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 5
	JAE l312
	JMP l313
	l312:
		CMP dh, 10
		JBE l314
		JMP l313
	l314:
		INC cnt
	CMP dl, 26
	JE l315
	JMP l313
	l315:
		INC cnt
	l313:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 6
	JAE l316
	JMP l317
	l316:
		CMP dh, 10
		JBE l318
		JMP l317
	l318:
		INC cnt
	CMP dl, 48
	JE l319
	JMP l317
	l319:
		INC cnt
	l317:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 2
	JAE l320
	JMP l321
	l320:
		CMP dh, 10
		JBE l322
		JMP l321
	l322:
		INC cnt
	CMP dl, 58
	JE l323
	JMP l321
	l323:
		INC cnt
	l321:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 12
	JAE l324
	JMP l325
	l324:
		CMP dh, 16
		JBE l326
		JMP l325
	l326:
		INC cnt
	CMP dl, 31
	JE l327
	JMP l325
	l327:
		INC cnt
	l325:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 18
	JAE l328
	JMP l329
	l328:
		CMP dh, 19
		JBE l330
		JMP l329
	l330:
		INC cnt
	CMP dl, 38
	JE l331
	JMP l329
	l331:
		INC cnt
	l329:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 21
	JAE l332
	JMP l333
	l332:
		CMP dh, 23
		JBE l334
		JMP l333
	l334:
		INC cnt
	CMP dl, 38
	JE l335
	JMP l333
	l335:
		INC cnt
	l333:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 18
	JAE l336
	JMP l337
	l336:
		CMP dh, 23
		JBE l338
		JMP l337
	l338:
		INC cnt
	CMP dl, 53
	JE l339
	JMP l337
	l339:
		INC cnt
	l337:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 18
	JAE l340
	JMP l341
	l340:
		CMP dh, 23
		JBE l342
		JMP l341
	l342:
		INC cnt
	CMP dl, 68
	JE l343
	JMP l341
	l343:
		INC cnt
	l341:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 12
	JAE l344
	JMP l345
	l344:
		CMP dh, 16
		JBE l346
		JMP l345
	l346:
		INC cnt
	CMP dl, 62
	JE l347
	JMP l345
	l347:
		INC cnt
	l345:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 12
	JAE l348
	JMP l349
	l348:
		CMP dh, 13
		JBE l350
		JMP l349
	l350:
		INC cnt
	CMP dl, 68
	JE l351
	JMP l349
	l351:
		INC cnt
	l349:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 7
	JAE l352
	JMP l353
	l352:
		CMP dh, 10
		JBE l354
		JMP l353
	l354:
		INC cnt
	CMP dl, 68
	JE l355
	JMP l353
	l355:
		INC cnt
	l353:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 14
	JAE l356
	JMP l357
	l356:
		CMP dh, 16
		JBE l358
		JMP l357
	l358:
		INC cnt
	CMP dl, 87
	JE l359
	JMP l357
	l359:
		INC cnt
	l357:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 14
	JAE l360
	JMP l361
	l360:
		CMP dh, 19
		JBE l362
		JMP l361
	l362:
		INC cnt
	CMP dl, 94
	JE l363
	JMP l361
	l363:
		INC cnt
	l361:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 8
	JAE l364
	JMP l365
	l364:
		CMP dh, 12
		JBE l366
		JMP l365
	l366:
		INC cnt
	CMP dl, 94
	JE l367
	JMP l365
	l367:
		INC cnt
	l365:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 12
	JAE l368
	JMP l369
	l368:
		CMP dh, 18
		JBE l370
		JMP l369
	l370:
		INC cnt
	CMP dl, 102
	JE l371
	JMP l369
	l371:
		INC cnt
	l369:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 2
	JAE l372
	JMP l373
	l372:
		CMP dh, 6
		JBE l374
		JMP l373
	l374:
		INC cnt
	CMP dl, 98
	JE l375
	JMP l373
	l375:
		INC cnt
	l373:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 2
	JAE l376
	JMP l377
	l376:
		CMP dh, 11
		JBE l378
		JMP l377
	l378:
		INC cnt
	CMP dl, 110
	JE l379
	JMP l377
	l379:
		INC cnt
	l377:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 13
	JE l380
	JMP l382
	l380:
		INC cnt
	CMP dl, 45
	JE l381
	JMP l382
	l381:
		INC cnt
	l382:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 14
	JE l383
	JMP l385
	l383:
		INC cnt
	CMP dl, 46
	JE l384
	JMP l385
	l384:
		INC cnt
	l385:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 15
	JE l386
	JMP l388
	l386:
		INC cnt
	CMP dl, 47
	JE l387
	JMP l388
	l387:
		INC cnt
	l388:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 16
	JE l389
	JMP l391
	l389:
		INC cnt
	CMP dl, 47
	JE l390
	JMP l391
	l390:
		INC cnt
	l391:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 12
	JE l392
	JMP l394
	l392:
		INC cnt
	CMP dl, 44
	JE l393
	JMP l394
	l393:
		INC cnt
	l394:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 2
	JE ll1
	JMP ll3
	ll1:
		INC cnt
	CMP dl, 75
	JE ll2
	JMP ll3
	ll2:
		INC cnt
	ll3:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 3
	JE ll4
	JMP ll6
	ll4:
		INC cnt
	CMP dl, 74
	JE ll5
	JMP ll6
	ll5:
		INC cnt
	ll6:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 4
	JE ll7
	JMP ll9
	ll7:
		INC cnt
	CMP dl, 73
	JE ll8
	JMP ll9
	ll8:
		INC cnt
	ll9:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 5
	JE ll10
	JMP ll12
	ll10:
		INC cnt
	CMP dl, 72
	JE ll11
	JMP ll12
	ll11:
		INC cnt
	ll12:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	JMP finish
	
for_r:
	CMP dh, 2
	JAE l400
	JMP l401
	l400:
		CMP dh, 10
		JBE l402
		JMP l401
	l402:
		INC cnt
	CMP dl, 3
	JE l403
	JMP l401
	l403:
		INC cnt
	l401:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 12
	JAE l404
	JMP l405
	l404:
		CMP dh, 16
		JBE l406
		JMP l405
	l406:
		INC cnt
	CMP dl, 3
	JE l407
	JMP l405
	l407:
		INC cnt
	l405:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 5
	JAE l408
	JMP l409
	l408:
		CMP dh, 10
		JBE l410
		JMP l409
	l410:
		INC cnt
	CMP dl, 11
	JE l411
	JMP l409
	l411:
		INC cnt
	l409:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 2
	JAE l412
	JMP l413
	l412:
		CMP dh, 10
		JBE l414
		JMP l413
	l414:
		INC cnt
	CMP dl, 18
	JE l415
	JMP l413
	l415:
		INC cnt
	l413:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 6
	JAE l416
	JMP l417
	l416:
		CMP dh, 10
		JBE l418
		JMP l417
	l418:
		INC cnt
	CMP dl, 28
	JE l419
	JMP l417
	l419:
		INC cnt
	l417:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 5
	JAE l420
	JMP l421
	l420:
		CMP dh, 10
		JBE l422
		JMP l421
	l422:
		INC cnt
	CMP dl, 50
	JE l423
	JMP l421
	l423:
		INC cnt
	l421:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 12
	JAE l424
	JMP l425
	l424:
		CMP dh, 16
		JBE l426
		JMP l425
	l426:
		INC cnt
	CMP dl, 33
	JE l427
	JMP l425
	l427:
		INC cnt
	l425:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 18
	JAE l428
	JMP l429
	l428:
		CMP dh, 23
		JBE l430
		JMP l429
	l430:
		INC cnt
	CMP dl, 40
	JE l431
	JMP l429
	l431:
		INC cnt
	l429:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 18
	JAE l432
	JMP l433
	l432:
		CMP dh, 23
		JBE l434
		JMP l433
	l434:
		INC cnt
	CMP dl, 55
	JE l435
	JMP l433
	l435:
		INC cnt
	l433:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 18
	JAE l436
	JMP l437
	l436:
		CMP dh, 19
		JBE l438
		JMP l437
	l438:
		INC cnt
	CMP dl, 70
	JE l439
	JMP l437
	l439:
		INC cnt
	l437:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 21
	JAE l440
	JMP l441
	l440:
		CMP dh, 23
		JBE l442
		JMP l441
	l442:
		INC cnt
	CMP dl, 70
	JE l443
	JMP l441
	l443:
		INC cnt
	l441:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 8
	JAE l444
	JMP l445
	l444:
		CMP dh, 12
		JBE l446
		JMP l445
	l446:
		INC cnt
	CMP dl, 70
	JE l447
	JMP l445
	l447:
		INC cnt
	l445:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 14
	JAE l448
	JMP l449
	l448:
		CMP dh, 17
		JBE l450
		JMP l449
	l450:
		INC cnt
	CMP dl, 89
	JE l451
	JMP l449
	l451:
		INC cnt
	l449:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 12
	JAE l452
	JMP l453
	l452:
		CMP dh, 18
		JBE l454
		JMP l453
	l454:
		INC cnt
	CMP dl, 96
	JE l455
	JMP l453
	l455:
		INC cnt
	l453:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 11
	JAE l456
	JMP l457
	l456:
		CMP dh, 14
		JBE l458
		JMP l457
	l458:
		INC cnt
	CMP dl, 104
	JE l459
	JMP l457
	l459:
		INC cnt
	l457:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 16
	JAE l460
	JMP l461
	l460:
		CMP dh, 18
		JBE l462
		JMP l461
	l462:
		INC cnt
	CMP dl, 104
	JE l463
	JMP l461
	l463:
		INC cnt
	l461:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 9
	JAE l464
	JMP l465
	l464:
		CMP dh, 10
		JBE l466
		JMP l465
	l466:
		INC cnt
	CMP dl, 96
	JE l467
	JMP l465
	l467:
		INC cnt
	l465:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 2
	JAE l468
	JMP l469
	l468:
		CMP dh, 5
		JBE l470
		JMP l469
	l470:
		INC cnt
	CMP dl, 100
	JE l471
	JMP l469
	l471:
		INC cnt
	l469:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 6
	JAE l472
	JMP l473
	l472:
		CMP dh, 10
		JBE l474
		JMP l473
	l474:
		INC cnt
	CMP dl, 112
	JE l475
	JMP l473
	l475:
		INC cnt
	l473:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 12
	JE l476
	JMP l478
	l476:
		INC cnt
	CMP dl, 46
	JE l477
	JMP l478
	l477:
		INC cnt
	l478:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 13
	JE l479
	JMP l481
	l479:
		INC cnt
	CMP dl, 47
	JE l480
	JMP l481
	l480:
		INC cnt
	l481:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 14
	JE l482
	JMP l484
	l482:
		INC cnt
	CMP dl, 48
	JE l483
	JMP l484
	l483:
		INC cnt
	l484:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 15
	JE l485
	JMP l487
	l485:
		INC cnt
	CMP dl, 49
	JE l486
	JMP l487
	l486:
		INC cnt
	l487:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 16
	JE l488
	JMP l490
	l488:
		INC cnt
	CMP dl, 49
	JE l489
	JMP l490
	l489:
		INC cnt
	l490:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 2
	JE l491
	JMP l493
	l491:
		INC cnt
	CMP dl, 77
	JE l492
	JMP l493
	l492:
		INC cnt
	l493:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 3
	JE l494
	JMP l496
	l494:
		INC cnt
	CMP dl, 76
	JE l495
	JMP l496
	l495:
		INC cnt
	l496:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 4
	JE l497
	JMP l499
	l497:
		INC cnt
	CMP dl, 75
	JE l498
	JMP l499
	l498:
		INC cnt
	l499:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 5
	JE l500
	JMP l502
	l500:
		INC cnt
	CMP dl, 74
	JE l501
	JMP l502
	l501:
		INC cnt
	l502:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 6
	JE l503
	JMP l505
	l503:
		INC cnt
	CMP dl, 73
	JE l504
	JMP l505
	l504:
		INC cnt
	l505:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 6
	JE l506
	JMP l508
	l506:
		INC cnt
	CMP dl, 99
	JE l507
	JMP l508
	l507:
		INC cnt
	l508:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 7
	JE l509
	JMP l510
	l509:
		INC cnt
	CMP dl, 98
	JE l511
	JMP l510
	l511:
		INC cnt
	l510:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 8
	JE l512
	JMP l514
	l512:
		INC cnt
	CMP dl, 97
	JE l513
	JMP l514
	l513:
		INC cnt
	l514:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 7
	JAE l515
	JMP l516
	l515:
		CMP dh, 10
		JBE l517
		JMP l516
	l517:
		INC cnt
	CMP dl, 60
	JE l518
	JMP l516
	l518:
		INC cnt
	l516:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 21
	JAE l519
	JMP l520
	l519:
		CMP dh, 23
		JBE l521
		JMP l520
	l521:
		INC cnt
	CMP dl, 8
	JE l522
	JMP l520
	l522:
		INC cnt
	l520:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 18
	JAE l523
	JMP l524
	l523:
		CMP dh, 19
		JBE l525
		JMP l524
	l525:
		INC cnt
	CMP dl, 8
	JE l526
	JMP l524
	l526:
		INC cnt
	l524:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	finish:
	ret
collisionWithWall ENDP

boundaryCheck PROC
	mov boundary, 0
	CMP udlr, 'l'
	JNE next1
	cmp dl, 1
	JE yes
	JMP no
	next1:
	Cmp udlr, 'r'
	JNE next2
	cmp dl, 118
	JE yes
	JMP no
	next2:
	CMP udlr, 'u'
	JNE next3
	cmp dh, 1
	JE yes
	JMP no
	next3:
	CMP udlr, 'd'
	JNE no
	cmp dh, 25
	JE yes
	JMP no
	yes:
	mov boundary, 1
	ret
	no:
	ret
boundaryCheck ENDP

LevelEnd PROC
	cmp level, 2
	JE lev2
	lev1:
	mov levE, 0
	mov ecx, 458
	mov esi, 0
	l1:
		cmp xFood[esi], -1
		JNE l2
		INC levE
	l2:
		inc esi
		loop l1
	cmp levE, 456
	JNE l3
	mov finLevel, 1
	JMP finish
	l3:
		mov levE, 0
		mov finLevel, 0
		JMP finish

	lev2:
	mov levE2, 0
	mov ecx, 264
	mov esi, 0
	l4:
		cmp xFood2[esi], -1
		JNE l5
		INC levE2
	l5:
		inc esi
		loop l4
	cmp levE2, 264
	JNE l6
	mov finLevel, 1
	JMP finish
	l6:
		mov levE2, 0
		mov finLevel, 0
	finish:
	ret
LevelEnd ENDP

mazeTwo PROC
	mov eax, brown + (brown * 16)
	call SetTextColor
	mov ecx, 119
	mov dl, 0
	mov xHurdle, dl
	mov dh, 0
	mov yHurdle, dh
	mov esi, 0
	l1:
		mov Xmaze02[esi], dl
		mov Ymaze02[esi], dh
		inc esi
		call Gotoxy
		mov edx, offset maze02
		call WriteString
		inc xHurdle
		mov dl, xHurdle
		mov dh, yHurdle
		loop l1

	mov ecx, 27
	mov dl, 119
	mov xHurdle, dl
	mov dh, 0
	mov yHurdle, dh
	l2:
		mov Xmaze02[esi], dl
		mov Ymaze02[esi], dh
		inc esi
		call Gotoxy
		mov edx, offset maze02
		call WriteString
		inc yHurdle
		mov dl, xHurdle
		mov dh, yHurdle
		loop l2

	mov ecx, 27
	mov dl, 0
	mov xHurdle, dl
	mov dh, 0
	mov yHurdle, dh
	l3:
		mov Xmaze02[esi], dl
		mov Ymaze02[esi], dh
		inc esi
		call Gotoxy
		mov edx, offset maze02
		call WriteString
		inc yHurdle
		mov dl, xHurdle
		mov dh, yHurdle
		loop l3

	mov ecx, 119
	mov dl, 0
	mov xHurdle, dl
	mov dh, 26
	mov yHurdle, dh
	l4:
		mov Xmaze02[esi], dl
		mov Ymaze02[esi], dh
		inc esi
		call Gotoxy
		mov edx, offset maze02
		call WriteString
		inc xHurdle
		mov dl, xHurdle
		mov dh, yHurdle
		loop l4

	mov ecx, 10
	mov dl, 4
	mov xHurdle, dl
	mov dh, 2
	mov yHurdle, dh
	l5:
		mov Xmaze02[esi], dl
		mov Ymaze02[esi], dh
		inc esi
		call Gotoxy
		mov edx, offset maze02
		call WriteString
		inc xHurdle
		mov dl, xHurdle
		mov dh, yHurdle
		loop l5

	mov ecx, 10
	mov dl, 4
	mov xHurdle, dl
	mov dh, 2
	mov yHurdle, dh
	l6:
		mov Xmaze02[esi], dl
		mov Ymaze02[esi], dh
		inc esi
		call Gotoxy
		mov edx, offset maze02
		call WriteString
		inc yHurdle
		mov dl, xHurdle
		mov dh, yHurdle
		loop l6

	mov ecx, 10
	mov dl, 56
	mov xHurdle, dl
	mov dh, 7
	mov yHurdle, dh
	l7:
		mov Xmaze02[esi], dl
		mov Ymaze02[esi], dh
		inc esi
		call Gotoxy
		mov edx, offset maze02
		call WriteString
		inc yHurdle
		mov dl, xHurdle
		mov dh, yHurdle
		loop l7
		
	mov ecx, 21
	mov dl, 46
	mov xHurdle, dl
	mov dh, 7
	mov yHurdle, dh
	l8:
		mov Xmaze02[esi], dl
		mov Ymaze02[esi], dh
		inc esi
		call Gotoxy
		mov edx, offset maze02
		call WriteString
		inc xHurdle
		mov dl, xHurdle
		mov dh, yHurdle
		loop l8
		
	mov ecx, 25
	mov dl, 0
	mov xHurdle, dl
	mov dh, 20
	mov yHurdle, dh
	l9:
		mov Xmaze02[esi], dl
		mov Ymaze02[esi], dh
		inc esi
		call Gotoxy
		mov edx, offset maze02
		call WriteString
		inc xHurdle
		mov dl, xHurdle
		mov dh, yHurdle
		loop l9
		
	mov ecx, 16
	mov dl, 103
	mov xHurdle, dl
	mov dh, 14
	mov yHurdle, dh
	l10:
		mov Xmaze02[esi], dl
		mov Ymaze02[esi], dh
		inc esi
		call Gotoxy
		mov edx, offset maze02
		call WriteString
		inc xHurdle
		mov dl, xHurdle
		mov dh, yHurdle
		loop l10
		
	mov ecx, 10
	mov dl, 15
	mov xHurdle, dl
	mov dh, 5
	mov yHurdle, dh
	l11:
		mov Xmaze02[esi], dl
		mov Ymaze02[esi], dh
		inc esi
		call Gotoxy
		mov edx, offset maze02
		call WriteString
		inc yHurdle
		mov dl, xHurdle
		mov dh, yHurdle
		loop l11
		
	mov ecx, 10
	mov dl, 31
	mov xHurdle, dl
	mov dh, 5
	mov yHurdle, dh
	l12:
		mov Xmaze02[esi], dl
		mov Ymaze02[esi], dh
		inc esi
		call Gotoxy
		mov edx, offset maze02
		call WriteString
		inc yHurdle
		mov dl, xHurdle
		mov dh, yHurdle
		loop l12
		
	mov ecx, 17
	mov dl, 15
	mov xHurdle, dl
	mov dh, 15
	mov yHurdle, dh
	l13:
		mov Xmaze02[esi], dl
		mov Ymaze02[esi], dh
		inc esi
		call Gotoxy
		mov edx, offset maze02
		call WriteString
		inc xHurdle
		mov dl, xHurdle
		mov dh, yHurdle
		loop l13
		
	mov ecx, 24
	mov dl, 95
	mov xHurdle, dl
	mov dh, 3
	mov yHurdle, dh
	l14:
		mov Xmaze02[esi], dl
		mov Ymaze02[esi], dh
		inc esi
		call Gotoxy
		mov edx, offset maze02
		call WriteString
		inc xHurdle
		mov dl, xHurdle
		mov dh, yHurdle
		loop l14
		
	mov ecx, 25
	mov dl, 76
	mov xHurdle, dl
	mov dh, 18
	mov yHurdle, dh
	l15:
		mov Xmaze02[esi], dl
		mov Ymaze02[esi], dh
		inc esi
		call Gotoxy
		mov edx, offset maze02
		call WriteString
		inc xHurdle
		mov dl, xHurdle
		mov dh, yHurdle
		loop l15
		
	mov ecx, 25
	mov dl, 76
	mov xHurdle, dl
	mov dh, 8
	mov yHurdle, dh
	l16:
		mov Xmaze02[esi], dl
		mov Ymaze02[esi], dh
		inc esi
		call Gotoxy
		mov edx, offset maze02
		call WriteString
		inc xHurdle
		mov dl, xHurdle
		mov dh, yHurdle
		loop l16
		
	mov ecx, 25
	mov dl, 40
	mov xHurdle, dl
	mov dh, 20
	mov yHurdle, dh
	l17:
		mov Xmaze02[esi], dl
		mov Ymaze02[esi], dh
		inc esi
		call Gotoxy
		mov edx, offset maze02
		call WriteString
		inc xHurdle
		mov dl, xHurdle
		mov dh, yHurdle
		loop l17
		
	mov ecx, 6
	mov dl, 72
	mov xHurdle, dl
	mov dh, 0
	mov yHurdle, dh
	l18:
		mov Xmaze02[esi], dl
		mov Ymaze02[esi], dh
		inc esi
		call Gotoxy
		mov edx, offset maze02
		call WriteString
		inc yHurdle
		mov dl, xHurdle
		mov dh, yHurdle
		loop l18
		
	mov ecx, 10
	mov dl, 36
	mov xHurdle, dl
	mov dh, 0
	mov yHurdle, dh
	l19:
		mov Xmaze02[esi], dl
		mov Ymaze02[esi], dh
		inc esi
		call Gotoxy
		mov edx, offset maze02
		call WriteString
		inc yHurdle
		mov dl, xHurdle
		mov dh, yHurdle
		loop l19
		
	mov ecx, 10
	mov dl, 88
	mov xHurdle, dl
	mov dh, 9
	mov yHurdle, dh
	l20:
		mov Xmaze02[esi], dl
		mov Ymaze02[esi], dh
		inc esi
		call Gotoxy
		mov edx, offset maze02
		call WriteString
		inc yHurdle
		mov dl, xHurdle
		mov dh, yHurdle
		loop l20

	ret
mazeTwo ENDP

DrawFood2 PROC
	mov eax, blue + (black * 16)
	call SetTextColor
	mov esi, 0
	mov ecx, 264
	l1:
		mov dl, xFood2[esi]
		mov dh, yFood2[esi]
		call Gotoxy
		mov edx, offset food
		call writeString
		inc esi
		loop l1

	ret
DrawFood2 ENDP

CollisionWithWall2 PROC
	mov collide, 0
	CMP udlr, 'd'
	JE for_d
	CMP udlr, 'u'
	JE for_u
	CMP udlr, 'l'
	JE for_l
	CMP udlr, 'r'
	JE for_r
	JMP finish
for_d:
	CMP dl, 4
	JAE l0d
	JMP l4d
	l0d:
		CMP dl, 13
		JBE l1d
		JMP l4d
	l1d:
		INC cnt
	CMP dh, 1
	JE l3d
	JMP l4d
	l3d:
		INC cnt
	l4d:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 76
	JAE l5d
	JMP l8d
	l5d:
		CMP dl, 100
		JBE l6d
		JMP l8d
	l6d:
		INC cnt
	CMP dh, 7
	JE l7d
	JMP l8d
	l7d:
		INC cnt
	l8d:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 76
	JAE l9d
	JMP l12d
	l9d:
		CMP dl, 100
		JBE l10d
		JMP l12d
	l10d:
		INC cnt
	CMP dh, 17
	JE l11d
	JMP l12d
	l11d:
		INC cnt
	l12d:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 95
	JAE l13d
	JMP l16d
	l13d:
		CMP dl, 118
		JBE l14d
		JMP l16d
	l14d:
		INC cnt
	CMP dh, 2
	JE l15d
	JMP l16d
	l15d:
		INC cnt
	l16d:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 103
	JAE l17d
	JMP l20d
	l17d:
		CMP dl, 118
		JBE l18d
		JMP l20d
	l18d:
		INC cnt
	CMP dh, 13
	JE l19d
	JMP l20d
	l19d:
		INC cnt
	l20d:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 1
	JAE l21d
	JMP l24d
	l21d:
		CMP dl, 24
		JBE l22d
		JMP l24d
	l22d:
		INC cnt
	CMP dh, 19
	JE l23d
	JMP l24d
	l23d:
		INC cnt
	l24d:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 40
	JAE l25d
	JMP l28d
	l25d:
		CMP dl, 64
		JBE l26d
		JMP l28d
	l26d:
		INC cnt
	CMP dh, 19
	JE l27d
	JMP l28d
	l27d:
		INC cnt
	l28d:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 16
	JAE l29d
	JMP l32d
	l29d:
		CMP dl, 30
		JBE l30d
		JMP l32d
	l30d:
		INC cnt
	CMP dh, 14
	JE l31d
	JMP l32d
	l31d:
		INC cnt
	l32d:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 46
	JAE l33d
	JMP l36d
	l33d:
		CMP dl, 66
		JBE l34d
		JMP l36d
	l34d:
		INC cnt
	CMP dh, 6
	JE l35d
	JMP l36d
	l35d:
		INC cnt
	l36d:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 4
	JE l37d
	JMP l39d
	l37d:
		INC cnt
	CMP dl, 15
	JE l38d
	JMP l39d
	l38d:
		INC cnt
	l39d:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 4
	JE l40d
	JMP l42d
	l40d:
		INC cnt
	CMP dl, 31
	JE l41d
	JMP l42d
	l41d:
		INC cnt
	l42d:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	JMP finish
for_u:
	CMP dl, 5
	JAE l0u
	JMP l4u
	l0u:
		CMP dl, 13
		JBE l1u
		JMP l4u
	l1u:
		INC cnt
	CMP dh, 3
	JE l3u
	JMP l4u
	l3u:
		INC cnt
	l4u:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 76
	JAE l5u
	JMP l8u
	l5u:
		CMP dl, 100
		JBE l6u
		JMP l8u
	l6u:
		INC cnt
	CMP dh, 19
	JE l7u
	JMP l8u
	l7u:
		INC cnt
	l8u:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 76
	JAE l9u
	JMP l12u
	l9u:
		CMP dl, 100
		JBE l10u
		JMP l12u
	l10u:
		INC cnt
	CMP dh, 9
	JE l11u
	JMP l12u
	l11u:
		INC cnt
	l12u:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 95
	JAE l13u
	JMP l16u
	l13u:
		CMP dl, 118
		JBE l14u
		JMP l16u
	l14u:
		INC cnt
	CMP dh, 4
	JE l15u
	JMP l16u
	l15u:
		INC cnt
	l16u:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 103
	JAE l17u
	JMP l20u
	l17u:
		CMP dl, 118
		JBE l18u
		JMP l20u
	l18u:
		INC cnt
	CMP dh, 15
	JE l19u
	JMP l20u
	l19u:
		INC cnt
	l20u:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 1
	JAE l21u
	JMP l24u
	l21u:
		CMP dl, 24
		JBE l22u
		JMP l24u
	l22u:
		INC cnt
	CMP dh, 21
	JE l23u
	JMP l24u
	l23u:
		INC cnt
	l24u:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 40
	JAE l25u
	JMP l28u
	l25u:
		CMP dl, 64
		JBE l26u
		JMP l28u
	l26u:
		INC cnt
	CMP dh, 21
	JE l27u
	JMP l28u
	l27u:
		INC cnt
	l28u:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 15
	JAE l29u
	JMP l32u
	l29u:
		CMP dl, 31
		JBE l30u
		JMP l32u
	l30u:
		INC cnt
	CMP dh, 16
	JE l31u
	JMP l32u
	l31u:
		INC cnt
	l32u:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dl, 46
	JAE l33u
	JMP l36u
	l33u:
		CMP dl, 66
		JBE l34u
		JMP l36u
	l34u:
		INC cnt
	CMP dh, 8
	JE l35u
	JMP l36u
	l35u:
		INC cnt
	l36u:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 10
	JE l37u
	JMP l39u
	l37u:
		INC cnt
	CMP dl, 36	
	JE l38u
	JMP l39u
	l38u:
		INC cnt
	l39u:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 6
	JE l40u
	JMP l42u
	l40u:
		INC cnt
	CMP dl, 72
	JE l41u
	JMP l42u
	l41u:
		INC cnt
	l42u:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 12
	JE l43u
	JMP l45u
	l43u:
		INC cnt
	CMP dl, 4
	JE l44u
	JMP l45u
	l44u:
		INC cnt
	l45u:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 17
	JE l46u
	JMP l48u
	l46u:
		INC cnt
	CMP dl, 56
	JE l47u
	JMP l48u
	l47u:
		INC cnt
	l48u:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	JMP finish
for_l:
	CMP dh, 3
	JAE l0l
	JMP l4l
	l0l:
		CMP dh, 11
		JBE l1l
		JMP l4l
	l1l:
		INC cnt
	CMP dl, 5
	JE l3l
	JMP l4l
	l3l:
		INC cnt
	l4l:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 9
	JAE l5l
	JMP l8l
	l5l:
		CMP dh, 17
		JBE l6l
		JMP l8l
	l6l:
		INC cnt
	CMP dl, 89
	JE l7l
	JMP l8l
	l7l:
		INC cnt
	l8l:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 5
	JAE l9l
	JMP l12l
	l9l:
		CMP dh, 14
		JBE l10l
		JMP l12l
	l10l:
		INC cnt
	CMP dl, 16
	JE l11l
	JMP l12l
	l11l:
		INC cnt
	l12l:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 5
	JAE l13l
	JMP l16l
	l13l:
		CMP dh, 15
		JBE l14l
		JMP l16l
	l14l:
		INC cnt
	CMP dl, 32
	JE l15l
	JMP l16l
	l15l:
		INC cnt
	l16l:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 1
	JAE l17l
	JMP l20l
	l17l:
		CMP dh, 9
		JBE l18l
		JMP l20l
	l18l:
		INC cnt
	CMP dl, 37
	JE l19l
	JMP l20l
	l19l:
		INC cnt
	l20l:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 1
	JAE l21l
	JMP l24l
	l21l:
		CMP dh, 5
		JBE l22l
		JMP l24l
	l22l:
		INC cnt
	CMP dl, 73
	JE l23l
	JMP l24l
	l23l:
		INC cnt
	l24l:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 8
	JAE l25l
	JMP l28l
	l25l:
		CMP dh, 16
		JBE l26l
		JMP l28l
	l26l:
		INC cnt
	CMP dl, 57
	JE l27l
	JMP l28l
	l27l:
		INC cnt
	l28l:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 8
	JE l29l
	JMP l31l
	l29l:
		INC cnt
	CMP dl, 101
	JE l30l
	JMP l31l
	l30l:
		INC cnt
	l31l:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 18
	JE l32l
	JMP l34l
	l32l:
		INC cnt
	CMP dl, 101
	JE l33l
	JMP l34l
	l33l:
		INC cnt
	l34l:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 20
	JE l35l
	JMP l37l
	l35l:
		INC cnt
	CMP dl, 25
	JE l36l
	JMP l37l
	l36l:
		INC cnt
	l37l:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 20
	JE l38l
	JMP l40l
	l38l:
		INC cnt
	CMP dl, 65
	JE l39l
	JMP l40l
	l39l:
		INC cnt
	l40l:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 7
	JE l41l
	JMP l43l
	l41l:
		INC cnt
	CMP dl, 67
	JE l42l
	JMP l43l
	l42l:
		INC cnt
	l43l:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 2
	JE l44l
	JMP l46l
	l44l:
		INC cnt
	CMP dl, 14
	JE l45l
	JMP l46l
	l45l:
		INC cnt
	l46l:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	JMP finish
for_r:
	CMP dh, 2
	JAE l0r
	JMP l4r
	l0r:
		CMP dh, 11
		JBE l1r
		JMP l4r
	l1r:
		INC cnt
	CMP dl, 3
	JE l3r
	JMP l4r
	l3r:
		INC cnt
	l4r:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 9
	JAE l5r
	JMP l8r
	l5r:
		CMP dh, 17
		JBE l6r
		JMP l8r
	l6r:
		INC cnt
	CMP dl, 87
	JE l7r
	JMP l8r
	l7r:
		INC cnt
	l8r:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 5
	JAE l9r
	JMP l12r
	l9r:
		CMP dh, 15
		JBE l10r
		JMP l12r
	l10r:
		INC cnt
	CMP dl, 14
	JE l11r
	JMP l12r
	l11r:
		INC cnt
	l12r:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 5
	JAE l13r
	JMP l16r
	l13r:
		CMP dh, 14
		JBE l14r
		JMP l16r
	l14r:
		INC cnt
	CMP dl, 30
	JE l15r
	JMP l16r
	l15r:
		INC cnt
	l16r:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 1
	JAE l17r
	JMP l20r
	l17r:
		CMP dh, 9
		JBE l18r
		JMP l20r
	l18r:
		INC cnt
	CMP dl, 35
	JE l19r
	JMP l20r
	l19r:
		INC cnt
	l20r:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 1
	JAE l21r
	JMP l24r
	l21r:
		CMP dh, 5
		JBE l22r
		JMP l24r
	l22r:
		INC cnt
	CMP dl, 71
	JE l23r
	JMP l24r
	l23r:
		INC cnt
	l24r:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 8
	JAE l25r
	JMP l28r
	l25r:
		CMP dh, 16
		JBE l26r
		JMP l28r
	l26r:
		INC cnt
	CMP dl, 55
	JE l27r
	JMP l28r
	l27r:
		INC cnt
	l28r:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 8
	JE l29r
	JMP l31r
	l29r:
		INC cnt
	CMP dl, 75
	JE l30r
	JMP l31r
	l30r:
		INC cnt
	l31r:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 18
	JE l32r
	JMP l34r
	l32r:
		INC cnt
	CMP dl, 75
	JE l33r
	JMP l34r
	l33r:
		INC cnt
	l34r:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 3
	JE l35r
	JMP l37r
	l35r:
		INC cnt
	CMP dl, 94
	JE l36r
	JMP l37r
	l36r:
		INC cnt
	l37r:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 14
	JE l38r
	JMP l40r
	l38r:
		INC cnt
	CMP dl, 102
	JE l39r
	JMP l40r
	l39r:
		INC cnt
	l40r:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 20
	JE l41r
	JMP l43r
	l41r:
		INC cnt
	CMP dl, 39
	JE l42r
	JMP l43r
	l42r:
		INC cnt
	l43r:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	CMP dh, 7
	JE l44r
	JMP l46r
	l44r:
		INC cnt
	CMP dl, 45
	JE l45r
	JMP l46r
	l45r:
		INC cnt
	l46r:
	CMP cnt, 2
	JE finish
	mov cnt, 0

	JMP finish

	finish:
	ret
CollisionWithWall2 ENDP

CollisionWithGhost2 PROC
	mov collide, 0
	mov dl, xGhost
	mov dh, yGhost
	cmp dl, xPos
	JE l1
	JMP l3
	l1:
		cmp dh, yPos
		JE l2
		JMP l3
	l2:
		dec lives
		call UpdatePlayer
		mov xPos, 60
		mov yPos, 24
		call DrawPlayer
		mov collide, 1
		JMP finish
	l3:
	mov dl, xGhost
	mov dh, yGhost
	dec dl
	cmp dl, xPos
	JE l4
	JMP l6
	l4:
		cmp dh, yPos
		JE l5
		JMP l6
	l5:
		dec lives
		call UpdatePlayer
		mov xPos, 60
		mov yPos, 24
		call DrawPlayer
		mov collide, 1
		JMP finish
	l6:
	mov dl, xGhost
	mov dh, yGhost
	inc dl
	cmp dl, xPos
	JE l7
	JMP l9
	l7:
		cmp dh, yPos
		JE l8
		JMP l9
	l8:
		dec lives
		call UpdatePlayer
		mov xPos, 60
		mov yPos, 24
		call DrawPlayer
		mov collide, 1
		JMP finish
	l9:
	mov dl, xGhost
	mov dh, yGhost
	inc dh
	cmp dl, xPos
	JE l10
	JMP l12
	l10:
		cmp dh, yPos
		JE l11
		JMP l12
	l11:
		dec lives
		call UpdatePlayer
		mov xPos, 60
		mov yPos, 24
		call DrawPlayer
		mov collide, 1
		JMP finish
	l12:
	mov dl, xGhost
	mov dh, yGhost
	dec dh
	cmp dl, xPos
	JE l13
	JMP l15
	l13:
		cmp dh, yPos
		JE l14
		JMP l15
	l14:
		dec lives
		call UpdatePlayer
		mov xPos, 60
		mov yPos, 24
		call DrawPlayer
		mov collide, 1
		JMP finish
	l15:
	finish:
	ret
CollisionWithGhost2 ENDP

FoodCheck2 PROC
	mov cnt, 0
	mov ecx, 264
	mov esi, 0
	l1:
		cmp dl, xFood2[esi]
		JE l2
		JMP l4
	l2:
		inc cnt
		cmp dh, yFood2[esi]
		JE l3
		JMP l4
	l3:
		inc cnt
		JMP l5
	l4:
		inc esi
		mov cnt,0
		loop l1
	l5:
		cmp cnt, 2
		JE finish
		JMP finish1
	finish:
		mov xFood2[esi], -1
		mov yFood2[esi], -1
		INC score
		ret
	finish1:
	ret
FoodCheck2 ENDP

UpdateGhost2 PROC
	mov dl,xGhost
	mov dh,yGhost
	call Gotoxy

	mov esi, 0
	mov ecx, 264
	l1:
		cmp dl, xFood2[esi]
		JE l2
		inc esi
		loop l1
		JMP l4
	l2:
		cmp dh, yFood2[esi]
		JE l3
		inc esi
		loop l1
		JMP l4
	l3:
		mov eax, magenta + (black * 16)
		call setTextColor
		mov al, "*"
		call writeChar
		JMP finish
	l4:
	mov eax, black + (black * 16)
	call setTextColor
	mov al," "
	call WriteChar
	finish:
	ret
UpdateGhost2 ENDP

END main