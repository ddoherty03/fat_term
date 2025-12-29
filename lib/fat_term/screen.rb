# frozen_string_literal: true

require "curses"

module FatTerm
  class Screen
    attr_reader :rows, :cols, :output_win, :input_win

    def initialize
      Curses.init_screen
      Curses.raw
      Curses.noecho
      Curses.curs_set(1)
      Curses.stdscr.keypad(true)

      resize
    end

    def resize
      @rows = Curses.lines
      @cols = Curses.cols

      @output_win&.close
      @input_win&.close

      @output_win = Curses::Window.new(rows - 1, cols, 0, 0)
      @input_win  = Curses::Window.new(1, cols, rows - 1, 0)

      @output_win.scrollok(true)

      @input_win.keypad(true)
    end

    def close
      Curses.close_screen
    end

    def read_key
      ch = @input_win.getch

      case ch
      when Integer
        case ch
        when 3
          KeyEvent.new(key: :c, ctrl: true)
        when 10
          KeyEvent.new(key: :enter)
        when Curses::KEY_LEFT
          KeyEvent.new(key: :left)
        when Curses::KEY_RIGHT
          KeyEvent.new(key: :right)
        when Curses::KEY_UP
          KeyEvent.new(key: :up)
        when Curses::KEY_DOWN
          KeyEvent.new(key: :down)
        when Curses::KEY_BACKSPACE, 127
          KeyEvent.new(key: :backspace)
        when Curses::KEY_RESIZE
          KeyEvent.new(key: :resize)
        end
      when String
        KeyEvent.new(key: ch)
      end
    end
  end
end
