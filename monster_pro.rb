class Monster
  MSGS = {
    :dance => 'is dancing',
    :poo => 'is a smelly doggy!',
    :laugh => 'finds this hilarious!',
    :program => 'is programing,like ruby.'
  }

  def initialize(name)
    @name = name
  end

  def can(*args, &block)
    meta = class << self; self; end
    meta.class_eval do
      args.each do |arg|
        define_method(arg) { "#{@name} #{MSGS[arg]}" }
      end
    end
  end
  
  #ghost method
  #幽灵方法
  def method_missing(sym)
  # "#{@name} doesn't understand #{sym}"
    random=rand(1..1000)
    "#{random} is the #{@name}'s luck number."
  end
end


p @fido= Monster.new("Spring")
p @fido.pro

      

