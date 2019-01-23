class FormulaParser

  attr_reader :formula, :results

  def initialize(input)
    @formula = input
    @results = {}
    remove_brackets
    remove_numbers
    count_two_letters_elements
    count_other_elements
  end

  private

  def remove_brackets
    non_delimiters = /[^(){}\[\]]*/
    pattern_with_index = /\(#{non_delimiters}\)\d+|\{#{non_delimiters}\}\d+|\[#{non_delimiters}\]\d+/
    pattern_without_index = /\(#{non_delimiters}\)|\{#{non_delimiters}\}|\[#{non_delimiters}\]/

    while @formula =~ pattern_with_index
      index = @formula.scan(pattern_with_index)[0].gsub(/\(\w+\)|\[\w+\]|\{\w+\}/, '').to_i
      replacement_string = ''
      index.times do
        replacement_string << @formula.scan(pattern_without_index)[0].gsub(/\(|\)|\[|\]|\{|\}/, '')
      end
      @formula.gsub!(pattern_with_index, replacement_string)
    end
  end

  def remove_numbers
    pattern = /[A-Z]\d+|[A-Z][a-z]\d+/
    scan = @formula.scan(pattern)
    scan.each do |element_with_index|
      index = element_with_index.gsub(/[A-Z][a-z]|[A-Z]/ , '').to_i
      elements = ''
      index.times do
        elements << element_with_index.gsub(/\d{1}/ , '')
      end
      @formula.gsub!(element_with_index, elements)
    end
  end

  def count_two_letters_elements
    scan = @formula.scan(/[A-Z][a-z]/)
    return if scan.empty?

    scan.each do |element|
      if @results[element.to_s].nil?
        @results[element.to_sym] = 1
      else
        @results[element.to_sym] += 1
      end
    end
    @formula.gsub!(/[A-Z][a-z]/, '')
  end

  def count_other_elements
    splitted_formula = @formula.split('')
    splitted_formula.each do |element|
      if @results[element.to_sym].nil?
        @results[element.to_sym] = 1
      else
        @results[element.to_sym] += 1
      end
    end
  end
end

