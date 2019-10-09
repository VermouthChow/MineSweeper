require_relative 'display.rb'

class Start

    class << self
        def go
            puts colorize('please input row(10-100):', 36)
            while r = gets
                break row = r.to_i if r.match(/^\d{2}$/) && r.to_i > 9 && r.to_i < 101

                puts colorize('Input error (valid number: 10-100), please check and retry:', 33)
            end

            puts colorize('please inputs column(10-26):', 36)
            while c = gets
                break col = c.to_i if c.match(/^\d{2}$/) && c.to_i > 9 && c.to_i < 27

                puts colorize('Input error (valid number: 10-26), please check and retry:', 33)
            end
            
            play(row, col)
            
        end

        def play(row, col)
            play = ::Display.new(row, col)
            play.print_map

            puts colorize('please input position (eg: A3/a3) you want click', 36)

            while back_up = position = gets.strip
                # 退出 
                break if position == 'exit'

                # 格式不正确
                if !(position.match?(/^[A-Za-z]{1}\d{1,2}$/))
                    puts colorize('wrong format, please retry (eg: A1/a1):', 33)
                    next
                end

                c = position[0].upcase.bytes[0] - 'A'.bytes[0]
                r = position[1..2].to_i

                # 输入超出列数
                if c > col - 1
                    puts colorize('More than the number of columns set, please retry:', 33)
                    next
                end
                # 输入超出行数
                if r > row - 1
                    puts colorize('More than the number of row set, please retry:', 33)
                    next
                end

                position = col*r + c


                if play.booms_num.include?(position) # 踩雷
                    puts "\n#{colorize('********************************* GAME OVER! *********************************', 41) }"
                    puts
                    puts colorize("BOOM!:  #{back_up}", 45)
                    play.print_map(play.map.boom_map, position) 
                    break
                else
                    play.map.change_map(position) 
                    play.print_map 
                end

                puts colorize('please input position (eg: A3/a3) you want click', 36)
            end
        end

        def colorize(text, color_code) 
            "\e[#{color_code}m#{text}\e[0m" 
        end

    end

end

Start.go