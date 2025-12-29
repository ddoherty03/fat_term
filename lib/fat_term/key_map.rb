# frozen_string_literal: true

require_relative 'keymaps/emacs'

module FatTerm
  class  KeyMap
    def initialize
      @bindings = {}
    end

    def bind(key:, ctrl: false, meta: false, shift: false, action:)
      @bindings[[key, ctrl, meta, shift]] = action
    end

    def resolve(event)
      return nil unless event

      @bindings[[event.key, event.ctrl?, event.meta?, event.shift?]]
    end
  end
end
