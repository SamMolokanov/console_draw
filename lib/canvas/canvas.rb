module ConsoleDraw
  module Canvas
    # Class: Canvas, draws figures.
    # Points of figures are stored in a 2-dimensional array @raster_map.
    # @raster_maps is an array of rows, every row is an array of points,
    # point.y - is a row index, point.x - index in a row
    #
    # Example:
    #   # w, h - width and height of the canvas in points
    #   canvas = ConsoleDraw::Canvas::Canvas.new(w, h)
    #
    #   # add figures to canvas
    #   canvas.draw(figure1, figure2)
    #
    class Canvas
      attr_reader :raster_map

      def initialize(width, height)
        @raster_map = Array.new(height) { |_| Array.new(width) }
      end

      # Public: take points from figures and store on canvas
      #   figures - set of figures which implement ConsoleDraw::Figures::Base interface
      # Returns: Nothing
      def draw(*figures)
        figures.flat_map(&:calculate_points!).each { |point| self << point }
      end

      protected

      # Internal: Put point into @raster_map based on its coordinates
      def <<(point)
        @raster_map[point.y][point.x] = point
      end
    end
  end
end
