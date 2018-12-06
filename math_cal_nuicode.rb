require 'math_calculator'
require 'unicode_math'


str = "x+y+7326+35"
options = {:x => 2, :y => 4}
p MathCalculator.calculate(str, options)

p 1.617 * 10.ⁿ(13)

p 1.617 * 10.ⁿ(13)+MathCalculator.calculate(str, options)

p (Σ (1..4))+1.617 * 10.ⁿ(13)+MathCalculator.calculate(str, options)

p 10.! + (Σ (1..4))+1.617 * 10.ⁿ(13)+MathCalculator.calculate(str, options)

p 30 + ½ + 10.! + (Σ (1..4))+1.617 * 10.ⁿ(13)+MathCalculator.calculate(str, options)

