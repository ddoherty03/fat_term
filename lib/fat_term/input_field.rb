# frozen_string_literal: true

module FatTerm
  class InputField
    attr_reader :buffer, :prompt

    def initialize(prompt:, buffer: InputBuffer.new)
      @prompt = prompt
      @buffer = buffer
    end

    # Visual cursor X position in the window
    def cursor_x
      prompt_width + @buffer.cursor
    end

    def prompt_text
      @prompt.text
    end

    def prompt_width
      # keep it simple for now; upgrade to Unicode::DisplayWidth later
      prompt_text.length
    end

    # Editor actions (prompt-safe)
    def cursor_left
      @buffer.move_left if @buffer.cursor.positive?
    end

    def cursor_right
      @buffer.move_right
    end

    def backspace
      @buffer.backspace
    end

    def insert(str)
      @buffer.insert(str)
    end

    def accept_line
      line = @buffer.text.dup
      @buffer.clear
      line
    end
  end
end
