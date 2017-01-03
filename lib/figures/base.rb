module ConsoleDraw
  module Figures

    # Base Figure class
    # Introduces common public interface for any supported Figure
    class Base

      # Abstract: Algorithm of points generation
      #   requires implementation in subclasses
      # Returns: Array of points
      def calculate_points!
        raise NotImplementedError
      end
    end
  end
end
