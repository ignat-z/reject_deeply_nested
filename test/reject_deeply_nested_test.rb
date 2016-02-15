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
    assert ::RejectDeeplyNested::BLANK.call(deep_hash_witout_values)
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
    refute ::RejectDeeplyNested::BLANK.call(deep_hash_with_value)
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
    assert ::RejectDeeplyNested::BLANK.call(deep_hash_with_value)
  end

  def test_smart_blank_which_can_ignore_passed_values
    deep_hash_with_value = {
      a: '',
      b: '',
      c: { d: '', e: '' },
      f: { g: '', h: { j: '' } },
      k: { l: '', m: { n: { iddqd_id: "some_passed_value" } } },
      p: { q: '', r: '', s: { t: { u: { w: '' } } } }
    }
    assert ::RejectDeeplyNested::SMART_BLANK.curry.([/_id$/]).call(deep_hash_with_value)
  end

  def test_smart_blank_which_can_ignore_passed_values_but_not_forget_about_destroy_key
    deep_hash_with_value = {
      a: '',
      b: '',
      c: { d: '', e: '' },
      f: { g: '', h: { j: '' } },
      k: { l: '', m: { n: { iddqd_id: "some_passed_value" } } },
      p: { q: '', r: '', s: { t: { u: { "_destroy" => '' } } } }
    }
    assert ::RejectDeeplyNested::SMART_BLANK.curry.([/_id$/]).call(deep_hash_with_value)
  end

  def test_smart_blank_which_return_false_for_hash_with_non_ignored_value
    deep_hash_with_value = {
      a: '',
      b: '',
      c: { d: '', e: '' },
      f: { g: '', h: { j: '' } },
      k: { l: '', m: { n: { iddqd_id: "some_passed_value" } } },
      p: { q: '', r: '', s: { t: { u: { "_destroy" => '' } } } }
    }
    refute ::RejectDeeplyNested::SMART_BLANK.curry.([]).call(deep_hash_with_value)
  end

  def test_for_all_present_in_attributes
    fields = ['a', 'b', 'c']
    attributes = { 'a' => 1, 'b' => 2, 'c' => 3 }

    refute ::RejectDeeplyNested::ANY_MISSED.curry.(fields).call(attributes)
  end

  def test_for_any_missed_in_attributes
    fields = ['a', 'b', 'c']
    attributes = { 'a' => 1, 'b' => 2, 'c' => nil }

    assert ::RejectDeeplyNested::ANY_MISSED.curry.(fields).call(attributes)
  end
end









