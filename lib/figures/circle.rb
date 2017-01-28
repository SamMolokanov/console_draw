
module ConsoleDraw
  module Figures
    # Class: Circle figure
    #
    # Example:
    #   # x, y - coordinates of center
    #   # r - radius of circle
    #   circle = ConsoleDraw::Figure::Circle.new(x, y, r)
    #
    class Circle < Base

      # x, y - coordinates of the center
      # r - radius
      def initialize(x, y, r)
        @x, @y, @r = x, y, r
      end

      # Public: Calculates points of the Circle
      # Returns: Array of ConsoleDraw::Canvas::Point
      def calculate_points
        bresenham_circle_points.uniq.map { |x, y| ConsoleDraw::Canvas::Point.new x, y }
      end

      private

      # Public: Calculates points for Circle
      #   Implements variation on Bresenham' algorythm for circle
      #   https://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm
      # Returns: Array of Points
      def bresenham_circle_points
        points = []

        populate_symmetric = -> (x, y) {
          points << [x, y]
          points << [x, -y]
          points << [-x, -y]
          points << [-x, y]
          points << [y, x]
          points << [y, -x]
          points << [-y, -x]
          points << [-y, x]
        }

        # start from the upper point of the circle
        x = 0
        y = @r

        delta = 3 - 2 * y

        while x <= y do
          populate_symmetric[x, y]

          if delta < 0
            delta += 4 * x + 6
          else
            delta += 4 * (x - y) + 10
            y -= 1
          end

          x += 1
        end

        # move circle to proper center position
        points.map { |x, y| [x + @x, y + @y] }
      end
    end
  end
end
