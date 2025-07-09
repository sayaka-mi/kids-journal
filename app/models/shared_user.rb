class SharedUser < ApplicationRecord
  belongs_to :user
  belongs_to :shared_user, class_name: 'User'
end
