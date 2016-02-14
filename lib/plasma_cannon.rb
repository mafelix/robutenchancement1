class PlasmaCannon < Weapon
  attr_reader :name, :weight, :damage
  def initialize
    super("Plasma Cannon", weight = 200, damage = 55)
  end
end
