module ConsoleDraw
  module Figures

    # Class: Line figure
    #   Uses algorithm of Bresenham to build a line on a raster
    #
    class Line < Base

      # x1, y1 - coordinates of the first point
      # x2, y2 - coordinates of the last point
      def initialize(x1, y1, x2, y2)
        @x1, @y1, @x2, @y2 = x1, y1, x2, y2
      end

      # Public: Calculates points of the Line object
      # Returns: Array of ConsoleDraw::Canvas::Point
      def calculate_points
        bresenham(@x1, @y1, @x2, @y2).map { |x, y| ConsoleDraw::Canvas::Point.new x, y }
      end

      private

      # Internal: A straight line between two given points.
      #   algorithm of Bresenham implementation https://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm
      #   Thanks to http://www.codecodex.com/wiki/Bresenham's_line_algorithm#Ruby
      #   (x1, y1) -> (x2, y2)
      def bresenham(x1, y1, x2, y2)
        dx, dy = x2 - x1, y2 - y1
        sx, sy = dx <=> 0, dy <=> 0 # sign flag (-1,0 or 1)
        ax, ay = dx.abs, dy.abs

        if ax >= ay
          bresenham_from_00(ax, ay).map! { |x, y| [x1 + x * sx, y1 + y * sy] }
        else
          bresenham_from_00(ay, ax).map! { |y, x| [x1 + x * sx, y1 + y * sy] }
        end
      end

      # The line from the origin(0,0)
      # (0, 0) -> (dx, dy)  0 <= dy <= dx (The angle range from 0 to 45 degrees)
      def bresenham_from_00(dx, dy)
        dy = dy * 2
        y = 1
        err = 0
        pos = []

        for x in 0..dx
          pos << [x, y / 2]
          err += dy
          while err > dx
            y += 1
            err -= dx
          end
        end

        pos
      end
    end
  end
end
