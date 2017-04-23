module Algorithm
  #
  # Класс реализующий функциональность для поиска пропущенных элементов в массиве
  #
  class Search

    def initialize(arr)
      @arr = arr
    end

    def find_missed
      counter = 1
      @arr.each_with_index do |value, index|
        if index != value - counter
          puts value-1
          counter += 1
        end
      end
    end

  end
end