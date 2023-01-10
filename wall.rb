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
  end
  
  def draw
      @image.draw(@x,@y,0)
  end

  def hitUp(pacmanX , pacmanY)
    if  ((pacmanY + 35) == @y) &&
        ( (pacmanX).between?( (@x-5) , (@x+@height+5) )   || 
          (pacmanX+50).between?( (@x-5), (@x+@height+5) ) ||
          (pacmanX+25).between?( (@x-5) , (@x+@height+5) ) ) &&
        (@through == false)  
      return true
    else
      return false
    end
  end

  def hitDown(pacmanX , pacmanY)
    if  ((pacmanY + 15) == @y+@width) &&
        ( (pacmanX).between?( (@x-5) , (@x+@height+5) )   ||
          (pacmanX+50).between?( (@x-5), (@x+@height+5) ) ||
          (pacmanX+25).between?( (@x-5) , (@x+@height+5) ) ) &&
        (@through == false)
      return true
    else
    return false
    end
  end

  def hitLeft(pacmanX , pacmanY)
    if  ((pacmanX + 35 ) == @x) &&
        ( (pacmanY).between?( (@y-5) , (@y+@width+5) )   || 
          (pacmanY+50).between?( (@y-5), (@y+@width+5) ) ||
          (pacmanY+25).between?( (@y-5) , (@y+@width+5) ) ) &&
      (@through == false)
      return true
    else
      return false
    end
  end

  def hitRight(pacmanX , pacmanY)
    if  ((pacmanX + 50) == @x+@height) &&
        ( (pacmanY).between?( (@y-5) , (@y+@width+5) )   || 
          (pacmanY+50).between?( (@y-5), (@y+@width+5) ) ||
          (pacmanY+25).between?( (@y-5) , (@y+@width+5) ) ) &&
        (@through == false)
      return true
    else
      return false
    end
  end

end