require 'gosu'

def media_path(file)
  File.join(File.dirname(__FILE__), 'Images', file)
end
PACMANR = media_path('pacman-right.png')
PACMANL = media_path('pacman-left.png')
PACMANU = media_path('pacman-up.png')
PACMAND = media_path('pacman-down.png')
PACMANC = media_path('pacman-closed.png')
SIZEPACMAN = 40
SIZE = 35          #kich thuoc tile anh
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
  @impact = 10
  @k = -2
  end

  def draw
    @image.draw(@x,@y,1)
  end

  #chuyen huong di chuyen
  def change_Direction(direction)
    @randDirection = rand
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

  #update co the di chuyen tiep hay khong
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
    xdown1 = @x  + SIZEPACMAN/2 + @impact
    xdown2 = @x  + SIZEPACMAN/2 - @impact
    ydown = @y + SIZEPACMAN - @k
    i1 = xdown1 / SIZE
    i2 = xdown2 / SIZE
    j = ydown / SIZE
    if (($tilesdoc[j][i1].to_i == 17) && ($tilesdoc[j][i2].to_i == 17))
      return true
    else 
      return false
    end
  end

  def canMoveUp
    xup1 = @x  + SIZEPACMAN/2 + @impact
    xup2 = @x  + SIZEPACMAN/2 - @impact
    yup = @y + @k
    i1 = xup1 / SIZE
    i2 = xup2 / SIZE
    j = yup / SIZE
    if (($tilesdoc[j][i1].to_i == 17) && ($tilesdoc[j][i2].to_i == 17))
      return true
    else 
      return false
    end
  end

  def canMoveRight
    xright = @x + SIZEPACMAN - @k
    yright1 = @y + SIZEPACMAN/2 + @impact
    yright2 = @y + SIZEPACMAN/2 - @impact
    i = xright / SIZE
    j1 = yright1 / SIZE
    j2 = yright2 / SIZE
    if (($tilesdoc[j1][i].to_i == 17) && ($tilesdoc[j2][i].to_i == 17))
      return true
    else 
      return false
    end
  end

  def canMoveLeft
    xleft = @x +  @k
    yleft1 = @y + SIZEPACMAN/2 + @impact
    yleft2 = @y + SIZEPACMAN/2 - @impact
    i = xleft / SIZE
    j1 = yleft1 / SIZE
    j2 = yleft2 / SIZE
    if (($tilesdoc[j1][i].to_i == 17) && ($tilesdoc[j2][i].to_i == 17))
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