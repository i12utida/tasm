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
	STRING	"使用方法 : %s [-h] [<source file>]\n"
.L3
	STRING	"    <source file> is assembly source file\n"
.L4
	STRING	"    assemble result will be shown Tasm.list \n"
.L5
	STRING	"\n"
.L6
	STRING	"    -h : show this message\n"
.L7
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
	LDC	.L6
	ARG
	LDG	_stderr
	ARG
	CALLF	2,_fprintf
	POP
	LDC	.L7
	ARG
	LDG	_stderr
	ARG
	CALLF	2,_fprintf
	POP
	RET
.L8
	STRING	"引数が足りていません"
.L9
	STRING	"-h"
.L10
	STRING	"file name is too long"
.L11
	STRING	"r"
.L12
	STRING	"%s\n"
.L13
	STRING	"w"
.L14
	STRING	"w"
.L15
	STRING	"引数が多すぎます"
.L16
	STRING	"r"
_main
	ENTRY	3
	LDC	1
	STL	1
	POP
	LDP	1
	LDL	1
	EQ
	JF	.L17
	LDC	.L8
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
	LDC	.L9
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
	JF	.L20
	LDP	2
	LDL	1
	LDW
	ARG
	LDG	.filename
	ARG
	CALLF	2,_strCpy
	POP
	JMP	.L21
.L20
	LDC	.L10
	ARG
	CALLP	1,_error
.L21
	LDL	1
	LDC	1
	ADD
	LDP	1
	EQ
	JF	.L22
	LDG	.filename
	LDL	3
	LDC	65533
	ADD
	LDB
	LDC	46
	EQ
	JF	.L23
	LDG	.filename
	LDL	3
	LDC	65534
	ADD
	LDB
	LDC	116
	EQ
	JF	.L23
	LDG	.filename
	LDL	3
	LDC	65535
	ADD
	LDB
	LDC	55
	EQ
	JF	.L23
	LDC	.L11
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
	JF	.L24
	LDP	2
	LDL	1
	LDW
	ARG
	CALLP	1,_perror
	LDC	65535
	MREG
	JMP	.L18
.L24
	JMP	.L25
.L23
	LDP	2
	LDC	0
	LDW
	ARG
	CALLP	1,.usage
.L25
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
	LDC	.L12
	ARG
	CALLF	2,_printf
	POP
	LDC	.L13
	ARG
	LDG	.filename
	ARG
	CALLF	2,_fopen
	STG	_listfp
	POP
	LDG	_listfp
	LDC	0
	EQ
	JF	.L26
	LDG	.filename
	ARG
	CALLP	1,_perror
	LDC	65535
	MREG
	JMP	.L18
.L26
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
	LDC	.L14
	ARG
	LDG	.filename
	ARG
	CALLF	2,_fopen
	STG	_hexfp
	POP
	LDG	_hexfp
	LDC	0
	EQ
	JF	.L27
	LDG	.filename
	ARG
	CALLP	1,_perror
	LDC	65535
	MREG
	JMP	.L18
.L27
.L22
	LDP	1
	LDC	2
	GT
	JF	.L28
	LDC	.L15
	ARG
	CALLP	1,_error
	LDC	65535
	MREG
	JMP	.L18
.L28
	CALLP	0,_initPass1
	LDG	_sourcefp
	ARG
	CALLP	1,_pass1
	LDG	_sourcefp
	ARG
	CALLF	1,_fclose
	POP
	LDC	.L16
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
.L18
	RET
