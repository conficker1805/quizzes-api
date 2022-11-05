class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def save
    save!
  end
end
