require 'gosu'
require 'ruby2d'
#require 'gosu_tiled'
require_relative 'wall'
require_relative 'pacman'
require_relative 'coin'
require_relative 'ghost'

def media_path(file)
  File.join(File.dirname(__FILE__), 'Resources', file)
end



class PlayState < Gosu::Window
  BACKGROUND = media_path('background.png')
  ENDLOSE = media_path("backgroundPacman.png")
  ENDWIN = media_path("wingame.png")
  FONT = media_path('PressStart2Play.ttf')
  DEATHSONG= media_path('pacman_death.wav')
  OPENSONG= media_path('pacman_beginning.wav')
  SIZE = 35          #kich thuoc tile anh
  SIZE_WIDTH= 37     #chieu ngang map = 28 tile gach + khong gian bieu dien diem
  SIZE_HEIGHT = 31   #chieu doc map


  def initialize
    super SIZE_WIDTH*SIZE , SIZE_HEIGHT*SIZE
    self.caption = "Pacman Game"
    @background_image = Gosu::Image.new(BACKGROUND, :tileable => true)
    @endlose = Gosu::Image.new(ENDLOSE , :tileable => true )
    @endwin = Gosu::Image.new(ENDWIN , :tileable => true )
    $lives = 3
    $score = 0
    $won = false
    @font = Gosu::Font.new(self ,FONT , 30)
    @openMusic = Gosu::Sample.new(OPENSONG)
    @openMusic.play(1,1,false)
    #####################   read walls  ##############################
    $tilesdoc = []
    lines = IO.readlines("inputWall.txt")

    lines.each do |i|
        splited = i.split(" ")
        $tilesdoc.push(splited)
    end

    $walls = []
    t=0
    for i in 0..$tilesdoc.length-1
        row =  $tilesdoc[i]
        for j in 0..row.length-1
            $walls[t] =Wall.new(SIZE*i,SIZE*j, SIZE, SIZE, $tilesdoc[i][j].to_i) 
            t=t+1
        end
    end
    #####################   create coins   ##############################
    $coins = []
    $coinsNum = 0
    for i in 0..$tilesdoc.length-1
      row =  $tilesdoc[i]
      for j in 0..row.length-1
          if $tilesdoc[i][j].to_i == 17
            $coins[$coinsNum] = Coin.new(i*35+7, j*35+8)
            $coinsNum +=1
          end
      end
    end
    #####################    create ghosts    ###########################
    $ghosts = Array.new(3)
    $ghosts[0] = Ghost.new(37,30,"red",5)
    $ghosts[1] = Ghost.new(520,30,"blue",5)
    $ghosts[2] = Ghost.new(500, 1000, "blue", 5)
    $player = Pacman.new(470,380,5)
    @timer = 2000
  end


  #close game or start newgame
  def button_down(id)
    close if id == Gosu::KbEscape

    initialize if id == Gosu::KB_N
  end


  def update
    if $score == $coinsNum
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
          $player.changeXY(470,380)
          $lives -= 1
          @timer = Gosu::milliseconds()
          @deathMusic = Gosu::Sample.new(DEATHSONG)
          @deathMusic.play(1,1,false)
          if $lives == -1
            @timer== 2000
          end
        end
        c += 1
      end
    end

  end

  def draw

    if($lives != -1 && $won== false)
      @background_image.draw(0, 0, 0)
      @font.draw("Restart:N",1000, 450, 1, 1, 1, Gosu::Color::RED)
      
      
      #draw wall
      c = 0
      while c < $walls.size
        $walls[c].draw
        c += 1
      end
      #draw coin
      c = 0
      while c < $coinsNum
        $coins[c].isEated($player.x+20 , $player.y+20)
        $coins[c].draw
        c += 1
      end
    
      #draw ghosts
      if $score != $coinsNum
        c = 0
        while c < $ghosts.size
          $ghosts[c].draw
          c += 1
        end
      end

      #draw Score and live
      @font.draw("Score: #{$score}", 1000, 50, 1, 1.0, 1.0, Gosu::Color::YELLOW)
      if $lives > -1
        @font.draw("Lives: #{$lives}", 1000, 100, 1, 1.0, 1.0, Gosu::Color::YELLOW)
      else
        @font.draw("Lives: 0", 1000, 50, 1, 1.0, 1.0, Gosu::Color::YELLOW)
      end

      $player.draw
    elsif($lives== -1 and $won == false)
      @endlose.draw(0, 0, 0)
      @font.draw("Game Over", 150, 390, 1, 1.8, 1.8, Gosu::Color::RED)
      @font.draw("An phim N de bat dau van moi",170, 450, 1, 1, 1, Gosu::Color::YELLOW)
    end
    
    if $score == $coinsNum
      $won = true
      @endwin.draw(0, 0, 0)
      @font.draw("You Won!", 150, 390, 1, 1.8, 1.8, Gosu::Color::YELLOW)
      @font.draw("An phim N de bat dau van moi",170, 450, 1, 1, 1, Gosu::Color::RED)
    end
  end

end


PlayState.new.show


