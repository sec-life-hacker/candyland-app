# frozen_string_literal: true

require 'base64'
require 'rbnacl'

# Sign messages
class SignedMessage
  def self.setup(config)
    @signing_key = Base64.strict_decode64(config.SIGNING_KEY)
  end

  def self.sign(message)
    signature = RbNaCl::SigningKey.new(@signing_key)
      .sign(message.to_json)
      .then { |sig| Base64.strict_encode64(sig) }
    { data: message, signature: signature }
  end
end

