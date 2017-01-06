module ConsoleDraw
  module Figures

    # Class: Rectangle figure
    #   Uses four lines to build a rectangle
    #
    class Rectangle < Base
      # x1, y1 - coordinates of the upper left corner
      # x2, y2 - coordinates of the lower right corner
      def initialize(x1, y1, x2, y2)
        @x1, @y1, @x2, @y2 = x1, y1, x2, y2
      end

      # Public: Calculates points of the Rectangle object
      # Returns: Array of ConsoleDraw::Canvas::Point
      def calculate_points!
        [
          egde(@x1, @y1, @x2, @y1),
          egde(@x2, @y1, @x2, @y2),
          egde(@x2, @y2, @x1, @y2),
          egde(@x1, @y2, @x1, @y1),
        ].flatten.uniq
      end

      private

      # Internal: Build a single line
      # Returns: Array of ConsoleDraw::Canvas::Point
      def egde(x1, y1, x2, y2)
        ConsoleDraw::Figures::Line.new(x1, y1, x2, y2).calculate_points!
      end
    end
  end
end
