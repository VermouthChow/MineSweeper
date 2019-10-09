require_relative 'boom.rb'
require_relative 'concern/near.rb'
class Map
    attr_accessor :row, :col, :booms, :map_list

    def initialize(row, col)
        @row = row
        @col = col
        @booms = ::Boom.new(row, col)
        @map_list = Hash.new('.')
    end

    def change_map(position)
        map_list[position] = boom_map[position]

        # 如果为0，则随机翻开相邻的一个有效格
        if boom_map[position].zero?
            valid_random_near = (Near.list(row, col, position) - booms.positions).sample
            change_map(valid_random_near) if valid_random_near
        end
        map_list
    end

    def boom_map
        @boom_map = booms.boom_map
    end
end


