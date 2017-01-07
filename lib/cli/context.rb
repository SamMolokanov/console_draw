module ConsoleDraw
  module CLI

    # Class Context
    #   Provides an interface to draw on canvas and render it to a string
    class Context
      NO_CANVAS_EXISTS = 'Please create a canvas first!'.freeze

      def new_canvas(width, height)
        @canvas = ConsoleDraw::Canvas::Canvas.new(width, height)
        render
      end

      def draw_line(x1, y1, x2, y2)
        draw ConsoleDraw::Figures::Line.new(x1, y1, x2, y2)
      end

      def draw_rectangle(x1, y1, x2, y2)
        draw ConsoleDraw::Figures::Rectangle.new(x1, y1, x2, y2)
      end

      private

      def draw(figure)
        return NO_CANVAS_EXISTS if @canvas.nil?

        @canvas.draw figure
        render
      end

      def render
        ConsoleDraw::Render::StringRenderer.render @canvas.raster_map
      end
    end
  end
end
