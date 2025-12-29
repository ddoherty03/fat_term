# frozen_string_literal: true

module FatTerm
  class Renderer
    def initialize(screen)
      @screen = screen
    end

    def render(output:, input_field:)
      render_output(output)
      render_input_field(input_field)
    end

    private

    def render_output(output)
      win = @screen.output_win
      win.clear

      lines = output.visible_lines(@screen.rows - 1)
      lines.each_with_index do |line, y|
        win.setpos(y, 0)
        win.addstr(line)
      end

      win.refresh
    end

    def render_input_field(field)
      win = @screen.input_win
      win.clear

      win.setpos(0, 0)
      win.addstr(field.prompt_text)
      win.addstr(field.buffer.text)

      win.setpos(0, field.cursor_x)
      win.refresh
    end

  end
end
