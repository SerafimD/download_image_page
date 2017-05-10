module Banking
  class CalculationDebt
    def initialize(amount, days, percent_day, payment)
      @amount      = amount
      @days        = days
      @percent_day = percent_day
      @payment     = payment
    end

    def execute
      redemption = []
      @days.times do
        @amount += @amount * @percent_day / 100
      end
      puts "общая сумма долга = #{@amount}"
      puts "сумма частичного погашения = #{@amount / @payment}"
      paid = @amount / @payment
      leftover = @amount % @payment
      @payment.times do |p|
        redemption << {
          payment: p+1,
          paid: paid
        }
      end
      redemption.last[:paid] = redemption.last[:paid] + leftover
      pp redemption
    end

  end
end
