class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    limit(5)
    # same as self.all.limit(5)
    # SELECT "boats" * FROM "boats" LIMIT 5
  end

  def self.dinghy
    where('length < 20')
    # SELECT "boats" * FROM "boats" WHERE (length < 20)
  end

  def self.ship
    where('length > 20')
  end

  def self.last_three_alphabetically
    order(name: :desc).limit(3)
    # order('name').reverse_order.limit(3)
    # SELECT "boats" * FROM "boats" ORDER BY name LIMIT 3
  end

  def self.without_a_captain
    where(captain_id: nil)
    # SELECT "boats" * FROM "boats" WHERE captain_id = nil
  end

  def self.sailboats
    # joins(:classifications).where('classifications.name = "Sailboat"')
    joins(:classifications).where(classifications: {name: "Sailboat"})
  end

  def self.with_three_classifications
    joins(:classifications).group("boats.name").having("count(boats.name) = ?", 3)
  end


end
