# frozen_string_literal: true

module FatTerm
  module Keymaps
    def self.emacs
      map = KeyMap.new

      map.bind(key: :left,  action: :cursor_left)
      map.bind(key: :right, action: :cursor_right)

      map.bind(key: :c, ctrl: true, action: :interrupt)
      map.bind(key: :enter, action: :accept_line)

      map.bind(key: :backspace, action: :backspace)

      map
    end
  end
end
