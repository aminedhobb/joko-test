require_relative 'formula_parser'

puts 'type your formula :'

input = gets.chomp

formula_parser = FormulaParser.new(input)

puts "The elements are :"
p formula_parser.results
