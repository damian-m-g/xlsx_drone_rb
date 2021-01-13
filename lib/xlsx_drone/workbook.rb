# Namespace (protector) of the library.
module XLSXDrone

  # XLSX Workbook.
  class Workbook
    
    @@opened_workbooks = []

    # You could use this method to close all opened workbooks at the same time.
    def self.close_workbooks
      @@opened_workbooks.each do |wb|
        wb.close
      end
    end
    
    # @param xlsx_workbook_mpointer [FFI::MemoryPointer]
    # @return [Workbook]
    def initialize(xlsx_workbook_mpointer)
      @native_workbook = XLSXDrone::NativeBinding::XLSXWorkbookT.new(xlsx_workbook_mpointer)
      @@opened_workbooks << self
    end

    # Sheets aren't loaded by default. You have to load them one by one, once you need them. You can *reference* a sheet passing its name or its index (first one is 1). Raises an exception if it can't for some reason.
    # @param reference [String, Integer]
    # @return [XLSXDrone::Sheet]
    def load_sheet(reference)
      if(@native_workbook)
        loaded_sheet = \
          case reference
            when String
              XLSXDrone::NativeBinding.xlsx_load_sheet(@native_workbook, 0, reference)
            when Integer
              XLSXDrone::NativeBinding.xlsx_load_sheet(@native_workbook, reference, nil)
            else
              raise XLSXDrone::LogicError::ClientError::MalformedParams, "Pass a valid index as an #Integer (> 0 && <= #sheets_amount()), or a valid sheet name as a #String."
          end
        if(!loaded_sheet.null?)
          XLSXDrone::Sheet.new(loaded_sheet)
        else
          # no sheet was loaded
          case XLSXDrone::NativeBinding.xlsx_get_xlsx_errno()
            when -11
              raise XLSXDrone::LogicError::ClientError::MalformedParams, "Pass a valid index (> 0 && <= #sheets_amount()), or a valid sheet name."
            when -12
              raise NoMemoryError
            when -13
              raise XLSXDrone::UserError::IndexOutOfBounds, "If you pass an integer as parameter, note that can't surpass #sheets_amount()."
            when -14
              raise XLSXDrone::LogicError::InternalError::XMLParsingError, "The XLSX may be corrupted or it belongs to a version unsupported by this library."
            when -15
              raise XLSXDrone::UserError::NonExistent, "There's not such sheet with that name."
          end
        end
      else
        raise XLSXDrone::UserError::WorkbookClosed, "The workbook you're trying to access was already closed."
      end
    end
    
    # @return [Integer] the amount of sheets contained on this workbook
    def sheets_amount
      @native_workbook[:n_sheets]
    end

    # Should-call method, once you finish working with the workbook.
    # @return [TrueClass, FalseClass] depending on if the close was successful or not
    def close
      if(XLSXDrone::NativeBinding.xlsx_close(@native_workbook) == 1)
        @@opened_workbooks.delete(self)
        @native_workbook = nil
        true
      else
        false
      end
    end
  end
end
