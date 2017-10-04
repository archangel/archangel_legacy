# frozen_string_literal: true

module Archangel
  module Auth
    class RegistrationsController < Devise::RegistrationsController
      before_action :allow_registration,
                    only: %i[cancel create destroy edit new update]

      protected

      def allow_registration
        return render_404 unless false == true
      end
    end
  end
end
