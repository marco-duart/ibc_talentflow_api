class User < ApplicationRecord
    has_one :recruiter
    has_one :user
end
