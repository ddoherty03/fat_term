# frozen_string_literal: true

module FatTerm
  require_relative "fat_term/version"
  require_relative "fat_term/input_buffer"
  require_relative "fat_term/input_field"
  require_relative "fat_term/output_buffer"
  require_relative "fat_term/prompt"
  require_relative "fat_term/renderer"
  require_relative "fat_term/screen"
  require_relative "fat_term/key_event"
  require_relative "fat_term/key_map"

  class Error < StandardError; end
end
