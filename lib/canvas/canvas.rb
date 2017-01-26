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
      attr_reader :raster_map, :width, :height

      def initialize(width, height)
        @width, @height = width, height
        raise InvalidCanvasSizeError if width < 1 || height < 1

        initialize_raster
      end

      # Public: Cleans current canvas
      # Returns: Updated Canvas object
      def clean!
        initialize_raster
        self
      end

      # Public: take points from figures and store on canvas
      #   figure - object which implement ConsoleDraw::Figures::Base interface
      # Returns: Canvas object
      def draw(figure = nil)
        return self if figure.nil?

        figure.calculate_points.each do |point|
          raise InvalidCoordinatesError unless valid_coordinates?(point.x, point.y)
        end.each { |point| self << point }

        self
      end

      # Public: Fill the entire area connected to (x,y) of the given point with a color.
      #   Uses https://en.wikipedia.org/wiki/Flood_fill#Alternative_implementations
      #   Implemented a variant of algorithm with a Queue
      #
      #  Modifications:
      #    1. According to task it fills with a color only empty areas.
      #
      #    2. Since a default point does not have a color, on enqueue step
      #      it checks for an existence of neighbour point instead of its color.
      #      No need to check for a color on enqueued coordinates
      #      because coordinates with a colored point are never enqueued
      #
      #    3. Checking if coordinates are not enqueued already slightly improves performance.
      #
      # Returns: Canvas object
      def fill(x, y, color)
        # If given color is nil, return.
        return if color == nil

        # If the point is set, return.
        return unless @raster_map[y][x].nil?

        # Set the empty queue as Array. Add initial coordinates to the queue.
        queue = [[x, y]]

        # While queue is not empty
        while queue.count != 0
          # Remove first element from queue.
          enc_x, enc_y = queue.shift

          # Set a point with the color and dequeued coordinates on @raster_map
          self << Point.new(enc_x, enc_y, color)

          enqueue = proc do |new_x, new_y|
            if valid_coordinates?(new_x, new_y) && @raster_map[new_y][new_x].nil?
              queue.push [new_x, new_y] unless queue.include?([new_x, new_y])
            end
          end

          # Add west point to the queue.
          enqueue[enc_x - 1, enc_y]

          # Add east point to the queue.
          enqueue[enc_x + 1, enc_y]

          # Add north point to the queue.
          enqueue[enc_x, enc_y - 1]

          # Add south point to the queue.
          enqueue[enc_x, enc_y + 1]
        end

        self
      end

      protected

      # Internal: Put point into @raster_map based on its coordinates
      def <<(point)
        @raster_map[point.y][point.x] = point
      end

      private

      # Internal: Validates coordinates values. Should be fine with @raster_map size.
      # Returns: Boolean
      def valid_coordinates?(x, y)
        x >= 0 && y >= 0 && y < height && x < width
      end

      # Internal: build raster map as a 2-dimensional array
      # Returns: Raster map
      def initialize_raster
        @raster_map = Array.new(height) { |_| Array.new(width) }
      end
    end
  end
end
