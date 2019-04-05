class TCXLSXDrone < Test::Unit::TestCase

  XLSX_PATH = "#{File.dirname(__FILE__)}/helper/foo.xlsx"

  def test_open
    assert_nil(XLSXDrone.open(123), "Should do nothing if the arg isn't a #String")
    assert_raise(XLSXDrone::LogicError::InternalError::CantDeployFile) do
      XLSXDrone.open("non existent file path")
    end
    assert_instance_of(XLSXDrone::Workbook, @workbook = XLSXDrone.open(XLSX_PATH))
  end

  def teardown
    if(@workbook)
      @workbook.close()
    end
  end
end
