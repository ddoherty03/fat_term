# frozen_string_literal: true

module FatTerm
  class Prompt
    def initialize(&block)
      @block = block
    end

    def text
      @block.call.to_s
    end
  end
end
