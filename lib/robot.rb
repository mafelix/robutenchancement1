require 'pry'
class Robot
  X = 0
  Y = 1
  DEFAULT_ATTACK = 5
  DEFAULT_RANGE = 1
  attr_reader :position, :items, :health, :range
  attr_accessor :equipped_weapon, :attack
  def initialize 
    @position = [0,0]
    @items = []
    @health = 100
    @equipped_weapon = nil
  end

    # (dx <= weaponrange && dy <= weaponrange) distance between
    # the x axis and distance between y axis < weapon range
  # def range?(enemy)
  #   distancex = (@position[X] - enemy.position[X]).abs
  #   distancey = (@position[Y] - enemy.position[Y]).abs
  #   (distancex <=  && distancey <= 1)
  # end
  def range(enemy)
    dx = (@position[X] - enemy.position[X]).abs
    dy = (@position[Y] - enemy.position[Y]).abs 
    if @equipped_weapon
      (dx <= @equipped_weapon.range && dy <= @equipped_weapon.range)
    else 
      (dx <= DEFAULT_RANGE && dy <= DEFAULT_RANGE)
    end
  end

  def discard_weapon
    self.equipped_weapon = nil
  end

  def attack(enemy)
    if equipped_weapon && range(enemy)
      equipped_weapon.hit(enemy)
      discard_weapon
    elsif range(enemy)
      enemy.wound(DEFAULT_ATTACK)
    else
      false
    end
  end

  #wound
  def wound(damage) 
    if (@health - damage) < 0 
      @health = 0
    else
      @health -= damage
    end
  end

  #heal
  def heal(amount)
    if @health + amount > 100
      @health = 100
    else
      @health += amount
    end
  end

  #pick_up ask about self.health box of bolts enchance test
  def pick_up(item)
    if item.is_a?Weapon 
      @equipped_weapon = item
    elsif item.is_a?BoxOfBolts 
      if self.health <= 80
        item.feed(self) 
      end
    elsif item.weight + items_weight <= 250
      @items << item
    end 
  end

  #items_weight should be zero
  def items_weight
    @items.inject(0) {|total, item| total + item.weight} 
  end

  #movement
  def move_left
    @position[X] -= 1
  end

  def move_right
    @position[X] += 1
  end

  def move_up
    @position[Y] += 1
  end

  def move_down
    @position[Y] -= 1
  end



end
