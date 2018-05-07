class CRUDService

  private

  OPERATION_SUCCESSFUL = true
  OPERATION_FAILED = false

  def self.create(target_class, attributes)
    obj = target_class.new(attributes)
    
    return ServiceResult.new(obj, OPERATION_SUCCESSFUL) if obj.save
    ServiceResult.new(obj, OPERATION_FAILED)
  end

  def self.update(obj, new_attributes)
    return ServiceResult.new(obj, OPERATION_SUCCESSFUL) if obj.update_attributes(new_attributes)
    ServiceResult.new(obj, OPERATION_FAILED)
  end

  def self.delete(model)
    return ServiceResult.new({message: "Successfully deleted!"}, OPERATION_SUCCESSFUL) if model.destroy
    ServiceResult.new(model, OPERATION_FAILED)
  end

end