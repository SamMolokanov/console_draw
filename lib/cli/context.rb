module ConsoleDraw
  module CLI

    # Class Context
    #   Executes commands on canvas and renders result
    class Context
      def initialize(renderer)
        @renderer = renderer
        @canvas = nil
      end

      # Public: Execute a command as proc, render canvas
      # Returns: String, rendering of the canvas
      def execute(command)
        @canvas = command.call @canvas
        @renderer.render @canvas.raster_map
      end
    end
  end
end
