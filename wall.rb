require 'gosu'

def media_path(file)
  File.join(File.dirname(__FILE__), 'Images', file)
end

#lay anh tuong
$walls_file = []
for i in 0..20
    if (i<10)
        $pathwall= ["0", i.to_s ,".png"].join()
    else 
        $pathwall=[i.to_s , ".png"].join()
    end

    $walls_file[i] = media_path($pathwall.to_s)
end

#khoi tao tuong
class Wall
  def initialize(x, y , h , w , axis)
      @x=y
      @y=x
      @height = h
      @width = w
      @img = $walls_file[axis]
      if axis == 17
          @through = true
      else 
          @through = false
      end
      @image = Gosu::Image.new(@img , options = {:rect => [0, 0, @height, @width]} )
      @a = 0
  end
  
  def draw
      @image.draw(@x,@y,0)
  end

  def hitUp(pacmanX , pacmanY)
    if (@through == false) 
      if  ((pacmanY + 40) == @y) &&
         ((pacmanX+6).between?( (@x-@a) , (@x+@height+@a) ) || 
          (pacmanX+34).between?( (@x-@a), (@x+@height+@a) ) ||
          (pacmanX+20).between?( (@x-@a) , (@x+@height+@a) ) )   
        return true
      end
    else
      return false
    end
  end

  def hitDown(pacmanX , pacmanY)
    if (@through == false)
      if  ((pacmanY + 5 ) == @y+@width) &&
        ( (pacmanX +6).between?( (@x-@a) , (@x+@height+@a) )  ||
          (pacmanX+34).between?( (@x-@a), (@x+@height+@a) )   ||
          (pacmanX+20).between?( (@x-@a) , (@x+@height+@a) ) ) 
        return true
      end
    else
      return false
    end
  end

  def hitLeft(pacmanX , pacmanY)
    if (@through == false)
      if  ((pacmanX + 40 ) == @x) &&
        ( (pacmanY+6).between?( (@y-@a) , (@y+@width+@a) )  || 
          (pacmanY+34).between?( (@y-@a), (@y+@width+@a) )  ||
          (pacmanY+20).between?( (@y-@a) , (@y+@width+@a) ) ) 
        return true
      end
    else
      return false
    end
  end

  def hitRight(pacmanX , pacmanY)
    if (@through == false)
      if  ((pacmanX + 5 ) == @x+@height) &&
        ( (pacmanY+6).between?( (@y-@a) , (@y+@width+@a) )  || 
          (pacmanY+34).between?( (@y-@a), (@y+@width+@a) )  ||
          (pacmanY+20).between?( (@y-@a) , (@y+@width+@a) ) )   
        return true
      end
    else
      return false
    end
  end

end