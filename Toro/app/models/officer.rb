class Officer < ActiveRecord::Base
  attr_accessible :company, :name
  belongs_to :company
  def full_name
    return self.company.name + " " + self.name
  end
end
