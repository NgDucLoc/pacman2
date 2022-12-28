require 'gosu'

def media_path(file)
  File.join(File.dirname(__FILE__), 'Images', file)
end

DOT = media_path('dot.png')
class Dot

  def initialize(x, y)
    @x = x
    @y = y
    @image = Gosu::Image.new(DOT , options = {} )
    @eated = false
  end

  def draw
    if  @eated == false
      @image.draw(@x,@y,0)
    end
  end

  def isEated(pacmanX , pacmanY)
    @distance = Gosu.distance(@x , @y , pacmanX ,pacmanY)
    if @distance <= 10 && @eated == false
      $score += 1
      @eated = true
    end
  end

  end