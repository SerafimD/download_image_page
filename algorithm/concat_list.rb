module Algorithm
  #
  # Класс для склениваения двух списков без повторений
  #
  class ConcatList

    def initialize(lst1, lst2)
      @lst1 = lst1
      @lst2 = lst2
    end

    def concatenate
      result = @lst1
      @lst2.each { |elem| result << elem unless result.include? elem }
      result
    end

  end
end
