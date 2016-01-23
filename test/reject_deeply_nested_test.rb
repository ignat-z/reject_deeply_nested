require 'test_helper'

class RejectDeeplyNestedTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::RejectDeeplyNested::VERSION
  end

  def test_return_true_for_nested_hash_without_any_blank_value
    deep_hash_witout_values = {
      a: '',
      b: '',
      c: { d: '', e: '' },
      f: { g: '', h: { j: '' } },
      k: { l: '', m: { n: { o: '' } } },
      p: { q: '', r: '', s: { t: { u: { w: '' } } } }
    }
    assert ::RejectDeeplyNested::DeeplyNested.deep_blank?(deep_hash_witout_values)
  end

  def test_return_false_for_nested_hash_with_at_least_one_non_blank_value
    deep_hash_with_value = {
      a: '',
      b: '',
      c: { d: '', e: '' },
      f: { g: '', h: { j: '' } },
      k: { l: '', m: { n: { o: "some_passed_value" } } },
      p: { q: '', r: '', s: { t: { u: { w: '' } } } }
    }
    refute ::RejectDeeplyNested::DeeplyNested.deep_blank?(deep_hash_with_value)
  end

  def test_ignore_value_if_key_equals_destroy
    deep_hash_with_value = {
      a: '',
      b: '',
      c: { d: '', e: '' },
      f: { g: '', h: { j: '' } },
      k: { l: '', m: { n: { '_destroy' => "some_passed_value" } } },
      p: { q: '', r: '', s: { t: { u: { w: '' } } } }
    }
    assert ::RejectDeeplyNested::DeeplyNested.deep_blank?(deep_hash_with_value)
  end
end












# describe DeeplyNested do
#   subject { DeeplyNested::BLANK }

#   let(:deep_hash_witout_values) do
#     {
#       a: '',
#       b: '',
#       c: { d: '', e: '' },
#       f: { g: '', h: { j: '' } },
#       k: { l: '', m: { n: { o: '' } } },
#       p: { q: '', r: '', s: { t: { u: { w: '' } } } }
#     }
#   end

#   let(:deep_hash_with_value) do
#     {
#       a: '',
#       b: '',
#       c: { d: '', e: '' },
#       f: { g: '', h: { j: '' } },
#       k: { l: '', m: { n: { o: "some_passed_value" } } },
#       p: { q: '', r: '', s: { t: { u: { w: '' } } } }
#     }
#   end

#   it "return false if on even one level of nested hash filled value" do
#     expect(subject.call(deep_hash_with_value)).to be false
#   end

#   it "return true if all levels of nested hash are blank" do
#     expect(subject.call(deep_hash_witout_values)).to be true
#   end
# end
