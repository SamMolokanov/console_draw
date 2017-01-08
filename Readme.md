# Console Draw

Console Draw is a simple console version of a drawing program.

## Getting Started

1. Install Bundler and dependencies

        $ gem install bundler
        $ bundle install

2. Run specs

        $ rspec

## Using

1. Run application with

        ./bin/console_draw

2. Create a canvas

        C 10 10

3. Draw a rectangle with

        R 2 2 9 9

4. Draw lines with

        L 9 9 2 2
        L 2 9 9 2

5. Fill areas

        B 5 3 i
        B 5 8 i
        B 3 5 o
        B 8 5 o

6. Quit the application with

        Q

The last result is

    ------------
    |          |
    | xxxxxxxx |
    | xxiiiixx |
    | xoxiixox |
    | xooxxoox |
    | xooxxoox |
    | xoxiixox |
    | xxiiiixx |
    | xxxxxxxx |
    |          |
    ------------


## Details

### Supported figures

Points are generated by figures' algorithms located in the folder `lib/figures`. Every figure must inherits from `ConsoleDraw::Figures::Base` and implements common method `#calculate_points` that returns an array of `ConsoleDraw::Canvas::Point`.

#### Line

Line figure generates points by [algorithm of Bresenham](https://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm) for raster image. Input parameters for a line are coordinates of the first and the last points.

### Rectangle

Rectangle figure uses Line figures as edges to generate points. Input parameters for a rectangle are coordinates of an upper left and a lower right corners.

### Canvas

Canvas is a storage of points generated by figures. A figure might be drawn on a canvas object with a method `#draw`.

### Renders

Points map of canvas is rendered to string by class `ConsoleDraw::Render::StringRenderer` using "Raster scan" technique.

## CLI

Instantiates a command executor and sends user's input to the command executor. Command executor has a Context object, that provides an interface to draw on canvas and render canvas as String.

Corner cases are respected - available commands are whitelisted, implemented a confirmation for too big parameters (for example, attempt to create a canvas 200 * 200 requires a confirmation). If user's input is invalid, application should return an error message and fail a command.

## Notes

Application design is implemented in OOP-style because it is natural for Ruby. If we would rewrite the app to a Functional-friendly language like Scala, it might be done quite easy - some of classes do not hold an internal state and acts as pure functions (for example figures, canvas renderer) and some of classes will require tiny changes. When I wrote the application I tried to follow SRP and TDD. Hopefully, it is extendable - add new figures, support color for figures, add another interface (let's say HTTP service instead of CLI). Some places have a tradeoff - for example validation on coordinates when points are added to canvas is very general and requires loop over all points - this is a kind of bug-proof, but validation on Figures would be more performant (price here - leak of canvas to figure algorithm).
