require 'gosu'

def media_path(file)
  File.join(File.dirname(__FILE__), 'Images', file)
end
REDLEFT = media_path('ghost_red_left.png')
REDRIGHT = media_path('ghost_red_right.png')
BLUELEFT = media_path('ghost_blue_left.png')
BLUERIGHT = media_path('ghost_blue_right.png')

class Ghost

  def initialize(x, y ,color ,moving , movingTo , speed)
    @x = x
    @y = y
    @speed = speed
    @color = color
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
    if @direction.eql? "right"
      if @x < @to
        @x = @x + @speed
      else
        @direction = "left"
      end
    end

    if @direction.eql? "left"
      if @x > @from
        @x = @x - @speed
      else
        @direction = "right"
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
      @image = Gosu::Image.new(PACMANU , options = {} )
    elsif @direction.eql? "down"
      @image = Gosu::Image.new(PACMAND , options = {} )
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