class Entities::SubEntities::OrganizationMapper
  extend HashMapper

  def self.organization_references
    {
      record_references: %w(assignee_id),
    }
  end

  after_denormalize do |input, output|
    if input['organization_name']
      output[:name] = input['organization_name']
      output[:is_lead] = true
      output[:is_customer] = false
    else
      output[:name] = input['name']
    end
    output
  end

  after_normalize do |input, output|
    if input['is_lead']
      output[:organization_name] = input['name']
    else
      output[:is_organization] = true
      output[:name] = input['name']
      # Base CRM does not provide 2 fields for landlines
      output[:mobile] ||= input['phone']['landline2'] if input['phone']['landline2']
    end

    output
  end

  map from('industry'), to('industry')
  map from('email/address'), to('email')

  map from('contact_channel/skype'), to('skype')
  map from('phone/landline'), to('phone')
  map from('phone/mobile'), to('mobile')
  map from('phone/fax'), to('fax')

  map from('assignee_id'), to('owner_id', &:to_i)

  map from('address/billing/line1'), to('address/line1')
  map from('address/billing/city'), to('address/city')
  map from('address/billing/postal_code'), to('address/postal_code')
  map from('address/billing/region'), to('address/state')
  map from('address/billing/country'), to('address/country')

  map from('website/url'), to('website')
end
