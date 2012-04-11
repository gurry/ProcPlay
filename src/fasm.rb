require 'ffi'

module Fasm
	extend FFI::Library
	
	if FFI::Platform.unix?
		ffi_lib "../lib/libfasm.so"
	elsif FFI::Platform.windows?
		ffi_lib "../lib/fasm.dll"
	else
		raise RuntimeError "Platform not supported. Only windows or unix platforms are supported."
	end

	# General errors and conditions
	FASM_OK 			 = 0	# FasmState returned by fasm_Assemble() contains valid output
	FASM_WORKING			 = 1
	FASM_ERROR			 = 2	# FasmState returned by fasm_Assemble() contains error code
	FASM_INVALID_PARAMETER		 = -1
	FASM_OUT_OF_MEMORY		 = -2
	FASM_STACK_OVERFLOW		 = -3
	FASM_SOURCE_NOT_FOUND		 = -4
	FASM_UNEXPECTED_END_OF_SOURCE	 = -5
	FASM_CANNOT_GENERATE_CODE	 = -6
	FASM_FORMAT_LIMITATIONS_EXCEDDED = -7
	FASM_WRITE_FAILED		 = -8

	# Error codes for FASM_ERROR condition
	FASMERR_FILE_NOT_FOUND		     		= -101
	FASMERR_ERROR_READING_FILE	     		= -102
	FASMERR_INVALID_FILE_FORMAT	     		= -103
	FASMERR_INVALID_MACRO_ARGUMENTS    		= -104
	FASMERR_INCOMPLETE_MACRO	     		= -105
	FASMERR_UNEXPECTED_CHARACTERS	    	= -106
	FASMERR_INVALID_ARGUMENT	     		= -107
	FASMERR_ILLEGAL_INSTRUCTION	     		= -108
	FASMERR_INVALID_OPERAND 	     		= -109
	FASMERR_INVALID_OPERAND_SIZE	    	= -110
	FASMERR_OPERAND_SIZE_NOT_SPECIFIED  	= -111
	FASMERR_OPERAND_SIZES_DO_NOT_MATCH  	= -112
	FASMERR_INVALID_ADDRESS_SIZE	    	= -113
	FASMERR_ADDRESS_SIZES_DO_NOT_AGREE  	= -114
	FASMERR_PREFIX_CONFLICT 	     		= -115
	FASMERR_LONG_IMMEDIATE_NOT_ENCODABLE 	= -116
	FASMERR_RELATIVE_JUMP_OUT_OF_RANGE   	= -117
	FASMERR_INVALID_EXPRESSION	     		= -118
	FASMERR_INVALID_ADDRESS 	     		= -119
	FASMERR_INVALID_VALUE		     		= -120
	FASMERR_VALUE_OUT_OF_RANGE	     		= -121
	FASMERR_UNDEFINED_SYMBOL	     		= -122
	FASMERR_INVALID_USE_OF_SYMBOL	     	= -123
	FASMERR_NAME_TOO_LONG		    		= -124
	FASMERR_INVALID_NAME		     		= -125
	FASMERR_RESERVED_WORD_USED_AS_SYMBOL 	= -126
	FASMERR_SYMBOL_ALREADY_DEFINED	     	= -127
	FASMERR_MISSING_END_QUOTE	     		= -128
	FASMERR_MISSING_END_DIRECTIVE	     	= -129
	FASMERR_UNEXPECTED_INSTRUCTION	     	= -130
	FASMERR_EXTRA_CHARACTERS_ON_LINE     	= -131
	FASMERR_SECTION_NOT_ALIGNED_ENOUGH   	= -132
	FASMERR_SETTING_ALREADY_SPECIFIED    	= -133
	FASMERR_DATA_ALREADY_DEFINED	     	= -134
	FASMERR_TOO_MANY_REPEATS	     		= -135
	FASMERR_SYMBOL_OUT_OF_SCOPE	     		= -136
	FASMERR_USER_ERROR		     = -140
	FASMERR_ASSERTION_FAILED	     = -141

	class FasmState < FFI::Struct
		layout(
			:condtion, :int,
			:output_length, :int,
        	:output_data, :string
        )
	end

	# function signature in fasm library: fasm_Assemble(lpSource,lpMemory,cbMemorySize,nPassesLimit,hDisplayPipe)
	attach_function :fasm_Assemble, [ :string, :pointer, :int, :pointer ], :int
end
