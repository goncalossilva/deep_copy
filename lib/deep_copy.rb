require 'active_record'

module DeepCopy
  def deep_copy(options={})
    kopy = clone
    
    if options[:except]
      Array(options[:except]).each do |attribute|
        kopy.write_attribute(attribute, attributes_from_column_definition[attribute.to_s])
      end
    end
    
    if options[:include]
      Array(options[:include]).each do |association, deep_associations|
        if (association.kind_of? Hash)
          deep_associations = association[association.keys.first]
          association = association.keys.first
        end
        opts = deep_associations.blank? ? {} : {:include => deep_associations}
        
        association_reflection = self.class.reflect_on_association(association)
        cloned_object = case association_reflection.macro
                        when :belongs_to, :has_one
                          self.send(association) && self.send(association).deep_clone(opts)
                        when :has_many, :has_and_belongs_to_many
                          fk = association_reflection.options[:foreign_key] || self.class.to_s.underscore
                          self.send(association).collect { |obj| tmp = obj.clone(opts)
                                                            tmp.send("#{fk}=", kopy)
                                                            tmp    
                                                          }
                        end
        kopy.send("#{association}=", cloned_object)
      end
    end

    return kopy
  end
end

ActiveRecord::Base.extend DeepCopy
