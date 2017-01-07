module ConsoleDraw
  module CLI

    # Class CommandParser
    #   Parses user's input and returns command
    class CommandParser
      # C 5 10
      CANVAS_COMMAND = /^[C]\s(?<x>\d+)\s(?<y>\d+)$/
      # L 1 1 2 3
      LINE_COMMAND = /^[L]\s(?<x1>\d+)\s(?<y1>\d+)\s(?<x2>\d+)\s(?<y2>\d+)$/
      # R 1 1 2 3
      RECTANGLE_COMMAND = /^[R]\s(?<x1>\d+)\s(?<y1>\d+)\s(?<x2>\d+)\s(?<y2>\d+)$/
      # Q
      QUIT_COMMAND = /^Q$/

      # Public: Parse incoming string into a command
      # Return: Proc for execution
      def parse(str)
        case str
        when CANVAS_COMMAND
          proc { ConsoleDraw::Canvas::Canvas.new($~[:x].to_i, $~[:y].to_i) }
        when LINE_COMMAND
          proc do |canvas|
            canvas.draw ConsoleDraw::Figures::Line.new($~[:x1].to_i, $~[:y1].to_i, $~[:x2].to_i, $~[:y2].to_i)
          end
        when RECTANGLE_COMMAND
          proc do |canvas|
            canvas.draw ConsoleDraw::Figures::Rectangle.new($~[:x1].to_i, $~[:y1].to_i, $~[:x2].to_i, $~[:y2].to_i)
          end
        when QUIT_COMMAND
          exit
        else
          proc { puts 'TODO: error handling' }
        end
      end
    end
  end
end
