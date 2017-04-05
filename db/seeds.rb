unless AdminUser.any?
  AdminUser.create!(email: APP::ADMIN_EMAIL,
                    password: APP::DEFAULT_PASSWORD,
                    password_confirmation: APP::DEFAULT_PASSWORD)
end
