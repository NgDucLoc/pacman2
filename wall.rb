require 'gosu'

def media_path(file)
  File.join(File.dirname(__FILE__), 'Images', file)
end
class Wall
  HWALL = media_path('wallH.png')
  VWALL = media_path('wallV.png')

  def initialize(x, y , h , w , axis)
    @x=x
    @y=y
    @height = h
    @width = w
    if(axis.eql? "h")
      @img = HWALL
    else
      @img = VWALL
    end
    @image = Gosu::Image.new(@img , options = {:rect => [0, 0, @height, @width]} )
  end
  def draw
    @image.draw(@x,@y,0)
  end

  def hitUp(pacmanX , pacmanY)
    if ((pacmanY + 60) == @y) &&
        ( (pacmanX).between?( (@x-5) , (@x+@height+5) )   || (pacmanX+50).between?( (@x-5), (@x+@height+5) ) ||
            (pacmanX+25).between?( (@x-5) , (@x+@height+5) ) )
      return true
    else
      return false
    end
  end

  def hitDown(pacmanX , pacmanY)
    if ((pacmanY - 10) == @y+@width) &&
        ( (pacmanX).between?( (@x-5) , (@x+@height+5) )   || (pacmanX+50).between?( (@x-5), (@x+@height+5) ) ||
            (pacmanX+25).between?( (@x-5) , (@x+@height+5) ) )
      return true
    else
    return false
    end
  end

  def hitLeft(pacmanX , pacmanY)
    if ((pacmanX + 60) == @x) &&
        ( (pacmanY).between?( (@y-5) , (@y+@width+5) )   || (pacmanY+50).between?( (@y-5), (@y+@width+5) ) ||
            (pacmanY+25).between?( (@y-5) , (@y+@width+5) ) )
      return true
    else
      return false
    end
  end

  def hitRight(pacmanX , pacmanY)
    if ((pacmanX - 10) == @x+@height) &&
        ( (pacmanY).between?( (@y-5) , (@y+@width+5) )   || (pacmanY+50).between?( (@y-5), (@y+@width+5) ) ||
            (pacmanY+25).between?( (@y-5) , (@y+@width+5) ) )
      return true
    else
      return false
    end
  end

end