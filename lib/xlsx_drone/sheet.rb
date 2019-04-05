# Namespace (protector) of the library.
module XLSXDrone

  # XLSX Sheet.
  class Sheet

    # @return [XLSXDrone::Sheet]
    def initialize(xlsx_sheet_mpointer)
      @native_sheet = XLSXDrone::NativeBinding::XLSXSheetT.new(xlsx_sheet_mpointer)
      @native_cell = XLSXDrone::NativeBinding::XLSXCellT.new(FFI::MemoryPointer.new(1, XLSXDrone::NativeBinding::XLSXCellT.size, true))
      @styles = {}
    end

    # @return [Integer] 0 if the sheet is empty
    def last_row
      @native_sheet[:last_row]
    end

    # @return [String]
    def name
      @native_sheet[:name].read_string
    end

    # @param row [Integer], @param column [String]
    # @return [Integer, Float, String, Time, NilClass]
    def read_cell(row, column)
      XLSXDrone::NativeBinding.xlsx_read_cell(@native_sheet, row, column, @native_cell)
      # if it has no style, then it's either a string or a number
      if(@native_cell[:style].null?)
        case @native_cell[:value_type]
          when 0
            @native_cell[:value][:pointer_to_char_value].read_string
          when 1
            @native_cell[:value][:int_value]
          when 2
            @native_cell[:value][:long_long_value]
          when 3
            @native_cell[:value][:double_value]
          else
            nil
        end
      else
        address = @native_cell[:style].address
        if(!(@styles.has_key?(address)))
          style_obj = XLSXDrone::NativeBinding::XLSXStyleT.new(@native_cell[:style])
          @styles[address] = style_obj[:related_type]
        end
        case @styles[address]
          when 2
            # XLSX_DATE
            Time.new(1900) + ((@native_cell[:value][:int_value] - 2) * 86400)
          when 4
            # XLSX_DATE_TIME, there are specific cases in which it's a DATE_TIME, but the internal representation appears as an int, so basically
            # the "time" part of the data comes fixed at mid-day or at the start of the day, that's what you actually see on Excel
            if(@native_cell[:value_type] == 1)
              Time.new(1900) + ((@native_cell[:value][:int_value] - 2) * 86400)
            else
              match = @native_cell[:value][:double_value].to_s.match(/(\d+)\.(\d+)/)
              integral_part = match[1].to_i
              floating_part = "0.#{match[2]}".to_f
              Time.new(1900) + ((integral_part - 2) * 86400) + (floating_part * 86400)
            end
          when 0
            # XLSX_NUMBER
            case @native_cell[:value_type]
              when 1
                @native_cell[:value][:int_value]
              when 2
                @native_cell[:value][:long_long_value]
              when 3
                @native_cell[:value][:double_value]
              else
                nil
            end
          when 1
            # XLSX_TEXT
            @native_cell[:value][:pointer_to_char_value].read_string
          when 3
            # XLSX_TIME
            (Time.new(1900) + (@native_cell[:value][:double_value] * 86400)).strftime("%H:%M:%S")
          else
            # XLSX_UNKNOWN
            case @native_cell[:value_type]
              when 0
                @native_cell[:value][:pointer_to_char_value].read_string
              when 1
                @native_cell[:value][:int_value]
              when 2
                @native_cell[:value][:long_long_value]
              when 3
                @native_cell[:value][:double_value]
              else
                nil
            end
        end
      end
    end
  end
end