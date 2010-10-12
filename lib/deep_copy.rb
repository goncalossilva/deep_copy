require 'active_record'

module DeepCopy
  def deep_copy(options={})
    kopy = clone
    
    exceptions = options[:except]
    inclusions = options[:include]
    
    if exceptions
      Array(exceptions).each do |attribute|
        kopy.write_attribute(attribute, attributes_from_column_definition[attribute.to_s])
        #exceptions.delete(attribute) if exceptions.is_a?(Array)
      end
    end
    
    if inclusions
      Array(inclusions).each do |association, deep_associations|
        if(association.is_a?(Hash))
          deep_associations = association[association.keys.first]
          association = association.keys.first
        end
        association = association.to_sym
        
        deeper_exceptions = if exceptions.is_a?(Hash)
          exceptions[association]
        elsif exceptions.is_a?(Array)
          data = exceptions.find { |el| el.keys.first.to_sym == association if el.is_a?(Hash)}
          data.nil? ? {} : data[association]
        end
        
        opts = deep_associations.blank? ? {} : {:include => deep_associations}
        opts.merge!(:except => deeper_exceptions) unless deeper_exceptions.blank?
        
        association_reflection = self.class.reflect_on_association(association)
        next if association_reflection.nil? # invalid association
        
        cloned_object = case association_reflection.macro
                        when :belongs_to, :has_one
                          self.send(association) && self.send(association).deep_copy(opts)
                        when :has_many, :has_and_belongs_to_many
                          fk = association_reflection.options[:foreign_key] || self.class.to_s.underscore
                          self.send(association).collect { |obj| tmp = obj.deep_copy(opts)
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

ActiveRecord::Base.send :include, DeepCopy
