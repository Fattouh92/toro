class Officer < ActiveRecord::Base
  attr_accessible :company, :name
  belongs_to :company
  validates_presence_of :name, :company
  validates_format_of :name, with: /^[a-zA-Z ]*$/

  def full_name
    return self.company.name + " " + self.name
  end
end
