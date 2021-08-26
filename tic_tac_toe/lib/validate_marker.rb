# frozen_string_literal: true

##
# Module for validating whether a marker is a String of length 1
# and not any off-limits characters.
module ValidateMarker
  OFF_LIMIT_CHARS = ['[', ']', "\t", "\n", '_'].freeze

  ##
  # Raises a +ValueError+ if +marker+ is not a String of length 1
  # and not an invalid marker.
  def valid?(marker)
    unless (marker.is_a? String) && (marker.length == 1) && !OFF_LIMIT_CHARS.include?(marker)
      raise ValueError, 'fill_char must be of length 1 and not "_"'
    end

    true
  end
end
