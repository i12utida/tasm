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
_ch
	WS	1
_nextch
	WS	1
_token
	WS	1
_str
	WS	1
_pass1flag
	WS	1
_dc
	WS	1
_ds
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
	STRING	"と\n"
.L8
	STRING	"引数が足りていません"
.L9
	STRING	"-h"
.L10
	STRING	"r"
.L11
	STRING	"list.lst"
.L12
	STRING	"w"
.L13
	STRING	"binary.bin"
.L14
	STRING	"w"
.L15
	STRING	"list.lst"
.L16
	STRING	"binary.bin"
.L17
	STRING	"引数が多すぎます"
.L18
	STRING	"r"
_main
	ENTRY	1
	LDC	.L7
	ARG
	CALLF	1,_printf
	POP
	LDC	1
	STL	1
	POP
	LDP	1
	LDL	1
	EQ
	JF	.L19
	LDC	.L8
	ARG
	CALLP	1,_error
	LDC	65524
	ARG
	CALLP	1,_exit
	LDC	65535
	MREG
	JMP	.L20
.L19
	LDP	1
	LDL	1
	GT
	JF	.L21
	LDC	.L9
	ARG
	LDP	2
	LDL	1
	LDW
	ARG
	CALLF	2,_strCmp
	LDC	0
	EQ
	JF	.L21
	LDP	2
	LDC	0
	LDW
	ARG
	CALLP	1,.usage
	LDC	0
	MREG
	JMP	.L20
.L21
	LDL	1
	LDC	1
	ADD
	LDP	1
	EQ
	JF	.L22
	LDC	.L10
	ARG
	LDP	2
	LDL	1
	LDW
	ARG
	CALLF	2,_fopen
	STG	_sourcefp
	POP
	LDC	.L12
	ARG
	LDC	.L11
	ARG
	CALLF	2,_fopen
	STG	_listfp
	POP
	LDC	.L14
	ARG
	LDC	.L13
	ARG
	CALLF	2,_fopen
	STG	_binaryfp
	POP
	LDG	_sourcefp
	LDC	0
	EQ
	JF	.L23
	LDP	2
	LDL	1
	LDW
	ARG
	CALLP	1,_perror
	LDC	65535
	MREG
	JMP	.L20
.L23
	LDG	_listfp
	LDC	0
	EQ
	JF	.L24
	LDC	.L15
	ARG
	CALLP	1,_perror
	LDC	65535
	MREG
	JMP	.L20
.L24
	LDG	_binaryfp
	LDC	0
	EQ
	JF	.L25
	LDC	.L16
	ARG
	CALLP	1,_perror
	LDC	65535
	MREG
	JMP	.L20
.L25
.L22
	LDP	1
	LDC	2
	GT
	JF	.L26
	LDC	.L17
	ARG
	CALLP	1,_error
	LDC	65535
	MREG
	JMP	.L20
.L26
	LDC	0
	STG	_token
	POP
	CALLP	0,_Initialization
.L27
	CALLF	0,_pass1
	JF	.L28
	JMP	.L27
.L28
	LDC	1
	STG	_pass1flag
	POP
	LDG	_sourcefp
	ARG
	CALLF	1,_fclose
	POP
	CALLP	0,_Initialization
	LDC	.L18
	ARG
	LDP	2
	LDC	1
	LDW
	ARG
	CALLF	2,_fopen
	STG	_sourcefp
	POP
.L29
	CALLF	0,_pass2
	JF	.L30
	JMP	.L29
.L30
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
	LDG	_ds
	ARG
	CALLP	1,_free
	LDC	0
	MREG
.L20
	RET
