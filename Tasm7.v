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
_binaryfp
	WS	1
_listfp
	WS	1
_pass1flag
	WS	1
_pass2flag
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
	STRING	"binary.bin"
.L13
	STRING	"w"
.L14
	STRING	"list.lst"
.L15
	STRING	"binary.bin"
.L16
	STRING	"引数が多すぎます"
_main
	ENTRY	1
	LDC	1
	STL	1
	POP
	LDP	1
	LDL	1
	EQ
	JF	.L17
	LDC	.L7
	ARG
	CALLP	1,_error
	LDC	65524
	ARG
	CALLP	1,_exit
	LDC	65535
	MREG
	JMP	.L18
.L17
	LDP	1
	LDL	1
	GT
	JF	.L19
	LDC	.L8
	ARG
	LDP	2
	LDL	1
	LDW
	ARG
	CALLF	2,_strCmp
	LDC	0
	EQ
	JF	.L19
	LDP	2
	LDC	0
	LDW
	ARG
	CALLP	1,.usage
	LDC	0
	MREG
	JMP	.L18
.L19
	LDL	1
	LDC	1
	ADD
	LDP	1
	EQ
	JF	.L20
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
	STG	_binaryfp
	POP
	LDG	_sourcefp
	LDC	0
	EQ
	JF	.L21
	LDP	2
	LDL	1
	LDW
	ARG
	CALLP	1,_perror
	LDC	65535
	MREG
	JMP	.L18
.L21
	LDG	_listfp
	LDC	0
	EQ
	JF	.L22
	LDC	.L14
	ARG
	CALLP	1,_perror
	LDC	65535
	MREG
	JMP	.L18
.L22
	LDG	_binaryfp
	LDC	0
	EQ
	JF	.L23
	LDC	.L15
	ARG
	CALLP	1,_perror
	LDC	65535
	MREG
	JMP	.L18
.L23
.L20
	LDP	1
	LDC	2
	GT
	JF	.L24
	LDC	.L16
	ARG
	CALLP	1,_error
	LDC	65535
	MREG
	JMP	.L18
.L24
	CALLP	0,_initPass1
	LDG	_sourcefp
	ARG
	CALLP	1,_pass1
	LDG	_sourcefp
	ARG
	CALLF	1,_fclose
	POP
	LDG	_listfp
	ARG
	CALLF	1,_fclose
	POP
	LDG	_binaryfp
	ARG
	CALLF	1,_fclose
	POP
	LDC	0
	MREG
.L18
	RET
