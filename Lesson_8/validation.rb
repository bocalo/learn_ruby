# frozen_string_literal: true

module Validation
  def valid?
    validate!
  rescue StandardError
    false
  end
end
