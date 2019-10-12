require_relative 'boom.rb'
require_relative 'concern/near.rb'
class Map
    attr_accessor :row, :col, :booms, :map_list, :counts, :clicked

    def initialize(row, col)
        @row = row
        @col = col
        @booms = ::Boom.new(row, col)
        @map_list = Hash.new('.')
        @counts = row * col
        @clicked = []
    end

    def change_map(position)
        clicked << position
        map_list[position] = boom_map[position]
        clicked.concat(spread(position)).uniq! if boom_map[position].zero?
        
        map_list
    end

    def boom_map
        @boom_map = booms.boom_map
    end

    private

    def spread(position)
        spreaded = safety_point_nearby(position)
        ex = spreaded << position

        until spreaded.nil? || spreaded.empty?
            spreaded = (spreaded.flat_map { |s| safety_point_nearby(s, ex) if (map_list[s] = boom_map[s]).zero? }).compact
            ex |= spreaded
        end
        ex
    end

    def safety_point_nearby(position, ex = [])
        Near.list(row, col, position) - (booms.positions + ex)
    end
end