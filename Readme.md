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

Points are generated by figures' algorithms located in the folder `lib/figures`. Every figure must inherits from `ConsoleDraw::Figures::Base` and implements common method `#calculate_points!` that returns array of points.
