FactoryBot.define do
  factory :listing do
    model { "MyString" }
    condition { "MyString" }
    movement { "MyString" }
    case_details { "MyString" }
    strap { "MyString" }
    year { 1 }
    price { 1 }
    authenticity { false }
    sold { false }
    description { "MyText" }
    user { nil }
    brand { nil }
  end
end
