require 'gosu'

def media_path(file)
  File.join(File.dirname(__FILE__), 'Images', file)
end
PACMANR = media_path('pacman-right.png')
PACMANL = media_path('pacman-left.png')
PACMANU = media_path('pacman-up.png')
PACMAND = media_path('pacman-down.png')
PACMANC = media_path('pacman-closed.png')

class Pacman
  attr_reader :x, :y

  def initialize(x, y , speed)
  @x = x
  @y = y
  @speed = speed
  @image = Gosu::Image.new(PACMANR , options = {} )

  @current_direction = "right"
  @stored_direction = "none"
  @updateCounter = 0
  end

  def draw
    @image.draw(@x,@y,1)
  end

  def change_Direction(direction)
    if (direction == "right")
      if canMoveRight
      @current_direction = "right"
      else
        @stored_direction = "right"
      end
     end
    if (direction == "left")
      if canMoveLeft
        @current_direction = "left"
      else
        @stored_direction = "left"
      end
    end
    if (direction == "up")
      if canMoveUp
        @current_direction = "up"
      else
        @stored_direction = "up"
      end
    end
    if (direction == "down")
      if canMoveDown
        @current_direction = "down"
      else
        @stored_direction = "down"
      end
    end
  end

  def update
    if @stored_direction.eql? "right"
      if canMoveRight
        @current_direction = "right"
        @stored_direction = "none"
      end
    end
    if @stored_direction.eql? "left"
      if canMoveLeft
        @current_direction = "left"
        @stored_direction = "none"
      end
    end
    if @stored_direction.eql? "up"
      if canMoveUp
        @current_direction = "up"
        @stored_direction = "none"
      end
    end
    if @stored_direction.eql? "down"
      if canMoveDown
        @current_direction = "down"
        @stored_direction = "none"
      end
    end

    if @current_direction.eql? "right"
      if canMoveRight
        @x = @x + @speed
      end
    end
    if @current_direction.eql? "left"
      if canMoveLeft
        @x = @x - @speed
      end
    end
    if @current_direction.eql? "up"
      if canMoveUp
        @y = @y - @speed
      end
    end
    if @current_direction.eql? "down"
      if canMoveDown
        @y = @y + @speed
      end
    end


    if @x>750
      @x = 0
    end
    if @x < 0
      @x=750
    end

    if @updateCounter >= 60
      @updateCounter = 0
    else
      @updateCounter = @updateCounter + 1
    end
    if @updateCounter > 30
      @image = Gosu::Image.new(PACMANC , options = {} )
    elsif @current_direction.eql? "right"
      @image = Gosu::Image.new(PACMANR , options = {} )
    elsif @current_direction.eql? "left"
      @image = Gosu::Image.new(PACMANL , options = {} )
    elsif @current_direction.eql? "up"
      @image = Gosu::Image.new(PACMANU , options = {} )
    elsif @current_direction.eql? "down"
      @image = Gosu::Image.new(PACMAND , options = {} )
    end

  end

  def canMoveDown
      c = 0
      for i in 0..32
        if $walls[i].hitUp(@x,@y)
          c += 1
        end
      end
      if c == 0
        return true
      else
        return false
      end
  end

  def canMoveUp
    c = 0
    for i in 0..32
      if $walls[i].hitDown(@x,@y)
        c += 1
      end
    end
    if c == 0
      return true
    else
      return false
    end
  end

  def canMoveRight
    c = 0
    for i in 0..32
      if $walls[i].hitLeft(@x,@y)
        c += 1
      end
    end
    if c == 0
      return true
    else
      return false
    end
  end

  def canMoveLeft
    c = 0
    for i in 0..32
      if $walls[i].hitRight(@x,@y)
        c += 1
      end
    end
    if c == 0
      return true
    else
      return false
    end
  end

  def changeXY(x,y)
    @x = x
    @y = y
  end
end