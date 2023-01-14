require 'gosu'

def media_path(file)
  File.join(File.dirname(__FILE__), 'Images', file)
end
REDLEFT = media_path('ghost_red_left.png')
REDRIGHT = media_path('ghost_red_right.png')
REDUP = media_path('ghost_red_up.png')
REDDOWN = media_path('ghost_red_down.png')
BLUELEFT = media_path('ghost_blue_left.png')
BLUERIGHT = media_path('ghost_blue_right.png')
BLUEUP = media_path('ghost_blue_up.png')
BLUEDOWN = media_path('ghost_blue_down.png')
SIZEGHOST = 50
SIZETILE = 35


class Ghost

  def initialize(x, y ,color  , speed)
    @x = x
    @y = y
    @speed = speed
    @color = color
    @k = 0
    @impact = 10
    if @color.eql? "red"
      @image = Gosu::Image.new(REDRIGHT , options = {} )
    elsif @color.eql? "blue"
      @image = Gosu::Image.new(BLUERIGHT , options = {} )

    end

    @direction = "right"

  end

  def draw
    @image.draw(@x , @y, 0)
  end

  def update
     # chon huong di tiep theo
    @randDirection = rand(0..1)
    if @direction.eql? "right"
      if canMoveRight
        @x = @x + @speed
      else
        if canMoveDown and (@randDirection == 0)
          @direction = "down"
        elsif canMoveUp and (@randDirection == 1)
          @direction = "up" 
        else 
          @direction = "left"
        end
      end 
    
    elsif @direction.eql? "left"
      if canMoveLeft
        @x = @x - @speed
      else
        if canMoveDown and (@randDirection == 0)
          @direction = "down"
        elsif canMoveUp and (@randDirection == 1)
          @direction = "up" 
        else 
          @direction = "right"
        end
      end 

    elsif @direction.eql? "up"
      if canMoveUp
        @y = @y - @speed
      else
        if canMoveRight and (@randDirection == 0)
          @direction = "right"
        elsif canMoveLeft and (@randDirection == 1)
          @direction = "left"
        else
          @direction = "down"
        end
      end

    else
      if canMoveDown
        @y = @y + @speed
      else
        if canMoveRight and (@randDirection == 0)
          @direction = "right"
        elsif canMoveLeft and (@randDirection == 1)
          @direction = "left"
        else
          @direction = "up"
        end 
      end      
    end
  

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
      if @color.eql? "red"
        @image = Gosu::Image.new(REDUP , options = {} )
      elsif @color.eql? "blue"
        @image = Gosu::Image.new(BLUEUP , options = {} )
      end
    elsif @direction.eql? "down"
      if @color.eql? "red"
        @image = Gosu::Image.new(REDDOWN , options = {} )
      elsif @color.eql? "blue"
        @image = Gosu::Image.new(BLUEDOWN , options = {} )
      end
    end

  end

  def chooseDirection()
    #viet ham chon huong di tiep theo
    if @direction.eql? "right"
      if canMoveRight
        @x = @x + @speed
      else
        if canMoveDown
          @direction = "up"
        elsif canMoveUp 
          @direction = "down" 
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
          @direction = "left"
        elsif canMoveLeft
          @direction = "right"
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
    i1 = xdown1 / SIZETILE
    i2 = xdown2 / SIZETILE
    j = ydown / SIZETILE
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
    i1 = xup1 / SIZETILE
    i2 = xup2 / SIZETILE
    j = yup / SIZETILE
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
    i = xright / SIZETILE
    j1 = yright1 / SIZETILE
    j2 = yright2 / SIZETILE
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
    i = xleft / SIZETILE
    j1 = yleft1 / SIZETILE
    j2 = yleft2 / SIZETILE
    if (($tilesdoc[j1][i].to_i == 17) && ($tilesdoc[j2][i].to_i == 17))
      return true
    else 
      return false
    end
  end
    

  def hitPacman(pacmanX,pacmanY)
    @distance1 = Gosu.distance(@x , @y , pacmanX ,pacmanY)
    @distance2 = Gosu.distance(@x+50 , @y+50 , pacmanX ,pacmanY)
    if @distance1 <= 20 || @distance2 <= 20
      return true
    else
      return false
    end
  end

end