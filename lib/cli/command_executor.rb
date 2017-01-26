module ConsoleDraw
  module CLI

    # Class CommandExecutor
    #   Executes a command from user's input on a context
    class CommandExecutor
      # Example: C 5 10
      CANVAS_COMMAND = /^[C]\s(?<x>\d+)\s(?<y>\d+)$/

      # Example: C
      CLEAN_CANVAS_COMMAND = /^C$/

      # Example: B 5 10 o
      FILL_COMMAND = /^[B]\s(?<x>\d+)\s(?<y>\d+)\s(?<color>[a-zA-Z])$/

      # Example: L 1 1 2 3
      LINE_COMMAND = /^[L]\s(?<x1>\d+)\s(?<y1>\d+)\s(?<x2>\d+)\s(?<y2>\d+)$/

      # Example: R 1 1 2 3
      RECTANGLE_COMMAND = /^[R]\s(?<x1>\d+)\s(?<y1>\d+)\s(?<x2>\d+)\s(?<y2>\d+)$/

      # Example: Q
      QUIT_COMMAND = /^Q$/

      # Exampl: Yes
      CONFIRM_COMMAND = /^Yes$/

      UNSUPPORTED_MESSAGE = 'Sorry, command is not recognized :('.freeze
      REQUIRE_CONFIRMATION_MESSAGE = 'Numbers you provided are quite a big. Type "Yes" if you are sure.'.freeze

      def initialize
        @context = ConsoleDraw::CLI::Context.new
      end

      # Public: Parse incoming string into a command
      # Return: String, result of a command or Exit
      def execute(string_input)
        case string_input
        when CANVAS_COMMAND
          ensure_confirmation($~[:x].to_i, $~[:y].to_i) do |args|
            @context.new_canvas *args
          end
        when FILL_COMMAND
          ensure_confirmation($~[:x].to_i, $~[:y].to_i, $~[:color]) do |args|
            @context.fill *args
          end
        when LINE_COMMAND
          ensure_confirmation($~[:x1].to_i, $~[:y1].to_i, $~[:x2].to_i, $~[:y2].to_i) do |args|
            @context.draw_line *args
          end
        when RECTANGLE_COMMAND
          ensure_confirmation($~[:x1].to_i, $~[:y1].to_i, $~[:x2].to_i, $~[:y2].to_i) do |args|
            @context.draw_rectangle *args
          end
        when CLEAN_CANVAS_COMMAND
          @context.clean_canvas
        when CONFIRM_COMMAND
          confirm_command
        when QUIT_COMMAND
          exit
        else
          UNSUPPORTED_MESSAGE
        end
      end

      private

      # Internal: Run a command, that required a confirmation
      # Returns: Result of a deferred command or Unsupported message
      def confirm_command
        if @require_confirmation
          result = @require_confirmation[1].call @require_confirmation[0]
          @require_confirmation = nil
          result
        else
          UNSUPPORTED_MESSAGE
        end
      end

      # Internal: Protect from too big arguments ( > 100)
      #   If user input has very big numbers it may cause an unexpected behaviour:
      #   memory/performance issues, too long output, etc.
      #   Keep block and arguments in @require_confirmation and ask for confirmation
      #
      # Returns: Confirmation warning or result of a block
      def ensure_confirmation(*args, &block)
        if args.any? { |arg| arg.is_a?(Integer) && arg > 100 }
          @require_confirmation = [args, block]
          REQUIRE_CONFIRMATION_MESSAGE
        else
          @require_confirmation = nil
          block.call args
        end
      end
    end
  end
end
