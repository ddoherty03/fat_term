# frozen_string_literal: true

module Fatty
  module Curses
    RSpec.describe Context do
      describe "#close" do
        it "restores normal terminal modes before closing curses" do
          context = Fatty::Curses::Context.new
          context.instance_variable_set(:@started, true)
          allow(context).to receive(:close_windows)
          allow(context).to receive(:disable_bracketed_paste!)
          allow(::Curses).to receive(:curs_set)
          allow(::Curses).to receive(:noraw)
          allow(::Curses).to receive(:echo)
          allow(::Curses).to receive(:nl)
          allow(::Curses).to receive(:close_screen)

          context.close

          expect(::Curses).to have_received(:curs_set).with(1)
          expect(::Curses).to have_received(:noraw)
          expect(::Curses).to have_received(:echo)
          expect(::Curses).to have_received(:nl)
          expect(::Curses).to have_received(:close_screen)
          expect(context).not_to be_started
        end
      end
    end
  end
end
