class CRUDService

  private

  def self.create(obj_class, attributes)
    obj = obj_class.new(attributes)
    if obj.save
      ServiceResult.new(obj, true)
    else
      ServiceResult.new(obj, false)
    end
  end

  def self.update(obj, new_attributes)
    if obj.update_attributes(new_attributes)
      ServiceResult.new(obj, true)
    else
      ServiceResult.new(obj, false)
    end
  end

  def self.delete(model)
    if model.destroy
      ServiceResult.new({message: "Successfully deleted!"}, true)
    else
      ServiceResult.new(model, false)
    end
  end

end