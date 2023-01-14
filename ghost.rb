require 'gosu'

def media_path(file)
  File.join(File.dirname(__FILE__), 'Images', file)
end
REDLEFT = media_path('ghost_red_left.png')
REDRIGHT = media_path('ghost_red_right.png')
BLUELEFT = media_path('ghost_blue_left.png')
BLUERIGHT = media_path('ghost_blue_right.png')
SIZEGHOST = 40
SIZETILEGHOST = 50


class Ghost

  def initialize(x, y ,color ,moving , movingTo , speed)
    @x = x
    @y = y
    @speed = speed
    @color = color
    @k = -3
    if @color.eql? "red"
      @image = Gosu::Image.new(REDRIGHT , options = {} )
    elsif @color.eql? "blue"
      @image = Gosu::Image.new(BLUERIGHT , options = {} )

    end
    if moving.eql? "x"
      @direction = "right"
      @movement = moving
      @from = x
      @to = movingTo
    end

  end

  def draw
    @image.draw(@x , @y, 0)
  end

  def update
    chooseDirection
  

    if @direction.eql? "right"
      if @color.eql? "red"
        @image = Gosu::Image.new(REDRIGHT , options = {} )
      elsif @color.eql? "blue"
        @image = Gosu::Image.new(BLUERIGHT , options = {} )
      end
    elsif @direction.eql? "left"
      if @color.eql? "red"
        @image = Gosu::Image.new(REDLEFT , options = {} )
      elsif @color.eql? "blue"
        @image = Gosu::Image.new(BLUELEFT , options = {} )
      end
    elsif @direction.eql? "up"
      @image = Gosu::Image.new(PACMANU , options = {} )
    elsif @direction.eql? "down"
      @image = Gosu::Image.new(PACMAND , options = {} )
    end

  end

  def chooseDirection()
    #viet ham chon huong di tiep theo
    if @direction.eql? "right"
      if canMoveRight
        @x = @x + @speed
      else
        if canMoveDown
          @direction = "down"
        elsif canMoveUp 
          @direction = "up" 
        else 
          @direction = "left"
        end
      end 
    
    elsif @direction.eql? "left"
      if canMoveLeft
        @x = @x - @speed
      else
        if canMoveDown
          @direction = "down"
        elsif canMoveUp 
          @direction = "up" 
        else 
          @direction = "right"
        end
      end 

    elsif @direction.eql? "up"
      if canMoveUp
        @y = @y - @speed
      else
        if canMoveRight
          @direction = "right"
        elsif canMoveLeft
          @direction = "left"
        else
          @direction = "down"
        end
      end

    else
      if canMoveDown
        @y = @y + @speed
      else
        if canMoveRight
          @direction = "right"
        elsif canMoveLeft
          @direction = "left"
        else
          @direction = "up"
        end 
      end      
    end
  end

  def canMoveDown
    xdown1 = @x  + SIZEGHOST/2 + @impact
    xdown2 = @x  + SIZEGHOST/2 - @impact
    ydown = @y + SIZEGHOST - @k
    i1 = xdown1 / SIZETILEGHOST
    i2 = xdown2 / SIZETILEGHOST
    j = ydown / SIZETILEGHOST
    if (($tilesdoc[j][i1].to_i == 17) && ($tilesdoc[j][i2].to_i == 17))
      return true
    else 
      return false
    end
  end

  def canMoveUp
    xup1 = @x  + SIZEGHOST/2 + @impact
    xup2 = @x  + SIZEGHOST/2 - @impact
    yup = @y + @k
    i1 = xup1 / SIZETILEGHOST
    i2 = xup2 / SIZETILEGHOST
    j = yup / SIZETILEGHOST
    if (($tilesdoc[j][i1].to_i == 17) && ($tilesdoc[j][i2].to_i == 17))
      return true
    else 
      return false
    end
  end

  def canMoveRight
    xright = @x + SIZEGHOST - @k
    yright1 = @y + SIZEGHOST/2 + @impact
    yright2 = @y + SIZEGHOST/2 - @impact
    i = xright / SIZETILEGHOST
    j1 = yright1 / SIZETILEGHOST
    j2 = yright2 / SIZETILEGHOST
    if (($tilesdoc[j1][i].to_i == 17) && ($tilesdoc[j2][i].to_i == 17))
      return true
    else 
      return false
    end
  end

  def canMoveLeft
    xleft = @x +  @k
    yleft1 = @y + SIZEGHOST/2 + @impact
    yleft2 = @y + SIZEGHOST/2 - @impact
    i = xleft / SIZETILEGHOST
    j1 = yleft1 / SIZETILEGHOST
    j2 = yleft2 / SIZETILEGHOST
    if (($tilesdoc[j1][i].to_i == 17) && ($tilesdoc[j2][i].to_i == 17))
      return true
    else 
      return false
    end
  end
    

  def hitPacman(pacmanX,pacmanY)
    @distance1 = Gosu.distance(@x , @y , pacmanX ,pacmanY)
    @distance2 = Gosu.distance(@x+50 , @y+50 , pacmanX ,pacmanY)
    if @distance1 <= 10 || @distance2 <= 10
      return true
    else
      return false
    end
  end

end