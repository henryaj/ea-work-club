class SentEmail < ApplicationRecord
  belongs_to :user

  def self.record_success(user, email, status = "OK", id, body)
    email = new(
      user: user,
      email: email,
      status: status,
      handler_id: id,
      body: body
    )
    email.save
  end

  def self.record_failure(user, email, status = "Failed", id, body)
    email = new(
      user: user,
      email: email,
      status: status,
      handler_id: id,
      body: body
    )
    email.save
  end
end
