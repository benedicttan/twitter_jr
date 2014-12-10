class Tweet < ActiveRecord::Base
  belongs_to :TwitterUser
end
