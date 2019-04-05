# Namespace (protector) and #open() functionallity for the library.
module XLSXDrone

  # Opens an XLSX file, must be closed after working with him.
  # Can raise several exceptions:
  #   * NoMemoryError
  #   * XLSXDrone::InternalError::CantDeployFile: will get raised if the file doesn't exist, or other reassons.
  #   * XLSXDrone::InternalError::XMLParsingError: will get raised if the XLSX is corrupted, or if it's somehow unrecognizable by the library.
  # @param path [String]
  # @return [XLSXDrone::Workbook, NilClass]
  def self.open(path)
    # check that the *path* is always a #String
    if(!path.is_a?(String)) then return end
    # reserve memory for an xlsx_workbook struct
    xlsx_workbook_mpointer = FFI::MemoryPointer.new(1, XLSXDrone::NativeBinding::XLSXWorkbookT.size, false)
    if(XLSXDrone::NativeBinding.xlsx_open(File.absolute_path(path), xlsx_workbook_mpointer) == 1)
      # everything went ok
      XLSXDrone::Workbook.new(xlsx_workbook_mpointer)
    else
      # something went wrong
      case FFI::LastError.error
        when -2
          raise NoMemoryError
        when -3
          raise XLSXDrone::LogicError::InternalError::CantDeployFile, "Can't deploy #{path}."
        when -4
          raise XLSXDrone::LogicError::InternalError::XMLParsingError, "The XLSX may be corrupted or it belongs to a version unsupported by this library."
      end
    end
  end
end
