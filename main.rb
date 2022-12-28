require 'gosu'
#require 'gosu_tiled'
require_relative 'wall'
require_relative 'pacman'
require_relative 'dot'
require_relative 'ghost'

def media_path(file)
  File.join(File.dirname(__FILE__), 'Images', file)
end

class Window < Gosu::Window
  BACKGROUND = media_path('maze.png')
  FONT = media_path('PressStart2Play.ttf')
  DEATHSONG= media_path('pacman_death.wav')
  OPENSONG= media_path('pacman_beginning.wav')


  def initialize
    super 750, 933
    self.caption = "Pacman Game"
    @background_image = Gosu::Image.new(BACKGROUND, :tileable => true)
    $lives = 3
    $score = 0
    $won = false
    @font = Gosu::Font.new(self ,FONT , 30)
    @openMusic = Gosu::Sample.new(OPENSONG)
    @openMusic.play(1,1,false)
    #####################   read walls  ##############################
    $walls = Array.new(33)
    lines = IO.readlines("inputWall.txt")
    c = 0
    lines.each do |i|
      splited = i.split(" ")
      $walls[c] = Wall.new(splited[0].to_i,splited[1].to_i,splited[2].to_i,splited[3].to_i,splited[4])
      c = c + 1
    end
    #####################   create dots   ##############################
    $dots = Array.new(300)
    $dotsNum = 0
    c = 60
    while c < 700
      $dots[$dotsNum] = Dot.new(c,110)
      $dotsNum += 1
      $dots[$dotsNum] = Dot.new(c,210)
      $dotsNum += 1
      $dots[$dotsNum] = Dot.new(c,610)
      $dotsNum += 1
      $dots[$dotsNum] = Dot.new(c,810)
      $dotsNum += 1
      c += 20
    end

    c = 180
    while c < 580
      $dots[$dotsNum] = Dot.new(c,310)
      $dotsNum += 1
      $dots[$dotsNum] = Dot.new(c,510)
      $dotsNum += 1
      c += 20
    end

    c = 60
    while c < 120
      $dots[$dotsNum] = Dot.new(c,710)
      $dotsNum += 1
      c += 20
    end
    c = 220
    while c < 540
      $dots[$dotsNum] = Dot.new(c,710)
      $dotsNum += 1
      c += 20
    end
    c = 640
    while c < 700
      $dots[$dotsNum] = Dot.new(c,710)
      $dotsNum += 1
      c += 20
    end
    #####################    create ghosts    ###########################
    $ghosts = Array.new(2)
    $ghosts[0] = Ghost.new(40,90,"red","x",650,5)
    $ghosts[1] = Ghost.new(40,790,"blue","x",650,5)

    $player = Pacman.new(350,390,5)
    @timer = 2000
  end

  def update
    if $score == $dotsNum
      $won = true
    end
    if $won == false && (Gosu::milliseconds() >4000 && Gosu::milliseconds()-@timer >2000)
    if button_down? Gosu::Button::KbLeft
      $player.change_Direction("left")
    end
    if button_down? Gosu::Button::KbRight
        $player.change_Direction("right")
    end

    if button_down? Gosu::Button::KbDown
        $player.change_Direction("down")
    end

    if button_down? Gosu::Button::KbUp
        $player.change_Direction("up")
    end
      $player.update
      c = 0
      while c < $ghosts.size
        $ghosts[c].update
        c += 1
      end

    c = 0
    while c < $ghosts.size
      if $ghosts[c].hitPacman($player.x,$player.y)
        $player.changeXY(350,390)
        $lives -= 1
        @timer = Gosu::milliseconds()
        @deathMusic = Gosu::Sample.new(DEATHSONG)
        @deathMusic.play(1,1,false)
        if $lives == -1
          @timer = 2000
        end
      end
      c += 1
    end
    end

  end

  def draw
    @background_image.draw(0, 0, 0)
    c = 0
    while c < $walls.size
      $walls[c].draw
      c += 1
    end

    c = 0
    while c < $dotsNum
      $dots[c].isEated($player.x+25 , $player.y+25)

      $dots[c].draw
      c += 1
    end
    if $score != $dotsNum
      c = 0
      while c < $ghosts.size
        $ghosts[c].draw
        c += 1
      end
    end
    @font.draw("Score: #{$score}", 10, 10, 1, 1.0, 1.0, Gosu::Color::YELLOW)
    if $lives > -1
    @font.draw("Lives: #{$lives}", 500, 10, 1, 1.0, 1.0, Gosu::Color::YELLOW)
    else
      @font.draw("Lives: 0", 500, 10, 1, 1.0, 1.0, Gosu::Color::YELLOW)
    end

      if $lives > -1
      $player.draw
      else
        @font.draw("Game Over", 150, 390, 1, 1.8, 1.8, Gosu::Color::RED)

    end
    if $score == $dotsNum
      @font.draw("You Won!", 150, 390, 1, 1.8, 1.8, Gosu::Color::YELLOW)
    end

  end


end

Window.new.show
