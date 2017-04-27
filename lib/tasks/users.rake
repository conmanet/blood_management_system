namespace :users do
  task create_admin: :environment do |t|
    emails = ["sontd.it@gmail.com", "boyz.ds@gmail.com"]
    password = "Aa@123456";
    emails.each do |email, n|
      user = User.find_or_initialize_by email: email
      user.assign_attributes name: "Root Admin", password: password, gender: :male,
        address: "Ky tuc xa DMC 579, Da Nang", id_number: "191837949#{n}", role: :admin,
        phone_number: "01206213188#{n}", blood_type: :b_pos
      user.skip_confirmation!
      begin
        user.save!
      rescue
        puts "Errors when create #{email}:"
        puts user.errors.pretty_inspect
      end
    end
    puts "Created successfully."
  end
end
