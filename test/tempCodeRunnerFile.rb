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