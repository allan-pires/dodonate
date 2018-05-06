class CRUDService

  private

  def self.create(obj_class, attributes)
    obj = obj_class.new(attributes)
    if obj.save
      return ServiceResult.new(obj, true)
    end
    ServiceResult.new(obj, false)
  end

  def self.update(obj, new_attributes)
    if obj.update_attributes(new_attributes)
      ServiceResult.new(obj, true)
     return ServiceResult.new(obj, true)
    end
    ServiceResult.new(obj, false)
  end

  def self.delete(model)
    if model.destroy
      return ServiceResult.new({message: "Successfully deleted!"}, true)
    end  
    ServiceResult.new(model, false)
  end

end