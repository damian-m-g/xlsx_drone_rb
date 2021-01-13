=begin
The idea of this file is to be able to benchmark the reading speed among the most used xlsx reading libraries.
As xlsx_drone is focused on speed, we expect to get #1 place.
Testing is performed between:
  * roo
  * creek
  * rubyXL
  * simple_xlsx_reader
  * xlsx_drone
=end

require 'benchmark'

Benchmark.bm(20) do |bm|
  
  TEST_SUBJECT = 'test/benchmark/xlsx_200000_rows.xlsx'.freeze
  COLUMNS = ['A', 'B', 'C']
  ROWS = 1..200_000
  
  # roo
  puts 'Measuring roo...'
  bm.report('roo') do
    require 'roo'
    xlsx = Roo::Excelx.new(TEST_SUBJECT)
    cell_value = nil
    ROWS.each do |r|
      COLUMNS.each do |c|
        cell_value = xlsx.cell(r, c)
      end
    end
  end
  
  # clean
  GC.start

  # creek
  puts 'Measuring creek...'
  bm.report('creek') do
    require 'creek'
    creek = Creek::Book.new(TEST_SUBJECT)
    sheet = creek.sheets[0]
    cell_value = nil
    sheet.rows.each do |r|
      r.values.each do |v|
        cell_value = v
      end
    end
  end

  # clean
  GC.start
  
  # rubyXL
  puts 'Measuring rubyXL...'
  bm.report('rubyXL') do
    require 'rubyXL'
    workbook = RubyXL::Parser.parse(TEST_SUBJECT)
    worksheet = workbook[0]
    cell_value = nil
    worksheet.each do |r|
      r.cells.each do |cell|
        cell_value = cell.value
      end
    end
  end

  # clean
  GC.start
  
  # simple_xlsx_reader
  # ATTENTION: Doesn't have the ability to differentiate between number and string
  puts 'Measuring simple_xlsx_reader...'
  bm.report('simple_xlsx_reader') do
    require 'simple_xlsx_reader'
    doc = SimpleXlsxReader.open(TEST_SUBJECT)
    sheet = doc.sheets[0]
    cell_value = nil
    sheet.rows.each do |r|
      r.each do |cell|
        cell_value = cell
      end
    end
  end

  # clean
  GC.start

  # xlsx_drone
  puts 'Measuring xlsx_drone...'
  bm.report('xlsx_drone') do
    require_relative '../../lib/xlsx_drone'
    wb = XLSXDrone.open(TEST_SUBJECT)
    sheet = wb.load_sheet(1)
    cell_value = nil
    ROWS.each do |r|
      COLUMNS.each do |c|
        cell_value = sheet.read_cell(r, c)
      end
    end
  end
end
