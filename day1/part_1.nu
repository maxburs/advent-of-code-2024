#!/opt/homebrew/bin/nu 

def read_input [file_name: string]: string -> table<col1: int, col2: int> {
  open $file_name
    | parse --regex '(?<col1>\d+)\s+(?<col2>\d+)'
    | into int col1 col2
}

# let input: table<col1: int, col2: int> = open ./day1/example.txt
#   | from ssv
#   | into int col1 col2
#   | each { |r| insert sum ($r.col1 + $r.col2) }

echo $env

def main [file_name] {
  print $file_name
  let input = read_input $file_name
  print $input
  let col1 = $input | select col1 | sort
  let col2 = $input | select col2 | sort
  let differences = $col1
    | merge $col2 
    | each { |r| insert difference (($r.col2 - $r.col1) | math abs) }
    | get difference
  print $differences
  $differences
    | reduce --fold 0 { |it, acc| $it + $acc }
}

# let example = read_input 'example.txt'

# let input = read_input 'input.txt'

# echo $example

# let test = 	[[x, y]; [12, 15], [8, 9]]


# | reduce --fold 0 { |r, acc| $acc + $r.sum }
