# Namespace (protector) of the library.
module XLSXDrone
  
  # All things related to the binding with the native C library.
  module NativeBinding
    
    PLATFORM_X64 = RUBY_PLATFORM.match(/64/) ? true : false
    EXT_PATH = "#{File.dirname(File.dirname(File.dirname(__FILE__)))}/ext"
    DLL_PATH = PLATFORM_X64 ? "#{EXT_PATH}/xlsx_drone_x64.dll" : "#{EXT_PATH}/xlsx_drone_x86.dll"
    
    class XLSXWorkbookT < FFI::Struct
      
      layout \
        :deployment_path, :pointer,
        :shared_strings_xml, :pointer,
        :n_styles, :int,
        :styles, :pointer,
        :n_sheets, :int,
        :sheets, :pointer
    end
    
    class XLSXStyleT < FFI::Struct
      
      layout \
        :style_id, :int,
        :related_category, :int,
        :format_code, :pointer
    end
    
    class XLSXReferenceToRowT < FFI::Struct
      
      layout \
        :row_n, :int,
        :sheetdata_child_i, :int
    end
    
    class XLSXSheetT < FFI::Struct
      
      layout \
        :xlsx, :pointer,
        :name, :pointer,
        :sheet_xml, :pointer,
        :sheetdata, :pointer,
        :last_row, :int,
        :last_column, :pointer,
        :last_row_looked, XLSXReferenceToRowT
    end
    
    class XLSXCellValue < FFI::Union
      
      layout \
        :pointer_to_char_value, :pointer,
        :int_value, :int,
        :long_long_value, :long_long,
        :double_value, :double
    end
    
    class XLSXCellT < FFI::Struct
      
      layout \
        :style, :pointer,
        :value_type, :int,
        :value, XLSXCellValue
    end
    
    extend FFI::Library
    ffi_lib DLL_PATH
    
    # function attachings
    attach_function :xlsx_get_xlsx_errno, [], :int
    attach_function :xlsx_set_print_err_messages, [:int], :void
    attach_function :xlsx_open, [:string, :pointer], :int
    attach_function :xlsx_load_sheet, [:pointer, :int, :string], :pointer
    attach_function :xlsx_get_last_column, [:pointer], :pointer
    attach_function :xlsx_read_cell, [:pointer, :uint, :string, :pointer], :void
    attach_function :xlsx_close, [:pointer], :int
  end
end