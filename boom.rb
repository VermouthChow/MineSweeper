require_relative 'concern/near.rb'

class Boom
    attr_accessor :positions, :counts, :row, :col, :boom_map

    def initialize(row, col)
        @row = row
        @col = col

        total = (0..row*col).to_a
        size = total.size
        @counts = ((size*0.15).to_i..(size*0.25).to_i).to_a.sample
        @positions = total.sample(counts).sort
        @boom_map ||= get_boom_map
    end

    # 生成 节点 => 雷数量
    def get_boom_map
        near_counts = Hash.new(0)
        positions.each do |boom|
            near_counts[boom] = -1
            near(boom).each { |n| near_counts[n] = near_counts[n].to_i + 1 if near_counts[n] != -1 }
        end
        near_counts
    end

    # 此雷周围位置对应的数值
    def near(boom)
        Near.list(row, col, boom)
    end
end