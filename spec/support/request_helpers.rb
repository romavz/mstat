# frozen_string_literal: true

module RequestHelpers
  module JsonHelpers
    def json
      @json ||= JSON.parse(response.body)
    end
  end
end
