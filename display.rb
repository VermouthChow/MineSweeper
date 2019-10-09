require_relative 'map.rb'

class Display

    attr_accessor :map, :row, :col

    def initialize(row = 10, col = 10)
        @row = row
        @col = col
        @map = ::Map.new(row, col)
    end

    def print_map(list = map.map_list, position = nil)
        chs = (0...col).map { |c| ('A'.bytes.first + c).chr }
        separator = '    '+'-'*col*5

        puts "\n"
        printf '        %s', "#{chs.join('    ')}\n"
        puts separator
        (0...row).each do |r|
            printf("%4s", "#{r}|") 
            (r*col...(r+1)*col).each do |c|
                text =  if list[c] == -1
                            c == position ? "    #{colorize('X', 41)}" : "    #{colorize('X', 33)}"
                        else
                            "    #{colorize(list[c], 32)}"
                        end
                                
                printf("%s", text)
            end
            puts
            puts separator
        end
        puts "\n"
    end

    def colorize(text, color_code) 
        "\e[#{color_code}m#{text}\e[0m" 
    end 

    def booms_num
        map.booms.positions
    end

end


