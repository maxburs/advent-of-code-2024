#!/opt/homebrew/bin/nu 

def read_input [file_name: string]: nothing -> table<col1: int, col2: int> {
  open $file_name
    | parse --regex '(?<col1>\d+)\s+(?<col2>\d+)'
    | into int col1 col2
}

def main [file_name] {
  print $file_name
  let input = read_input $file_name;
  print $input
  let col1: table<col1: int> = $input | select col1 | sort
  let col2: table<col2: int> = $input | select col2 | sort
  let nums = $col1 | each { |v| ($col2 | where col2 == $v.col1 | length) * $v.col1 }
  print $nums
  # $nums | reduce --fold 0 { |it, acc| $it + $acc }
  # $differences
  #   | reduce --fold 0 { |it, acc| $it + $acc }
  $nums | math sum
}
