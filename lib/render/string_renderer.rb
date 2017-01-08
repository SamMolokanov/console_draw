module ConsoleDraw
  module Render

    # Class: Renders raster map as string
    class StringRenderer
      class << self
        TRANSPARENT_CHAR = ' '.freeze
        DEFAULT_VISIBLE_CHAR = 'x'.freeze

        # Public: Iterates over points on map and collect string output. Same as "Raster scan"
        #   raster_map - 2-dimensional array with points
        #
        # Returns: String representation of raster_map with a frame
        def render(raster_map)
          return '' if raster_map.empty?

          horizontal_line = '-' * (raster_map[0].count + 2)

          output = horizontal_line + "\n"

          output += raster_map.map do |row|
            "|#{row.map { |point| render_point(point) }.join}|"
          end.join("\n")

          output + "\n" + horizontal_line
        end

        private

        def render_point(point)
          point.nil? ? TRANSPARENT_CHAR : (point.color || DEFAULT_VISIBLE_CHAR)
        end
      end
    end
  end
end
