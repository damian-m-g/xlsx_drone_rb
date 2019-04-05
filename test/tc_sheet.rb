class TCSheet < Test::Unit::TestCase

  XLSX_PATH = "#{File.dirname(__FILE__)}/helper/foo.xlsx"

  def setup
    @workbook = XLSXDrone.open(XLSX_PATH)
    @sheet = @workbook.load_sheet(1)
  end

  def test_last_row
    assert_equal(23, @sheet.last_row)
  end

  def test_name
    assert_equal('Sheet1', @sheet.name)
  end

  def test_read_cell
    # headers
    assert_equal("General", @sheet.read_cell(1, "A"))
    assert_equal("Number", @sheet.read_cell(1, "B"))
    assert_equal("Currency", @sheet.read_cell(1, "C"))
    assert_equal("Accounting", @sheet.read_cell(1, "D"))
    assert_equal("Date", @sheet.read_cell(1, "E"))
    assert_equal("Time", @sheet.read_cell(1, "F"))
    assert_equal("Percentage", @sheet.read_cell(1, "G"))
    assert_equal("Fraction (1.5)", @sheet.read_cell(1, "H"))
    assert_equal("Scientific (0.001)", @sheet.read_cell(1, "I"))
    assert_equal("Text", @sheet.read_cell(1, "J"))
    assert_equal("Special", @sheet.read_cell(1, "K"))
    assert_equal("Custom", @sheet.read_cell(1, "L"))

    # column "A", General
    assert_equal("Foo", @sheet.read_cell(2, "A"))
    assert_equal(235, @sheet.read_cell(3, "A"))
    assert_equal(17.89, @sheet.read_cell(4, "A"))

    # column "B", Number
    assert_equal(1000, @sheet.read_cell(2, "B"))
    assert_equal(1000, @sheet.read_cell(3, "B"))
    assert_equal(-1000, @sheet.read_cell(4, "B"))
    assert_equal(-1000, @sheet.read_cell(5, "B"))
    assert_equal(1200.561, @sheet.read_cell(6, "B"))
    assert_equal(123456789, @sheet.read_cell(7, "B"))
    assert_equal(1234567890, @sheet.read_cell(8, "B"))
    assert_equal(2345678901, @sheet.read_cell(9, "B"))
    assert_equal(5678901234, @sheet.read_cell(10, "B"))
    assert_equal(123456789012345, @sheet.read_cell(11, "B"))
    assert_equal(1234567890123450, @sheet.read_cell(12, "B"))
    assert_equal(1.23456789012345e+18, @sheet.read_cell(13, "B"))
    assert_equal(1.23456789012345e+19, @sheet.read_cell(14, "B"))
    assert_equal(1.23456789012345e+16, @sheet.read_cell(15, "B"))
    assert_equal(1.23456789012345e+17, @sheet.read_cell(16, "B"))

    # column "C", Currency
    assert_equal(1000, @sheet.read_cell(2, "C"))
    assert_equal(-14562.74, @sheet.read_cell(3, "C"))
    assert_equal(584, @sheet.read_cell(4, "C"))

    # column "D", Accounting
    assert_equal(147, @sheet.read_cell(2, "D"))
    assert_equal(1200.874, @sheet.read_cell(3, "D"))

    # column "E", Date
    assert_equal(Time.new(2018, 12, 24), @sheet.read_cell(2, "E"))
    assert_equal(Time.new(2018, 12, 24), @sheet.read_cell(3, "E"))
    assert_equal(Time.new(2018, 12, 24), @sheet.read_cell(4, "E"))
    assert_equal(Time.new(2018, 12, 24), @sheet.read_cell(5, "E"))
    assert_equal(Time.new(2018, 12, 24), @sheet.read_cell(6, "E"))
    assert_equal(Time.new(2018, 12, 24), @sheet.read_cell(7, "E"))
    assert_equal(Time.new(2018, 12, 24), @sheet.read_cell(8, "E"))
    assert_equal(Time.new(2018, 12, 24), @sheet.read_cell(9, "E"))
    assert_equal(Time.new(2018, 12, 24), @sheet.read_cell(10, "E"))
    assert_equal(Time.new(2018, 12, 24), @sheet.read_cell(11, "E"))
    assert_equal(Time.new(2018, 12, 24), @sheet.read_cell(12, "E"))
    assert_equal(Time.new(2018, 12, 24), @sheet.read_cell(13, "E"))
    assert_equal(Time.new(2018, 12, 24), @sheet.read_cell(14, "E"))
    assert_equal(Time.new(2018, 12, 24), @sheet.read_cell(15, "E"))
    assert_equal(Time.new(2018, 12, 24), @sheet.read_cell(16, "E"))
    assert_equal(Time.new(2018, 12, 24), @sheet.read_cell(17, "E"))
    assert_equal(Time.new(2018, 12, 24), @sheet.read_cell(18, "E"))
    assert_equal(Time.new(2018, 12, 24), @sheet.read_cell(19, "E"))
    assert_equal(43458, @sheet.read_cell(20, "E"))
    assert_equal("12/24/1154", @sheet.read_cell(21, "E"))
    assert_equal(Time.new(9999, 12, 24), @sheet.read_cell(22, "E"))
    assert_equal("text", @sheet.read_cell(23, "E"))

    # column "F", Time
    assert_equal("02:30:54", @sheet.read_cell(2, "F"))
    assert_equal("02:30:54", @sheet.read_cell(3, "F"))
    assert_equal("02:30:54", @sheet.read_cell(4, "F"))
    assert_equal("02:30:54", @sheet.read_cell(5, "F"))
    assert_equal("02:30:54", @sheet.read_cell(6, "F"))
    assert_equal("02:30:54", @sheet.read_cell(7, "F"))
    assert_equal("02:30:54", @sheet.read_cell(8, "F"))
    assert_equal(Time.new(1956, 1, 3, 2, 30, 54).to_i, @sheet.read_cell(9, "F").to_i)
    assert_equal(0.1047917, @sheet.read_cell(11, "F").round(7))
    assert_equal("1/1/1889  2:30:54 AM", @sheet.read_cell(12, "F"))
    assert_equal(Time.new(1989, 1, 1, 2, 30, 54).to_i, @sheet.read_cell(13, "F").to_i)
    assert_equal("1/1/10000  2:30:54 AM", @sheet.read_cell(14, "F"))

    # column "G", Percentage
    assert_equal(0.5, @sheet.read_cell(2, "G"))
    assert_equal(0.45, @sheet.read_cell(3, "G"))
    assert_equal(1.6, @sheet.read_cell(4, "G"))

    # column "H", Fraction (1.5)
    assert_equal(1.5, @sheet.read_cell(2, "H"))
    assert_equal(1.5, @sheet.read_cell(3, "H"))
    assert_equal(1.5, @sheet.read_cell(4, "H"))
    assert_equal(1.5, @sheet.read_cell(5, "H"))
    assert_equal(1.5, @sheet.read_cell(6, "H"))
    assert_equal(1.5, @sheet.read_cell(7, "H"))
    assert_equal(1.5, @sheet.read_cell(8, "H"))
    assert_equal(1.5, @sheet.read_cell(9, "H"))
    assert_equal(1.5, @sheet.read_cell(10, "H"))
    assert_equal(1.5, @sheet.read_cell(11, "H"))
    assert_equal(nil, @sheet.read_cell(12, "H"))
    assert_equal("#VALUE!", @sheet.read_cell(13, "H"))

    # column "I", Scientific (0.001)
    assert_equal(0.001, @sheet.read_cell(2, "I"))
    assert_equal(0.001, @sheet.read_cell(3, "I"))
    assert_equal(0.001, @sheet.read_cell(4, "I"))

    # column "J", Text
    assert_equal("1875", @sheet.read_cell(2, "J"))
    assert_equal("Just text", @sheet.read_cell(3, "J"))

    # column "K", Special
    assert_equal(2000, @sheet.read_cell(2, "K"))
    assert_equal(2000, @sheet.read_cell(3, "K"))
    assert_equal(543415635644, @sheet.read_cell(4, "K"))
    assert_equal(34580585, @sheet.read_cell(5, "K"))

    # column "L", Custom
    assert_equal(12, @sheet.read_cell(2, "L"))
    assert_equal(Time.new(2012, 2, 16), @sheet.read_cell(3, "L"))
  end

  def teardown
    @workbook.close()
  end
end