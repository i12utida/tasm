_stdin
	WS	1
_stdout
	WS	1
_stderr
	WS	1
__alcAddr
	WS	1
_errno
	WS	1
_sourcefp
	WS	1
_hexfp
	WS	1
_listfp
	WS	1
_pass1flag
	WS	1
.L1
	BS	32
.filename
	DW	.L1
.L2
	STRING	"usage: %s [-h] [<source file>]\n"
.L3
	STRING	"\n"
.L4
	STRING	"    -h : show this message\n"
.L5
	STRING	"\n"
.usage
	ENTRY	0
	LDP	1
	ARG
	LDC	.L2
	ARG
	LDG	_stderr
	ARG
	CALLF	3,_fprintf
	POP
	LDC	.L3
	ARG
	LDG	_stderr
	ARG
	CALLF	2,_fprintf
	POP
	LDC	.L4
	ARG
	LDG	_stderr
	ARG
	CALLF	2,_fprintf
	POP
	LDC	.L5
	ARG
	LDG	_stderr
	ARG
	CALLF	2,_fprintf
	POP
	RET
.L6
	STRING	"引数が足りていません"
.L7
	STRING	"-h"
.L8
	STRING	"file name is too long"
.L9
	STRING	"r"
.L10
	STRING	"%s\n"
.L11
	STRING	"w"
.L12
	STRING	"w"
.L13
	STRING	"引数が多すぎます"
.L14
	STRING	"r"
_main
	ENTRY	3
	LDC	1
	STL	1
	POP
	LDP	1
	LDL	1
	EQ
	JF	.L15
	LDC	.L6
	ARG
	CALLP	1,_error
	LDC	65524
	ARG
	CALLP	1,_exit
	LDC	65535
	MREG
	JMP	.L16
.L15
	LDP	1
	LDL	1
	GT
	JF	.L17
	LDC	.L7
	ARG
	LDP	2
	LDL	1
	LDW
	ARG
	CALLF	2,_strCmp
	LDC	0
	EQ
	JF	.L17
	LDP	2
	LDC	0
	LDW
	ARG
	CALLP	1,.usage
	LDC	0
	MREG
	JMP	.L16
.L17
	LDP	2
	LDL	1
	LDW
	ARG
	CALLF	1,_strLen
	STL	3
	POP
	LDL	3
	LDC	30
	LE
	JF	.L18
	LDP	2
	LDL	1
	LDW
	ARG
	LDG	.filename
	ARG
	CALLF	2,_strCpy
	POP
	JMP	.L19
.L18
	LDC	.L8
	ARG
	CALLP	1,_error
	LDC	1
	ARG
	CALLP	1,_exit
.L19
	LDL	1
	LDC	1
	ADD
	LDP	1
	EQ
	JF	.L20
	LDG	.filename
	LDL	3
	LDC	65533
	ADD
	LDB
	LDC	46
	EQ
	JF	.L21
	LDG	.filename
	LDL	3
	LDC	65534
	ADD
	LDB
	LDC	116
	EQ
	JF	.L21
	LDG	.filename
	LDL	3
	LDC	65535
	ADD
	LDB
	LDC	55
	EQ
	JF	.L21
	LDC	.L9
	ARG
	LDP	2
	LDL	1
	LDW
	ARG
	CALLF	2,_fopen
	STG	_sourcefp
	POP
	LDG	_sourcefp
	LDC	0
	EQ
	JF	.L22
	LDP	2
	LDL	1
	LDW
	ARG
	CALLP	1,_perror
	LDC	65535
	MREG
	JMP	.L16
.L22
	JMP	.L23
.L21
	LDP	2
	LDC	0
	LDW
	ARG
	CALLP	1,.usage
.L23
	LDC	108
	LDG	.filename
	LDL	3
	LDC	65534
	ADD
	STB
	POP
	LDC	115
	LDG	.filename
	LDL	3
	LDC	65535
	ADD
	STB
	POP
	LDC	116
	LDG	.filename
	LDL	3
	STB
	POP
	LDC	0
	LDG	.filename
	LDL	3
	LDC	1
	ADD
	STB
	POP
	LDG	.filename
	ARG
	LDC	.L10
	ARG
	CALLF	2,_printf
	POP
	LDC	.L11
	ARG
	LDG	.filename
	ARG
	CALLF	2,_fopen
	STG	_listfp
	POP
	LDG	_listfp
	LDC	0
	EQ
	JF	.L24
	LDG	.filename
	ARG
	CALLP	1,_perror
	LDC	65535
	MREG
	JMP	.L16
.L24
	LDC	98
	LDG	.filename
	LDL	3
	LDC	65534
	ADD
	STB
	POP
	LDC	105
	LDG	.filename
	LDL	3
	LDC	65535
	ADD
	STB
	POP
	LDC	110
	LDG	.filename
	LDL	3
	STB
	POP
	LDC	0
	LDG	.filename
	LDL	3
	LDC	1
	ADD
	STB
	POP
	LDC	.L12
	ARG
	LDG	.filename
	ARG
	CALLF	2,_fopen
	STG	_hexfp
	POP
	LDG	_hexfp
	LDC	0
	EQ
	JF	.L25
	LDG	.filename
	ARG
	CALLP	1,_perror
	LDC	65535
	MREG
	JMP	.L16
.L25
.L20
	LDP	1
	LDC	2
	GT
	JF	.L26
	LDC	.L13
	ARG
	CALLP	1,_error
	LDC	65535
	MREG
	JMP	.L16
.L26
	CALLP	0,_initPass1
	LDG	_sourcefp
	ARG
	CALLP	1,_pass1
	LDG	_sourcefp
	ARG
	CALLF	1,_fclose
	POP
	LDC	.L14
	ARG
	LDP	2
	LDC	1
	LDW
	ARG
	CALLF	2,_fopen
	STG	_sourcefp
	POP
	CALLP	0,_initPass2
	LDG	_hexfp
	ARG
	LDG	_listfp
	ARG
	LDG	_sourcefp
	ARG
	CALLP	3,_pass2
	LDG	_listfp
	ARG
	CALLF	1,_fclose
	POP
	LDG	_hexfp
	ARG
	CALLF	1,_fclose
	POP
	LDC	0
	MREG
.L16
	RET
