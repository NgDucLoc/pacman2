require 'gosu'

def media_path(file)
  File.join(File.dirname(__FILE__), 'Resources', file)
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
      @image = Gosu::Image.new(@img , options = {:rect => [0, 0, @height, @width]} )
  end
  
  def draw
      @image.draw(@x,@y,0)
  end

end