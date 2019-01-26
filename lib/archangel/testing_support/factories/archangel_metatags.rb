# frozen_string_literal: true

FactoryBot.define do
  factory :metatag, class: "Archangel::Metatag" do
    association(:metatagable, factory: :page)
    name { "description" }
    content { "This is the description of this Page" }

    trait :for_page do
      association(:metatagable, factory: :page)
      name { "description" }
      content { "This is the description of the Page" }
    end

    trait :for_site do
      association(:metatagable, factory: :site)
      name { "description" }
      content { "This is the description of the Site" }
    end
  end
end
