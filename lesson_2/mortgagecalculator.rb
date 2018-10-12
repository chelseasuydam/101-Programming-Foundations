=begin
Mortage Calculator - PEDAC
Need to introduce user to the calculator
ask the user for loan amount, APR, loan duration
verify these are valid numbers
convert strings to floats
calculate monthly interest rate and loan duration in months
Using formula, find mortgage payment by month

Test cases:
  user enters non-number
  user enters 0
    user enters negative numbers
user enters normal amounts

inputs: loan amount, APR, loan duration (numbers)
outputs: mortgage (number)

Algorithm for verifying numbers:
  ensure they are not negative
  ensure they are not equal to 0
  ensure they are indeed numbers

If number is not valid, ask user to input another (use loop)

Convert strings to numbers
Calculate monthly interest + loan duration in months with simple math
Use formula to finally calculate mortgage
Ask user if he/she wants to calculate another loan amount, or end the program

START

DEFINE num_is_valid

end

DEFINE prompt

end
WHILE in Calculator

  SET loan_amount, apr, loan_duration

  WHILE (loan_amount is invalid)
    GET loan_amount from user
  end

  WHILE (apr is invalid)
    GET apr from user
  end

  WHILE (loan_duration is invalid)
    GET loan_duration from user
  end

  loanduration_months = loan_duration*12

  monthly_interest = apr/12

  mortage = loan_amount *
            (monthly_interest /
            (1 - (1 + monthly_interest)**(-loanduration_months)))

  GET userinput on running again

end
=end

def prompt(message)
  puts "=> #{message}"
end

def valid?(num)
  return false if num.match(/-/) || num.empty?
  new_num = num.gsub(/[^0-9]/, '')
  new_num.to_f > 0
end

def validname?(name)
  !name.empty? && name.match(/[A-Za-z]/)
end

prompt "Welcome to the Mortgage Calculator! Please enter your name."

name = ''
loop do
  name = gets.chomp
  if !validname?(name)
    prompt("Please enter a valid name.")
  else
    break
  end
end

prompt "Welcome, #{name}!"

loop do
  loan_amount = ''
  apr = ''
  loan_duration = ''

  prompt "Please enter the loan amount"
  loop do
    loan_amount = gets.chomp
    if valid?(loan_amount)
      loan_amount = loan_amount.gsub(/[^0-9]/, '')
      break
    else
      prompt "Please enter a valid loan amount."
    end
  end

  prompt "Please enter the APR"
  loop do
    apr = gets.chomp
    if valid?(apr)
      break
    else
      prompt "Please enter a valid APR."
    end
  end

  prompt "Please enter the loan duration in years."
  loop do
    loan_duration = gets.chomp
    if valid?(loan_duration)
      break
    else
      prompt "Please enter a valid loan duration"
    end
  end

  months = loan_duration.to_i * 12
  annual_interest_rate = apr.to_f / 100
  monthly_interest_rate = annual_interest_rate / 12

  mortgage = loan_amount.to_f *
             (monthly_interest_rate /
             (1 - (1 + monthly_interest_rate)**-months.to_i))

  prompt "Your monthly mortgage payment is $" + format('%.2f', mortgage)
  prompt "Would you like to calculate the mortgage for another loan?"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end
