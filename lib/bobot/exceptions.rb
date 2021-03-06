module Bobot
  # Base Facebook Messenger exception.
  class Error < ::StandardError; end

  class FieldFormat < ::ArgumentError
    def initialize(description, value = nil)
      super("#{description}#{value.present? ? " : #{value}'" : ''}")
    end
  end

  # Forbidden Action exception
  class ActionNotAllowed < Bobot::Error; end

  # Base error class for Facebook API errors.
  class FacebookError < Bobot::Error
    attr_reader :message
    attr_reader :type
    attr_reader :code
    attr_reader :subcode
    attr_reader :user_title
    attr_reader :user_msg
    attr_reader :fbtrace_id
    attr_reader :extras

    def initialize(error)
      @message = error['message']
      @type = error['type']
      @code = error['code']
      @subcode = error['error_subcode']
      @user_title = error['error_user_title']
      @user_msg = error['error_user_msg']
      @fbtrace_id = error['fbtrace_id']
      @extras = error['extras']
    end

    def to_s
      message
    end
  end

  # Base Facebook Messenger send API exception.
  class SendError < Bobot::FacebookError; end

  class AccessTokenError < Bobot::SendError; end
  class AccountLinkingError < Bobot::SendError; end
  class BadParameterError < Bobot::SendError; end
  class InternalError < Bobot::SendError; end
  class LimitError < Bobot::SendError; end
  class PermissionError < Bobot::SendError; end

  # Base Facebook Messenger exception.
  class NetworkError < ::StandardError
    attr_reader :response
    attr_reader :description

    def initialize(response, description)
      @response = response
      @description = description
    end

    def message
      description
    end

    def to_s
      message
    end
  end
end
