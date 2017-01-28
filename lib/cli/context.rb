module ConsoleDraw
  module CLI

    # Class Context
    #   Provides an interface to draw on canvas and render it to a string
    #   User's coordinate starts from 1, not from 0. That is reason to decrease all inputed coordinates by 1
    class Context
      NO_CANVAS_EXISTS = 'Please create a canvas first!'.freeze

      def new_canvas(width, height)
        @canvas = ConsoleDraw::Canvas::Canvas.new(width, height)
        render
      rescue ConsoleDraw::Canvas::CanvasError => e
        e.message
      end

      def clean_canvas
        render_with_validation { @canvas.clean! }
      end

      def draw_line(x1, y1, x2, y2)
        render_with_validation do
          @canvas.draw ConsoleDraw::Figures::Line.new(x1 - 1, y1 - 1, x2 - 1, y2 - 1)
        end
      end

      def draw_rectangle(x1, y1, x2, y2)
        render_with_validation do
          @canvas.draw ConsoleDraw::Figures::Rectangle.new(x1 - 1, y1 - 1, x2 - 1, y2 - 1)
        end
      end

      def draw_circle(x, y, r)
        render_with_validation do
          @canvas.draw ConsoleDraw::Figures::Circle.new(x - 1, y - 1, r)
        end
      end

      def fill(x, y, color)
        render_with_validation do
          @canvas.fill(x - 1, y - 1, color)
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
        ConsoleDraw::Render::StringRenderer.render @canvas
      end
    end
  end
end
