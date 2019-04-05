# Namespace (protector) of the library.
module XLSXDrone

  # XLSX Workbook.
  class Workbook

    # @param xlsx_workbook_mpointer [FFI::MemoryPointer]
    # @return [Workbook]
    def initialize(xlsx_workbook_mpointer)
      @native_workbook = XLSXDrone::NativeBinding::XLSXWorkbookT.new(xlsx_workbook_mpointer)
    end

    # Sheets aren't loaded by default. You have to load them one by one, once you need them. You can *reference* a sheet passing its name or its index (first one is 1). Returns nil if didn't match.
    # @param reference [String, Integer]
    # @return [XLSXDrone::Sheet, NilClass]
    def load_sheet(reference)
      loaded_sheet = \
        case reference
          when String
            XLSXDrone::NativeBinding.xlsx_load_sheet(@native_workbook, 0, reference)
          when Integer
            XLSXDrone::NativeBinding.xlsx_load_sheet(@native_workbook, reference, nil)
          else
            return nil
        end
      if(!loaded_sheet.null?)
        XLSXDrone::Sheet.new(loaded_sheet)
      else
        # no sheet was loaded
        case FFI::LastError.error
          when -1
            raise XLSXDrone::LogicError::ClientError::MalformedParams, "Pass a valid index (> 0 && <= #sheets_amount()), or a valid sheet name."
          when -2
            raise NoMemoryError
          when -3
            raise XLSXDrone::UserError::IndexOutOfBounds, "If you pass an integer as parameter, note that can't surpass #sheets_amount()."
          when -4
            raise XLSXDrone::LogicError::InternalError::XMLParsingError, "The XLSX may be corrupted or it belongs to a version unsupported by this library."
          when -5
            raise XLSXDrone::UserError::NonExistent, "There's not such sheet with that name."
        end
      end
    end

    # @return [Integer] the amount of sheets contained on this workbook
    def sheets_amount
      @native_workbook[:n_sheets]
    end

    # Must-call method, once you finished working with the workbook.
    # @return [TrueClass, FalseClass] depending on if the close was successful or not
    def close
      XLSXDrone::NativeBinding.xlsx_close(@native_workbook) == 1 ? true : false
    end
  end
end
