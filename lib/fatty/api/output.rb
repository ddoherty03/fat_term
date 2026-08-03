# frozen_string_literal: true

module Fatty
  module OutputApi
    def append(text, follow: true, role: nil)
      payload = {
        text: output_text(text, role: role),
        follow: follow,
      }
      queue(Command.session(output_id, :append, **payload))
      nil
    end

    def append_now(text, follow: true, mode: nil, role: nil)
      payload = {
        text: output_text(text, role: role),
        follow: follow,
      }
      payload[:mode] = mode if mode

      terminal.apply_command(Command.session(output_id, :append, **payload))
      terminal.render_frame

      nil
    end

    def markdown(text)
      md = Fatty::Markdown.render(
        text,
        palette: markdown_palette,
        theme: markdown_theme,
        truecolor: markdown_truecolor?,
      )
      append(md)
      nil
    end

    private

    def output_text(text, role:)
      text = text.to_s
      if role
        Fatty::Ansi::Renderer.new.style(
          text,
          role: role,
          palette: markdown_palette,
        )
      else
        text
      end
    end

    def markdown_palette
      terminal.renderer.palette if terminal.respond_to?(:renderer) && terminal.renderer
    end

    def markdown_theme
      Fatty::Themes::Manager.fetch(Fatty::Themes::Manager.current)
    rescue StandardError
      nil
    end

    def markdown_truecolor?
      if terminal.respond_to?(:ctx) && terminal.ctx.respond_to?(:truecolor_enabled?)
        terminal.ctx.truecolor_enabled?
      elsif terminal.respond_to?(:renderer) &&
            terminal.renderer.respond_to?(:context) &&
            terminal.renderer.context.respond_to?(:truecolor)
        terminal.renderer.context.truecolor
      else
        false
      end
    end
  end
end
