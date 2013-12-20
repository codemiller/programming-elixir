defrecord Liquid, name: :nil, alcohol_pc: 0
# For use with Convert1
defrecord Beverage, name: :nil, content: {Liquid.new, 0} 
# For use with Convert2 and above
defrecord Drink, name: :nil, content: [{Liquid.new, 0}]
