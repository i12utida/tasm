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
	STRING	"/bin/rm.exe"
.L8
	STRING	"list.lst"
.L9
	STRING	"/bin/rm.exe"
.L10
	STRING	"mcode/binary.hex"
.L11
	STRING	"引数が足りていません"
.L12
	STRING	"-h"
.L13
	STRING	"r"
.L14
	STRING	"list.lst"
.L15
	STRING	"w"
.L16
	STRING	"mcode/binary.hex"
.L17
	STRING	"w"
.L18
	STRING	"list.lst"
.L19
	STRING	"binary.hex"
.L20
	STRING	"引数が多すぎます"
.L21
	STRING	"r"
_main
	ENTRY	1
	LDC	.L8
	ARG
	LDC	.L7
	ARG
	CALLF	2,_exec
	POP
	LDC	.L10
	ARG
	LDC	.L9
	ARG
	CALLF	2,_exec
	POP
	LDC	1
	STL	1
	POP
	LDP	1
	LDL	1
	EQ
	JF	.L22
	LDC	.L11
	ARG
	CALLP	1,_error
	LDC	65524
	ARG
	CALLP	1,_exit
	LDC	65535
	MREG
	JMP	.L23
.L22
	LDP	1
	LDL	1
	GT
	JF	.L24
	LDC	.L12
	ARG
	LDP	2
	LDL	1
	LDW
	ARG
	CALLF	2,_strCmp
	LDC	0
	EQ
	JF	.L24
	LDP	2
	LDC	0
	LDW
	ARG
	CALLP	1,.usage
	LDC	0
	MREG
	JMP	.L23
.L24
	LDL	1
	LDC	1
	ADD
	LDP	1
	EQ
	JF	.L25
	LDC	.L13
	ARG
	LDP	2
	LDL	1
	LDW
	ARG
	CALLF	2,_fopen
	STG	_sourcefp
	POP
	LDC	.L15
	ARG
	LDC	.L14
	ARG
	CALLF	2,_fopen
	STG	_listfp
	POP
	LDC	.L17
	ARG
	LDC	.L16
	ARG
	CALLF	2,_fopen
	STG	_hexfp
	POP
	LDG	_sourcefp
	LDC	0
	EQ
	JF	.L26
	LDP	2
	LDL	1
	LDW
	ARG
	CALLP	1,_perror
	LDC	65535
	MREG
	JMP	.L23
.L26
	LDG	_listfp
	LDC	0
	EQ
	JF	.L27
	LDC	.L18
	ARG
	CALLP	1,_perror
	LDC	65535
	MREG
	JMP	.L23
.L27
	LDG	_hexfp
	LDC	0
	EQ
	JF	.L28
	LDC	.L19
	ARG
	CALLP	1,_perror
	LDC	65535
	MREG
	JMP	.L23
.L28
.L25
	LDP	1
	LDC	2
	GT
	JF	.L29
	LDC	.L20
	ARG
	CALLP	1,_error
	LDC	65535
	MREG
	JMP	.L23
.L29
	CALLP	0,_initPass1
	LDG	_sourcefp
	ARG
	CALLP	1,_pass1
	LDG	_sourcefp
	ARG
	CALLF	1,_fclose
	POP
	LDC	.L21
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
.L23
	RET
