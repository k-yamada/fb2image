# -*- coding: utf-8 -*-
require 'spec_helper'
module FB2Image
  describe FB do
    let(:create_fb) do
      width  = 100
      height = 20

      # make gradation fb
      line = (0...width).map {|x| [x * 255 / width, 0, 0, 0] }
      fb =  ([line] * height).flatten

      return FB.new(width, height, fb, {
        :bits_per_pixel => 32,
        :red_shift      => 0,
        :green_shift    => 8,
        :blue_shift     => 16
      })
    end

    describe "#write_png" do
      it "should write png file" do
        fb = create_fb
        fb.write_png("tmp/gradation.png")
      end
    end

    describe "#write_bmp" do
      it "should write bmp file" do
        fb = create_fb
        fb.write_bmp("tmp/gradation.bmp")
      end
    end

    describe "sample_code" do
      width  = 100
      height = 20

      # make gradation fb
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
    end
  end
end
