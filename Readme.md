# Console Draw

Console Draw is a simple console version of a drawing program.

## Getting Started

1. Install Bundler and dependencies

        $ gem install bundler
        $ bundle install

2. Run specs

        $ rspec

## Details

### Supported figures

Points are generated by figures' algorithms located in the folder `lib/figures`. Every figure must inherits from `ConsoleDraw::Figures::Base` and implements common method `#calculate_points!` that returns an array of `ConsoleDraw::Canvas::Point`.

#### Line

Line figure generates points by [algorithm of Bresenham](https://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm) for raster image. Input parameters for a line are coordinates of the first and the last points.

### Rectangle

Rectangle figure uses Line figures as edges to generate points. Input parameters for a rectangle are coordinates of an upper left and a lower right corners.

### Canvas

Canvas is a storage of points generated by figures. Multiple figures might be drawn on a single canvas object with a method `#draw`.

### Renders

Points map of canvas is rendered to string by class `ConsoleDraw::Render::StringRenderer` using "Raster scan" technique.

## CLI

Instantiates a command executor and sends user's input to the command executor. Command executor has a Context object, that provides an interface to draw on canvas and render canvas as String.
