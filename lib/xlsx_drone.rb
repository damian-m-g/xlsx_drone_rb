# external libraries
require 'ffi'

# source code
require_relative 'xlsx_drone/exceptions'
require_relative 'xlsx_drone/native_binding'
require_relative 'xlsx_drone/xlsx_drone'
require_relative 'xlsx_drone/workbook'
require_relative 'xlsx_drone/sheet'

# turn off err printing from the native library
XLSXDrone::NativeBinding.xlsx_set_print_err_messages(0)
