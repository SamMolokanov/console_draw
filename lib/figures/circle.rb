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

      # Public: Calculates coordinates of the Circle
      # Returns: Array of coordinates [x, y]
      def calculate_coordinates
        bresenham_circle_coordinates
      end

      private

      # Public: Calculates coordinates for Circle
      #   Implements variation on Bresenham' algorythm for circle
      #   https://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm
      # Returns: Array coordinates
      def bresenham_circle_coordinates
        coordinates = []

        populate_symmetric = -> (x, y) {
          coordinates << [x, y]
          coordinates << [x, -y]
          coordinates << [-x, -y]
          coordinates << [-x, y]
          coordinates << [y, x]
          coordinates << [y, -x]
          coordinates << [-y, -x]
          coordinates << [-y, x]
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
        coordinates.uniq.map { |x, y| [x + @x, y + @y] }
      end
    end
  end
end
