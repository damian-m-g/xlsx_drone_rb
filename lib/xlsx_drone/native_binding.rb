# Namespace (protector) of the library.
module XLSXDrone

  # All things related to the binding with the native C library.
  module NativeBinding

    PLATFORM_X64 = RUBY_PLATFORM.match(/64/) ? true : false
    EXT_PATH = "#{File.dirname(File.dirname(File.dirname(__FILE__)))}/ext"
    DLL_PATH = PLATFORM_X64 ? "#{EXT_PATH}/libporcupine_x64.dll" : "#{EXT_PATH}/libporcupine_x32.dll"

    class XLSXWorkbookT < FFI::Struct

      byte_index = 0

      layout \
        :deployment_path, :pointer, byte_index,
        :shared_strings_xml, :pointer, byte_index += FFI.type_size(FFI::Type::POINTER),
        :n_styles, :int, byte_index += FFI.type_size(FFI::Type::POINTER),
        :styles, :pointer, byte_index += FFI.type_size(FFI::Type::INT),
        :n_sheets, :int, byte_index += FFI.type_size(FFI::Type::POINTER),
        :sheets, :pointer, byte_index += FFI.type_size(FFI::Type::INT)
    end

    class XLSXStyleT < FFI::Struct

      byte_index = 0

      layout \
        :style_id, :int, byte_index,
        :related_type, :int, byte_index += FFI.type_size(FFI::Type::INT),
        :format_code, :pointer, byte_index += FFI.type_size(FFI::Type::INT)
    end

    class XLSXReferenceToRowT < FFI::Struct

      byte_index = 0

      layout \
        :row_n, :int, byte_index,
        :sheetdata_child_i, :int, byte_index += FFI.type_size(FFI::Type::INT)
    end

    class XLSXSheetT < FFI::Struct

      byte_index = 0

      layout \
        :xlsx, :pointer, byte_index,
        :name, :pointer, byte_index += FFI.type_size(FFI::Type::POINTER),
        :sheet_xml, :pointer, byte_index += FFI.type_size(FFI::Type::POINTER),
        :sheetdata, :pointer, byte_index += FFI.type_size(FFI::Type::POINTER),
        :last_row, :int, byte_index += FFI.type_size(FFI::Type::POINTER),
        :last_row_looked, XLSXReferenceToRowT, byte_index += FFI.type_size(FFI::Type::INT)
    end

    class XLSXCellValue < FFI::Union
      layout \
        :pointer_to_char_value, :pointer,
        :int_value, :int,
        :long_long_value, :long_long,
        :double_value, :double
    end

    class XLSXCellT < FFI::Struct

      byte_index = 0

      layout \
        :style, :pointer, byte_index,
        :value_type, :int, byte_index += FFI.type_size(FFI::Type::POINTER),
        :value, XLSXCellValue, byte_index += FFI.type_size(FFI::Type::INT)
    end

    extend FFI::Library
    ffi_lib DLL_PATH

    # function attachings
    attach_function :xlsx_set_print_err_messages, [:int], :void
    attach_function :xlsx_open, [:string, :pointer], :int
    attach_function :xlsx_load_sheet, [:pointer, :int, :string], :pointer
    attach_function :xlsx_read_cell, [:pointer, :uint, :string, :pointer], :void
    attach_function :xlsx_close, [:pointer], :int
  end
end