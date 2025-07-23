record = {}

p record[1] = {}

p record

# p record[1] = {1 => {'Bob' => 'rock', 'R2D2' => 'paper'}}
p record[1][1] = {'Bob' => 'paper', 'R2D2' => 'lizard'}

p record
# => {1=>{1=>{"Bob"=>"rock", "R2D2"=>"paper"}}}

# p record[1] = {2 => {'Bob' => 'paper', 'R2D2' => 'lizard'}}
p record[1][2] = {'Bob' => 'paper', 'R2D2' => 'lizard'}

p record
# => {1=>{2=>{"Bob"=>"paper", "R2D2"=>"lizard"}}}

p record.last
