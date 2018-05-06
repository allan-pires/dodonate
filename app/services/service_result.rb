class ServiceResult
  attr_reader :obj, :success

  def initialize(obj, success)
    @obj = obj
    @success = success
  end

  def success?
    @success
  end
  
end