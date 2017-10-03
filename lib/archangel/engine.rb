# frozen_string_literal: true

module Archangel
  class Engine < ::Rails::Engine
    isolate_namespace Archangel
  end
end
