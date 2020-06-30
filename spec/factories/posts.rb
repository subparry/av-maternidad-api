FactoryBot.define do
  factory :post do
    title { "Sample title" }
    body { "Sample post body. This is a lorem ipsum dolor sit amet." }
    image { "https://www.royalsundaram.in/html/files/motor101/car/maruthi-800.jpg" }
    admin
  end
end