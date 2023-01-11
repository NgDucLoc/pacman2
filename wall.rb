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
      puts @through
      @image = Gosu::Image.new(@img , options = {:rect => [0, 0, @height, @width]} )
      @a = -10
  end
  
  def draw
      @image.draw(@x,@y,0)
  end

  def hitUp(pacmanX , pacmanY)
    if  ((pacmanY + 38) == @y) &&
        ( (pacmanX).between?( (@x-@a) , (@x+@height+@a) )   || 
          (pacmanX+40).between?( (@x-@a), (@x+@height+@a) ) ||
          (pacmanX+20).between?( (@x-@a) , (@x+@height+@a) ) ) &&
        (@through == false)  
      return true
    else
      return false
    end
  end

  def hitDown(pacmanX , pacmanY)
    if  ((pacmanY +2 ) == @y+@width) &&
        ( (pacmanX).between?( (@x-@a) , (@x+@height+@a) )   ||
          (pacmanX+40).between?( (@x-@a), (@x+@height+@a) ) ||
          (pacmanX+20).between?( (@x-@a) , (@x+@height+@a) ) ) &&
        (@through == false)
      return true
    else
    return false
    end
  end

  def hitLeft(pacmanX , pacmanY)
    if  ((pacmanX + 38 ) == @x) &&
        ( (pacmanY).between?( (@y-@a) , (@y+@width+@a) )   || 
          (pacmanY+40).between?( (@y-@a), (@y+@width+@a) ) ||
          (pacmanY+20).between?( (@y-@a) , (@y+@width+@a) ) ) &&
      (@through == false)
      return true
    else
      return false
    end
  end

  def hitRight(pacmanX , pacmanY)
    if  ((pacmanX + 2) == @x+@height) &&
        ( (pacmanY).between?( (@y-@a) , (@y+@width+@a) )   || 
          (pacmanY+40).between?( (@y-@a), (@y+@width+@a) ) ||
          (pacmanY+20).between?( (@y-@a) , (@y+@width+@a) ) ) &&
        (@through == false)
      return true
    else
      return false
    end
  end

end