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
	STRING	"使用方法 : %s [-h] [<source file>]\n"
.L2
	STRING	"    <source file> is assembly source file\n"
.L3
	STRING	"    assemble result will be shown Tasm.list \n"
.L4
	STRING	"\n"
.L5
	STRING	"    -h : show this message\n"
.L6
	STRING	"\n"
.usage
	ENTRY	0
	LDP	1
	ARG
	LDC	.L1
	ARG
	LDG	_stderr
	ARG
	CALLF	3,_fprintf
	POP
	LDC	.L2
	ARG
	LDG	_stderr
	ARG
	CALLF	2,_fprintf
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
	LDC	.L6
	ARG
	LDG	_stderr
	ARG
	CALLF	2,_fprintf
	POP
	RET
.L7
	STRING	"引数が足りていません"
.L8
	STRING	"-h"
.L9
	STRING	"r"
.L10
	STRING	"list.lst"
.L11
	STRING	"w"
.L12
	STRING	"test.hex"
.L13
	STRING	"w"
.L14
	STRING	"list.lst"
.L15
	STRING	"hex.bin"
.L16
	STRING	"引数が多すぎます"
.L17
	STRING	"r"
_main
	ENTRY	1
	LDC	1
	STL	1
	POP
	LDP	1
	LDL	1
	EQ
	JF	.L18
	LDC	.L7
	ARG
	CALLP	1,_error
	LDC	65524
	ARG
	CALLP	1,_exit
	LDC	65535
	MREG
	JMP	.L19
.L18
	LDP	1
	LDL	1
	GT
	JF	.L20
	LDC	.L8
	ARG
	LDP	2
	LDL	1
	LDW
	ARG
	CALLF	2,_strCmp
	LDC	0
	EQ
	JF	.L20
	LDP	2
	LDC	0
	LDW
	ARG
	CALLP	1,.usage
	LDC	0
	MREG
	JMP	.L19
.L20
	LDL	1
	LDC	1
	ADD
	LDP	1
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
	LDC	.L11
	ARG
	LDC	.L10
	ARG
	CALLF	2,_fopen
	STG	_listfp
	POP
	LDC	.L13
	ARG
	LDC	.L12
	ARG
	CALLF	2,_fopen
	STG	_hexfp
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
	JMP	.L19
.L22
	LDG	_listfp
	LDC	0
	EQ
	JF	.L23
	LDC	.L14
	ARG
	CALLP	1,_perror
	LDC	65535
	MREG
	JMP	.L19
.L23
	LDG	_hexfp
	LDC	0
	EQ
	JF	.L24
	LDC	.L15
	ARG
	CALLP	1,_perror
	LDC	65535
	MREG
	JMP	.L19
.L24
.L21
	LDP	1
	LDC	2
	GT
	JF	.L25
	LDC	.L16
	ARG
	CALLP	1,_error
	LDC	65535
	MREG
	JMP	.L19
.L25
	CALLP	0,_initPass1
	LDG	_sourcefp
	ARG
	CALLP	1,_pass1
	LDG	_sourcefp
	ARG
	CALLF	1,_fclose
	POP
	LDC	.L17
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
.L19
	RET
