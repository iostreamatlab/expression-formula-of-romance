module HashOptionParsing
  def required_key(key, error_message = nil)
    fetch(key) do |k|
      raise ArgumentError, (error_message || "Required argument not given: #{key}")
    end
  end

  def required_keys(*keys)
    keys.inject([]) {|vals,k| vals.push(required_key(k)) }
  end

  def required_key!(key, error_message = nil)
    unless has_key?(key)
      raise ArgumentError, (error_message || "Required argument not given: #{key}")
    end
    delete(key)
  end

  def assert_required_keys(*required_keys) 
    missing_keys = [required_keys].flatten - keys 
    raise(ArgumentError, "Missing required key(s): #{missing_keys.join(", ")}") unless missing_keys.empty? 
  end 

  def assert_only_keys(*only_keys)
    assert_required_keys(*only_keys)
    unless only_keys.length == self.length
      begin 
        assert_valid_keys(*only_keys)
      rescue NoMethodError # testing problem
        raise ArgumentError, "expected only arguments for #{only_keys.join(' and ')}"
      end
    end
  end
end

class Hash
  include HashOptionParsing

  # a better Hash#dup - values are duped
  # don't bother duping keys, especially since Symbols are used as keys
  # Symbols can't be duped
  # check against the default value
  # - makes the implementation more general
  # - avoids trying to dup nil in the common case (nil can't be duped)
  def dup_values(&default_proc)
    inject(Hash.new(&default_proc)) do |hash, k_v|
      k, v = k_v
      hash[k] = v == default ? hash.default : v.dup
      hash
    end
  end
end

# dup_values on the incoming hash
# accesing with bracket notation will ALWAYS return an Array
class HashOfArrays
  include HashOptionParsing

  VALID_HASH_METHODS = [:fetch, :keys, :dup, :dup_values]

  def initialize(hash, &default_block)
    default_block ||= proc { Array.new }
    @hash = hash.dup_values(&default_block)
  end

  def [](key)
    value = @hash.fetch(key, [])
    v = if value.kind_of?(Array) then value
        else [value]
        end
    @hash[key] = v
  end

  def method_missing(method, *args, &block)
    if VALID_HASH_METHODS.include?(method)
      @hash.send(method, *args, &block)
    else
      super(method, *args, &block)
    end
  end
end


#元编程实现RUBY_HASH
#参数 ［黑心指数，派系］
#派系      1.科卫 2.专利中心 3.其他
#黑心指数         1.暴利 2.一般 3.良心(发明：3260) 4.未知
#实力  range(1..10)

huayi = HashOfArrays.new(:name => 'huayi', :arr => [1,3] , :power => 5)
wuwei = HashOfArrays.new(:name => 'wuwei', :arr => [2,4] , :power => 5)
jinke = HashOfArrays.new(:name => 'jinke', :arr => [1,1] , :power => 3)
kewei = HashOfArrays.new(:name => 'kewei', :arr => [1,1] , :power => 7)
gaoxin = HashOfArrays.new(:name => 'gaoxin', :arr => [3,1] ,:power => 5)

puts "愚蠢的发明人，让我们看看你的运气……"
zhuanlilist=[huayi,wuwei,jinke,kewei,gaoxin]
random=rand(0..4)
p zhuanlilist[random]


