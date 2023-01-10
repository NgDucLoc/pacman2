require 'gosu'

def media_path(file)
  File.join(File.dirname(__FILE__), 'Images', file)
end

$walls = []
for i in 0..20
    if (i<10)
        $pathwall="0" + i.to_s + ".png"
    else 
        $pathwall=i.to_s + ".png"
    end
    puts $pathwall
    $walls[i] = media_path(@pathwall)
end



class Wall
    def initialize(x, y , h , w , axis)
        @x=x
        @y=y
        @height = h
        @width = w
        @img = walls[axis]
        if axis <21
            @through = false
        else 
            @through = true
        end
        @image = Gosu::Image.new(@img , options = {:rect => [0, 0, @height, @width]} )
    end
    
    def draw
    @image.draw(@x,@y,0)
    end


$wallsdoc = []
lines = IO.readlines("inputWall.txt")
c = 0
lines.each do |i|
    splited = i.split(" ")
    $wallsdoc.push(splited)
end
$walls = []
for i in 0..$walls.length-1
    row =  $walls[i]
    for j in 0..row.length-1
        $walls[t] =Wall.new(48*i,48*j, 48, 48, $wallsdoc[i][j]) 
    end
end


c = 0
while c < $walls.size
    $walls[c].draw
    c += 1
end

Window.new.show
