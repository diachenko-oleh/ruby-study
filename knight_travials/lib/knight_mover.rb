class Knight_mover

    def initialize start_coordinates
        @position = start_coordinates
    end

    def valid_move? coordinates
        case coordinates
        in [0..7, 0..7]
            return true
        else
            return false
        end    
    end

    def knight_moves(start, target)
        return display_path([start]) if start == target

        queue = []
        visited = {}

        queue << [start]
        visited[start] = true

        until queue.empty?
            path = queue.shift
            current_position = path.last

            possible_moves(current_position).each do |move|
            next if visited.key?(move)

            new_path = path + [move]
            if move == target
                return display_path(new_path)
            end

            queue << new_path
            visited[move] = true
            end
        end

        nil
    end

    def possible_moves (coordinates = @position)
        vector = [2,1]
        results = []
    
        new_moves = [
        [vector[0], vector[1]],
        [vector[0], -vector[1]],
        [-vector[0], vector[1]],
        [-vector[0], -vector[1]],
        [vector[1], vector[0]],
        [vector[1], -vector[0]],
        [-vector[1], vector[0]],
        [-vector[1], -vector[0]]
        ]

        new_moves.each do |perm|
        results << [coordinates[0] + perm[0], coordinates[1] + perm[1]]
        end
    
        self.filter_moves results

        
    end

    def filter_moves array
        array.filter {|coordinates| self.valid_move? coordinates}
    end

    def display_path(path)
        move_str = path.size == 1 ? "move" : "moves"
        puts "You made it in #{path.size} #{move_str}! Here's your path:\n"
        path.each { |move| puts "#{move}\n" }
        
        path
    end

end