require 'gosu'
SIZE = 35
def media_path(file)
  File.join(File.dirname(__FILE__), 'Images', file)
end
  

puts ['0' ,1.to_s ,'2'].join()

$walls_file = []
for i in 0..20
    if (i<10)
        $pathwall= ["0", i.to_s ,".png"].join()
    else 
        $pathwall=[i.to_s , ".png"].join()
    end
    puts $pathwall
    $walls_file[i] = media_path($pathwall.to_s)
end

puts $walls_file[2]

class Wall
    def initialize(x, y , h , w , axis)
        @x=x
        @y=y
        @height = h
        @width = w
        @img = $walls_file[axis]
        if axis <21
            @through = false
        else 
            @through = true
        end
        @image = Gosu::Image.new(@img , options = {:rect => [0, 0, @height, @width]} )
    end
    
    def draw
        @image.draw(@y,@x,0)
    end
end


class Window < Gosu::Window
    def initialize
        super 1000, 933
        self.caption = "Pacman Game"
        #read wall text
        $wallsdoc = []
        lines = IO.readlines("inputWall.txt")
        c = 0
        lines.each do |i|
            splited = i.split(" ")
            $wallsdoc.push(splited)
        end
        $walls = []
        t=0
        for i in 0..$wallsdoc.length-1
            row =  $wallsdoc[i]
            puts row
            for j in 0..row.length-1
                puts j
                $walls[t] =Wall.new(SIZE*i,SIZE*j, SIZE, SIZE, $wallsdoc[i][j].to_i) 
                t=t+1
            end
        end
    end

    def draw
        c = 0
        while c < $walls.size
            $walls[c].draw
            c += 1
        end
    end
end
Window.new.show
