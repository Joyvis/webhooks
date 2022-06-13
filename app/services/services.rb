# frozen_string_literal: true

# mixin to include common methods for the whole service layer
module Services
  def respond_success(response)
    response_object('SuccessServiceResponse').new(
      true,
      response
    )
  end

  def respond_fail(response)
    response_object('FailServiceResponse').new(
      false,
      response
    )
  end

  def response_object(kind)
    @response_object ||= Struct.new(kind, :success?, :result)
  end
end
