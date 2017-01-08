module ConsoleDraw
  module CLI

    # Class CommandExecutor
    #   Executes a command from user's input on a context
    class CommandExecutor
      # Example: C 5 10
      CANVAS_COMMAND = /^[C]\s(?<x>\d+)\s(?<y>\d+)$/

      # Example: B 5 10 o
      FILL_COMMAND = /^[B]\s(?<x>\d+)\s(?<y>\d+)\s(?<color>[a-zA-Z])$/

      # Example: L 1 1 2 3
      LINE_COMMAND = /^[L]\s(?<x1>\d+)\s(?<y1>\d+)\s(?<x2>\d+)\s(?<y2>\d+)$/

      # Example: R 1 1 2 3
      RECTANGLE_COMMAND = /^[R]\s(?<x1>\d+)\s(?<y1>\d+)\s(?<x2>\d+)\s(?<y2>\d+)$/

      # Example: Q
      QUIT_COMMAND = /^Q$/

      UNSUPPORTED_MESSAGE = 'Sorry, command is not recognized :('.freeze

      def initialize
        @context = ConsoleDraw::CLI::Context.new
      end

      # Public: Parse incoming string into a command
      # Return: String, result of a command or Exit
      def execute(string_input)
        case string_input
        when CANVAS_COMMAND
          @context.new_canvas($~[:x].to_i, $~[:y].to_i)
        when FILL_COMMAND
          @context.fill($~[:x].to_i, $~[:y].to_i, $~[:color])
        when LINE_COMMAND
          @context.draw_line($~[:x1].to_i, $~[:y1].to_i, $~[:x2].to_i, $~[:y2].to_i)
        when RECTANGLE_COMMAND
          @context.draw_rectangle($~[:x1].to_i, $~[:y1].to_i, $~[:x2].to_i, $~[:y2].to_i)
        when QUIT_COMMAND
          exit
        else
          UNSUPPORTED_MESSAGE
        end
      end
    end
  end
end
