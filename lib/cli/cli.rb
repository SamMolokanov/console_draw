module ConsoleDraw
  module CLI

    # Class CLI
    #   Command line interface
    #   Accepts user's input and send to a command executor
    #   Returns a result of the command execution to output
    class CLI
      WELCOME_MESSAGE = 'enter command: '.freeze

      def run(input = $stdin, output = $stdout)
        command_executor = ConsoleDraw::CLI::CommandExecutor.new

        output.write WELCOME_MESSAGE

        loop do
          user_input = input.gets.chomp

          begin
            output.write command_executor.execute(user_input)
            output.write "\n"
            output.write WELCOME_MESSAGE
          rescue StandardError => e
            output.write e.message
            break
          end
        end
      end
    end
  end
end
