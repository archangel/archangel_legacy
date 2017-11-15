# frozen_string_literal: true

ActionView::Template.register_template_handler :liquid,
                                               Archangel::LiquidView
