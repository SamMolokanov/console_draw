module ConsoleDraw
  module CLI

    # Class Context
    #   Provides an interface to draw on canvas and render it to a string
    class Context
      NO_CANVAS_EXISTS = 'Please create a canvas first!'.freeze

      def new_canvas(width, height)
        @canvas = ConsoleDraw::Canvas::Canvas.new(width, height)
        render
      rescue ConsoleDraw::Canvas::CanvasError => e
        e.message
      end

      def draw_line(x1, y1, x2, y2)
        render_with_validation do
          @canvas.draw ConsoleDraw::Figures::Line.new(x1, y1, x2, y2)
        end
      end

      def draw_rectangle(x1, y1, x2, y2)
        render_with_validation do
          @canvas.draw ConsoleDraw::Figures::Rectangle.new(x1, y1, x2, y2)
        end
      end

      def fill(x, y, color)
        render_with_validation do
          @canvas.fill(x, y, color)
        end
      end

      private

      def render_with_validation(&block)
        return NO_CANVAS_EXISTS if @canvas.nil?
        block.call
        render
      rescue ConsoleDraw::Canvas::CanvasError => e
        e.message
      end

      def render
        ConsoleDraw::Render::StringRenderer.render @canvas.raster_map
      end
    end
  end
end
