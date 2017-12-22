# frozen_string_literal: true

module Archangel
  ##
  # Application base mailer
  #
  class ApplicationMailer < ActionMailer::Base
    default from: "from@example.com"

    layout "mailer"
  end
end
