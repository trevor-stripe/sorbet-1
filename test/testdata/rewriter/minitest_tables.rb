# typed: true

class A
  def foo; end
end
class B < A
end

class MyTest
  def outside_method
  end

  def self.test_each(arg, &blk); end
  def self.it(name, &blk); end

  test_each [A.new, B.new] do |value|
    it "works outside" do
      puts value.foo
      outside_method
    end
  end

  test_each [A.new, B.new] do |x|
    y = x # error: Only `it` blocks are allowed inside `test_each`
  end

  test_each [A.new, B.new] do |value|
    x = value.foo  # error: Only `it` blocks are allowed inside `test_each`
    it "fails with non-it statements" do
      puts x
    end
  end

  test_each ["foo", 5, {x: false}] do |v|
    it "handles lists with several types" do
      T.reveal_type(v) # error: Revealed type: `T.any(String, Integer, T::Hash[T.untyped, T.untyped])`
    end
  end
end
