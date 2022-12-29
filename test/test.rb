$walls = []
lines = IO.readlines("inputWall.txt")
c = 0
lines.each do |i|
    splited = i.split(" ")
    $walls.push(splited)
end
for i in 0..$walls.length-1
    row =  $walls[i]
    for j in 0..row.length-1
        puts $walls[i][j]
    end
end
