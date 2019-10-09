class Near

    def self.list(row, col, position)
        a = position - 1
        b = position + 1
        c = position - col - 1
        d = position - col + 1
        e = position - col
        f = position + col - 1
        g = position + col + 1
        h = position + col

        if position < col
            if position == 0
                [b, h, g]
            elsif position == col - 1
                [a, f, h]
            else
                [a, b, f, g, h]
            end

        elsif position >= col*(row - 1)
            if position = col*(row - 1)
                [e, d, b]
            elsif position = col*row - 1
                [e, c, a]
            else
                [a, c, e, d. b]
            end

        else
            if position % col == 0
                [e, d, b, g, h]
            elsif position % col == col - 1
                [e, c, a, f, h]
            else
                [a, b, c, d, e, f, g, h]
            end
        end
    end


end