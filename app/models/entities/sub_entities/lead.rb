class Entities::SubEntities::Lead < Maestrano::Connector::Rails::SubEntityBase

  def self.external?
    true
  end

  def self.entity_name
    'Lead'
  end

  def self.mapper_classes
    {
      'Person' => Entities::SubEntities::PersonMapper,
      'Organization' => Entities::SubEntities::OrganizationMapper
    }
  end

  def self.references
    {
      'Person' => Entities::SubEntities::PersonMapper.person_references,
      'Organization' => Entities::SubEntities::OrganizationMapper.organization_references
    }
  end

  def self.object_name_from_external_entity_hash(entity)
    if entity['last_name']
      "#{entity['first_name']} #{entity['last_name']}"
    else
      entity['organization_name']
    end
  end
end
