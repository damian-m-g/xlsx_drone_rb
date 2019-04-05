# PORCUPINE_RUBY

## Usage

```ruby
require 'xlsx_drone'

path_to_xlsx = 'foo.xlsx'
wb = XLSXDrone.open(path_to_xlsx) #: XLSXDrone::Workbook

sheets_amount = wb.sheets_amount #: Integer
# you can pass its index (starts with 1) or its name as argument
ws = wb.load_sheet(1) #: XLSXDrone::Sheet

1.upto(ws.last_row) do |row|
  p ws.read_cell(row, 'A')
  p ws.read_cell(row, 'B')
end

# remember to close the wb once done
wb.close()
```

## Known problems

So far, it doesn't work on Ruby x64 versions.
