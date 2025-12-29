# frozen_string_literal: true

module FatTerm
  class OutputBuffer
    def initialize
      @lines = []
      @scroll = 0
    end

    def append(text)
      text.to_s.each_line do |line|
        @lines << line.chomp
      end
    end

    def visible_lines(height)
      start = [@lines.length - height - @scroll, 0].max
      @lines[start, height] || []
    end

    def scroll_up
      @scroll += 1
    end

    def scroll_down
      @scroll -= 1 if @scroll.positive?
    end
  end
end
