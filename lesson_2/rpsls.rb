=begin
PEDAC process for Bonus Features for RPSLS

#understand the problem
Add in lizard and spock as follows:
  -scissors > paper
  -scissors > lizard
  -rock > scissors
  -rock > lizard
  -paper > spock
  -paper > rock
  -lizard > spock
  -lizard > paper
  -spock > scissors
  -spock > rock

Update RPS so user can type
    r for rock
    p for paper
    sc for scissors
    sp for spock
    l for lizard

Keep score of the player's and computer's wins and
when player or computer reaches 5, match ends,
winning player becomes grand winner.
(Incrementing logic should be in a separate method)

#test cases
player choice + computer choice results in correct winner for each case
r -> rock, p -> paper and so on
test when ending game: y, n, sure, yada, 0, "", " "

#inputs, outputs, and data structures
inputs: user strings for choices
outputs: display message in strings
data structures: hash that hold's player moves as keys with
  list of moves that that key beats as values, e.g. lizard => spock, paper

#describe algorithm
  take user input (allowing for abbreviations)
  assign computer a random choices
  test user choice against random choice by looking up in the hash,
  if user choice (key) has a value that matches computer choice, that person wins
  else, test computer choice against user choice
  declare winner or tie & increment winner +1
  play again (y/n)
  once winner = 5, end game

=end


VALID_CHOICES = %w(rock r paper p scissors sc spock sp lizard l)

WINNING_MOVES = { 
  "rock" => ['scissors', 'lizard',],
  "scissors" => ['paper', 'lizard'],
  "paper" => ['rock', 'spock'],
  "lizard" => ['spock', 'paper'],
  "spock" => ['rock', 'scissors'],
}

ABBREVIATIONS = {
  "r" => 'rock',
  "p" => 'paper',
  "sc" => 'scissors',
  "sp" => 'spock',
  "l" => 'lizard'
}

WINNING_SCORE = 5

player_points = 0
computer_points = 0

def prompt(message)
  Kernel.puts("=> #{message}")
end

def win?(first, second)
  WINNING_MOVES[first].include?(second)
end

def display_results(player, computer)
  if win?(player, computer)
    prompt("You won!")
  elsif win?(computer, player)
    prompt("Computer won!")
  else
    prompt("It's a tie!")
  end
end


def countwin(user, machine)
  if win?(user, machine)
    player += 1
  elsif win?(machine, user)
    computer += 1
  else
    player += 0
    computer += 0
  end
end

def declarewinner(winner)
  if winner == "You"
    prompt("You are the grand winner!")
  else 
    prompt("Computer is the grand winner!")
  end
end

loop do
  choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    choice = Kernel.gets().chomp()

    if VALID_CHOICES.include?(choice)
      break
    else
      prompt("That's not a valid choice.")
    end
  end

  computer_choice = VALID_CHOICES.sample
  choice = ABBREVIATIONS[choice] if ABBREVIATIONS[choice]
  computer_choice = ABBREVIATIONS[computer_choice] if ABBREVIATIONS[computer_choice]
  
  prompt("You chose: #{choice}; Computer chose: #{computer_choice}")

  display_results(choice, computer_choice)
 
  if win?(choice, computer_choice)
    player_points += 1
  elsif win?(computer_choice, choice)
    computer_points += 1
  end
  prompt("Your score: #{player_points}. Computer's score: #{computer_points}.")
  
  break if (player_points == 5 || computer_points == 5)
  
  prompt("Do you want to play again?")
  answer = Kernel.gets.chomp
  break unless answer.downcase.start_with?('y')
  system('clear') || system('cls')
end

declarewinner("You") if player_points == WINNING_SCORE
declarewinner("Computer") if computer_points == WINNING_SCORE

prompt("Thank you for playing. Good bye!")