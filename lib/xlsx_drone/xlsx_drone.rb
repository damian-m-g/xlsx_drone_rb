# Namespace (protector) and #open() functionallity for the library.
module XLSXDrone
  
  # @param path [String]
  # @return [XLSXDrone::Workbook]
  # Opens an XLSX file, should be closed after working with him. Can raise several exceptions.
  def self.open(path)
    # check that the *path* is always a #String
    raise XLSXDrone::LogicError::ClientError::MalformedParams, "A #String is expected." if(!path.is_a?(String))
    # reserve memory for an xlsx_workbook struct
    xlsx_workbook_mpointer = FFI::MemoryPointer.new(1, XLSXDrone::NativeBinding::XLSXWorkbookT.size, false)
    if(XLSXDrone::NativeBinding.xlsx_open(File.absolute_path(path), xlsx_workbook_mpointer) == 1)
      # everything went ok
      XLSXDrone::Workbook.new(xlsx_workbook_mpointer)
    else
      # something went wrong
      case XLSXDrone::NativeBinding.xlsx_get_xlsx_errno()
        when -2
          raise NoMemoryError
        when -3
          raise XLSXDrone::LogicError::InternalError::CantDeployFile, "Can't deploy #{path}. Check that the file isn't already opened.unl"
        when -4
          raise XLSXDrone::LogicError::InternalError::XMLParsingError, "The XLSX may be corrupted or it belongs to a version unsupported by this library."
      end
    end
  end
end
