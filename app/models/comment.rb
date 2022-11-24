class Comment < ApplicationRecord
	 belongs_to :user
	 belongs_to :sauna
	  validates :comment,presence:true,length:{maximum:200}
end
