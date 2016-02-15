require "reject_deeply_nested/version"
require "active_support/core_ext/object/blank"

module RejectDeeplyNested
  DEFAULT_IGNORE_VALUES = [/_destroy/]

  BLANK = proc { |attributes| deep_blank?(attributes) }
  SMART_BLANK = proc do |ignore_values, attributes|
    deep_blank?(attributes, Array(ignore_values) + DEFAULT_IGNORE_VALUES)
  end
  ANY_MISSED = proc do |fields, attributes|
    fields.any? { |field| attributes[field].blank? }
  end

  def self.any_missed?(fields)
    ANY_MISSED.curry.(fields)
  end

  def self.blank?(ignore_values = [])
    SMART_BLANK.curry.(ignore_values)
  end

  private

  # Recursively traverse nested attributes to define is all values blank.
  # Additionaly considers that value with _destroy key is always blank.
  def self.deep_blank?(hash, ignore_values = DEFAULT_IGNORE_VALUES)
    hash.each do |key, value|
      next if ignore_values.any? { |ignore_value| key =~ ignore_value }
      any_blank = value.is_a?(Hash) ? deep_blank?(value, ignore_values) : value.blank?
      return false unless any_blank
    end
    true
  end
end


