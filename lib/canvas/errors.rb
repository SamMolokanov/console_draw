module ConsoleDraw
  module Canvas
    # Base class for all Canvas errors
    class CanvasError < StandardError; end

    # Raises when tries to put point outside of Canvas
    class InvalidCoordinatesError < CanvasError
      def initialize(msg = 'Coordinates are outside of canvas')
        super
      end
    end

    # Raises when tries to create Canvas with non-positive size
    class InvalidCanvasSizeError < CanvasError
      def initialize(msg = 'Width and height of canvas must be bigger than 0')
        super
      end
    end
  end
end
