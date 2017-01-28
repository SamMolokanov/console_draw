module ConsoleDraw
  module Render

    # Class: Renders raster map as string
    class StringRenderer
      class << self
        TRANSPARENT_CHAR = ' '.freeze
        DEFAULT_VISIBLE_CHAR = 'x'.freeze

        # Public: Renders canvas as string
        # Returns: String
        def render(canvas)
          output = horizontal_line(canvas.width) + "\n"

          canvas.each_line do |line|
            output += generate_line line
          end

          output += horizontal_line(canvas.width)
          output
        end

        def generate_line(points)
          "|#{points.map { |point| render_point(point) }.join}|\n"
        end

        def horizontal_line(length)
          '-' * (length + 2)
        end

        private

        def render_point(point)
          point.nil? ? TRANSPARENT_CHAR : (point.color || DEFAULT_VISIBLE_CHAR)
        end
      end
    end
  end
end
