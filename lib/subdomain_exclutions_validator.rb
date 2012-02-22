class SubdomainExclutionsValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    if value == "www"
      object.errors[attribute] << (options[:message] || "is taken") 
    end
  end
end