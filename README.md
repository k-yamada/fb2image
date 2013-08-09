# FB2Image

Convert Frame Buffer to Image (png, bmp..)

## Installation

Add this line to your application's Gemfile:

    gem 'fb2image'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fb2image

## Usage

    require 'fb2image'

    width  = 100
    height = 20

    # make gradation rawdata
    line = (0...width).map {|x| [x * 255 / width, 0, 0, 0] }
    fb =  ([line] * height).flatten

    # initialize FB
    fb = FB.new(width, height, fb, {
      :bits_per_pixel => 32,
      :red_shift      => 0,
      :green_shift    => 8,
      :blue_shift     => 16
    })

    # create png
    fb.write_png("tmp/gradation.png")

    # create bmp
    fb.write_bmp("tmp/gradation.bmp")

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
