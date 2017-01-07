module ConsoleDraw
  module CLI

    # Class CLI
    #   Command line interface
    #   Sends user's input to a command parser
    #   Returns a result of the command execution from the context to output
    class CLI
      WELCOME_MESSAGE = 'enter command: '.freeze

      def run(input = $stdin, output = $stdout)
        output.write WELCOME_MESSAGE

        renderer = ConsoleDraw::Render::StringRenderer
        context = ConsoleDraw::CLI::Context.new(renderer)
        command_parser = ConsoleDraw::CLI::CommandParser.new

        loop do
          user_input = input.gets.chomp

          begin
            result = context.execute command_parser.parse(user_input)

            output.write result
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
