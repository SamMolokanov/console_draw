module ConsoleDraw
  module Render

    # Class: Renders points map as string
    class StringRenderer
      class << self
        TRANSPARENT_CHAR = ' '.freeze
        DEFAULT_VISIBLE_CHAR = 'x'.freeze

        # Public: Iterates over points on map and collect string output. Same as "Raster scan"
        #   points_map - 2-dimensional array with points
        #
        # Example:
        #   ConsoleDraw::Render::StringRenderer.render([[true, nil], [nil, true]])
        #   # => "x \n x"
        #
        # Returns: String representation of points_map
        def render(points_map)
          points_map.map do |row|
            row.map { |point| render_point(point) }.join
          end.join("\n")
        end

        private

        def render_point(point)
          point.nil? ? TRANSPARENT_CHAR : (point.color || DEFAULT_VISIBLE_CHAR)
        end
      end
    end
  end
end
