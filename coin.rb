require 'gosu'

def media_path(file)
  File.join(File.dirname(__FILE__), 'Resources', file)
end

COIN = media_path('coin.png')


class Coin
  def initialize(x, y)
    @x = y
    @y = x
    @image = Gosu::Image.new(COIN , options = {} )
    @eated = false
  end

  def draw
    if  @eated == false
      @image.draw(@x,@y,0)
    end
  end

  def isEated(pacmanX , pacmanY)
    @distance = Gosu.distance(@x , @y , pacmanX ,pacmanY)
    if @distance <= 19 && @eated == false
      $score += 1
      @eated = true
    end
  end
end

