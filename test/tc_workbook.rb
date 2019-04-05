class TCWorkbook < Test::Unit::TestCase

  XLSX_PATH = "#{File.dirname(__FILE__)}/helper/foo.xlsx"

  def setup
    @workbook = XLSXDrone.open(XLSX_PATH)
  end

  def test_load_sheet
    assert_nil(@workbook.load_sheet(2.5), "Should do nothing if you don't pass a #String or an #Integer.")
    assert_nil(@workbook.load_sheet(nil), "Should do nothing if you don't pass a #String or an #Integer.")
    # you can load a sheet by its index, that starts with 1, or by its name
    assert_instance_of(XLSXDrone::Sheet, @workbook.load_sheet(1))
    assert_instance_of(XLSXDrone::Sheet, @workbook.load_sheet("Sheet1"))
    # testing raises
    assert_raise(XLSXDrone::LogicError::ClientError::MalformedParams) do
      @workbook.load_sheet(0)
    end
    assert_raise(XLSXDrone::UserError::IndexOutOfBounds) do
      @workbook.load_sheet(12)
    end
    assert_raise(XLSXDrone::UserError::NonExistent) do
      @workbook.load_sheet("non existent sheet")
    end
  end

  def test_sheets_amount
    assert_equal(3, @workbook.sheets_amount)
  end

  def teardown
    if(@workbook)
      @workbook.close()
    end
  end
end