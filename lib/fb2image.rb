# -*- coding: utf-8 -*-
require "zlib"
require "fb2image/version"
require "fb2image/bmp"

module FB2Image
  # Your code goes here...

  class FB
    attr_accessor :src_width, :src_height, :width, :height, :fb, :thinning_rate

    def initialize(src_width, src_height, fb, opts={})
      @src_width       = src_width
      @src_height      = src_height
      @fb              = fb
      @thinning_rate   = opts[:thinning_rate] || 1
      @width           = @src_width  / @thinning_rate
      @height          = @src_height / @thinning_rate
      @r_shift         = (opts[:red_shift]   || 0)  / 8
      @g_shift         = (opts[:green_shift] || 8)  / 8
      @b_shift         = (opts[:blue_shift]  || 16) / 8
      @bits_per_pixel  = opts[:bits_per_pixel] || 1
      @bytes_per_pixel = @bits_per_pixel / 8
    end

    def write_png(dest_path)
      depth      = 8 #@bits_per_pixel
      color_type = 2
      img_data   = ""

      open(dest_path, "wb") do |f|
        # ファイルシグニチャ
        f.print "\x89PNG\r\n\x1a\n"

        # ヘッダ
        f.print chunk("IHDR", [@width, @height, depth, color_type, 0, 0, 0].pack("NNCCCCC"))

        # 画像データ
        @height.times do |y|
          line = []
          @width.times do |x|
            idx = (y * @src_width * @thinning_rate) + (x * @thinning_rate)
            pixel = @fb[idx * @bytes_per_pixel, @bytes_per_pixel]
            r = pixel[@r_shift, 1]
            g = pixel[@g_shift, 1]
            b = pixel[@b_shift, 1]
            line << [r, g, b]
          end
          img_data << ([0] + line.flatten).pack("C*")
        end

        f.print chunk("IDAT", Zlib::Deflate.deflate(img_data))

        # 終端
        f.print chunk("IEND", "")
      end
    end

    def write_bmp(dest_path)
      image = BitMap.new(@width, @height)
      @height.times do |y|
        @width.times do |x|
          idx = (y * @src_width * @thinning_rate) + (x * @thinning_rate)
          pixel = @fb[idx * @bytes_per_pixel, @bytes_per_pixel]
          r = pixel[@r_shift]
          g = pixel[@g_shift]
          b = pixel[@b_shift]
          image.pset(x, y, r, g, b)
        end
      end
      image.write(dest_path)
    end


    private


    # チャンクのバイト列生成関数
    def chunk(type, data)
      [data.bytesize, type, data, Zlib.crc32(type + data)].pack("NA4A*N")
    end
  end

end
