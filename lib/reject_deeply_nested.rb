require "reject_deeply_nested/version"
require "active_support/core_ext/object/blank"

module RejectDeeplyNested
  class DeeplyNested
    BLANK = proc { |attributes| deep_blank?(attributes) }

    # Recursively traverse nested attributes to define is all values blank.
    # Additionaly considers that value with _destroy key is always blank.
    def self.deep_blank?(hash)
      hash.each do |key, value|
        next if key == '_destroy'
        any_blank = value.is_a?(Hash) ? deep_blank?(value) : value.blank?
        return false unless any_blank
      end
      true
    end
  end
end
