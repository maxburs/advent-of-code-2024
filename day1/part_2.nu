#!/opt/homebrew/bin/nu 

def read_input [file_name: string]: string -> table<col1: int, col2: int> {
  open $file_name
    | parse --regex '(?<col1>\d+)\s+(?<col2>\d+)'
    | into int col1 col2
}

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
