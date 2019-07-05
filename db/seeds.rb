5.times do |n|
    name  = Faker::Name.name
    avatar = "#{n+1}.jpg"
    email = "admin#{n+1}@gmail.com"
    phone = "0359071558"
    bank_account = "0359071558"
    password = "password"
    role = "admin"
    User.create!(name: name,
          avatar: avatar,
          email: email,
          phone: phone,
          bank_account: bank_account,
          password: password,
          password_confirmation: password,
          role: role)
    end
    
    50.times do |n|
        name  = Faker::Name.name
        avatar = "#{n+1}.jpg"
        email = "nguyenkhoa#{n+1}@gmail.com"
        phone = "0359071558"
        bank_account = "0359071558"
        password = "password"
        role = "user"
        User.create!(name: name,
              avatar: avatar,
              email: email,
              phone: phone,
              bank_account: bank_account,
              password: password,
              password_confirmation: password,
              role: role)
        end
    
    10.times do |n|
        name  = Faker::Company.name
        description = Faker::Address.full_address
        Category.create!(name: name, description: description)
        end
    
    20.times do |n|
        name = Faker::Company.name
        description = Faker::Address.full_address
        image = "#{n+1}.jpg"
        user_id = n%5+1
        category_id = n%10+1
        Tour.create!(name: name, description: description, image: image, user_id: user_id, category_id: category_id)
        end
    
    200.times do |n|
        price = (n+1)*1000
        tour_total = (n+1)*100
        time_start = Time.zone.now + 10.days
        time_end = Time.zone.now + 11.days
        user_id = n%5+1
        tour_id = n%20+1
        TourDetail.create!(price: price, tour_total: tour_total, time_start: time_start, time_end: time_end, user_id: user_id, tour_id: tour_id)
        end
    
    400.times do |n|
        book_total = rand(1..6)
        user_id = n % 45 + 6
        tour_detail_id = n%200+1
        Booking.create!(book_total: book_total, user_id: user_id, tour_detail_id: tour_detail_id)
        end
    
    200.times do |n|
        content = Faker::Kpop.boy_bands
        user_id = n % 45 + 6
        tour_id = n % 20 + 1
        Review.create!(content: content, user_id: user_id, tour_id: tour_id)
        end
    100.times do |n|
        method = "Internet Banking"
        content = "Booking Tour"
        booking_id = n+1
        Payment.create!(method: method, content: content, booking_id: booking_id)
    end