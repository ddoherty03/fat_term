# frozen_string_literal: true

module FatTerm
  class KeyEvent
    attr_reader :key, :ctrl, :meta, :shift

    def initialize(key:, ctrl: false, meta: false, shift: false)
      @key   = key
      @ctrl  = ctrl
      @meta  = meta
      @shift = shift
    end

    def ctrl?
      @ctrl
    end

    def meta?
      @meta
    end

    def shift?
      @shift
    end
  end
end
