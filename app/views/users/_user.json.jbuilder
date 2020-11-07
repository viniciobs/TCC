json.extract! user, :id, :name, :username, :user_type, :password, :password_confirmation, :created_at, :updated_at
json.url user_url(user, format: :json)