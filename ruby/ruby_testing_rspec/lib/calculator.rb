#lib/calculator.rb

class Calculator
  def add(a,b,c=nil)
    return a + b + c unless c.nil?
    a + b
  end

  def subtract(a,b)
    a - b
  end
end
