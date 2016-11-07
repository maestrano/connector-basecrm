class Entities::SubEntities::Person < Maestrano::Connector::Rails::SubEntityBase
  def self.external?
    false
  end

  def self.entity_name
    'Person'
  end

  def self.mapper_classes
    {
      'Contact' => Entities::SubEntities::PersonMapper,
      'Lead' => Entities::SubEntities::PersonMapper
    }
  end

  def self.references
    {
      'Contact' => Entities::SubEntities::PersonMapper.person_references,
      'Lead' => Entities::SubEntities::PersonMapper.lead_references
    }
  end

  def self.object_name_from_connec_entity_hash(entity)
    "#{entity['first_name']} #{entity['last_name']}"
  end
end
