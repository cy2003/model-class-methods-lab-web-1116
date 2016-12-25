class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins(boats: :classifications).where("classifications.name = ?", 'Catamaran')
  end

  def self.sailors
    joins(boats: :classifications).where("classifications.name = ?", 'Sailboat').uniq
    # SELECT DISTINCT "captains" * WHERE
  end

  def self.talented_seamen
   # returns captains of motorboats and sailboats
    where(id: sailors.pluck(:id) & motorboators.pluck(:id))
  end

  def self.motorboators
    joins(boats: :classifications).where("classifications.name = ?", 'Motorboat').uniq
  end

  def self.talented_seamen
    where(id: sailors.pluck(:id) & motorboators.pluck(:id))
  end

  def self.non_sailors
    sailors = self.joins(boats: :classifications).where("classifications.name = 'Sailboat'")
    self.where.not(id: sailors)
  end


end
