require 'spec_helper'

describe Entities::SubEntities::Organization do

  context 'Class Methods' do
    subject { Entities::SubEntities::Organization }

    it { expect(subject.entity_name).to eql('Organization') }
    it { expect(subject.external?).to eql(false) }
    it { expect(subject.mapper_classes).to eql({"Contact" => Entities::SubEntities::OrganizationMapper, "Lead" => Entities::SubEntities::OrganizationMapper}) }
    it { expect(subject.object_name_from_connec_entity_hash({'name' => 'A Company', 'industry' => 'ITC'})).to eql('A Company') }
  end

  context 'Instance Methods' do

    let(:organization) { create(:organization)}
    subject { Entities::SubEntities::Organization.new(organization, nil, nil)}

    describe '#map_to base Contact' do
      let(:connec_hash) {
        {
          'name' => "Test Company",
          'industry' => "ITC",
          'email' => {
            'address' => "test@test.com"
          },
          'website' => {
            'url' => "http://test.com"
          },
          'phone' => {
            'landline' => "0208 777 444 56",
            'landline2' => "0208 777 444 22"
          },
          'address' => {
            'billing' => {
              'city' => 'London',
              'line1' => '37 Kinderton Gardens',
              'region' => 'Greater London',
              'postal_code' => 'T1 T23',
              'country' => "United Kingdom"
            }
          }
        }
      }

      let(:mapped_connec_hash) {
        {
          :name => 'Test Company',
          :industry => 'ITC',
          :email => "test@test.com",
          :website => "http://test.com",
          :is_organization => true,
          :mobile => "0208 777 444 22",
          :phone => "0208 777 444 56",
          :address => {
            :line1 => '37 Kinderton Gardens',
            :city => 'London',
            :postal_code => 'T1 T23',
            :state => 'Greater London',
            :country => 'United Kingdom'
          }
          }.with_indifferent_access
        }

      it { expect(subject.map_to('Contact', connec_hash)).to eql(mapped_connec_hash) }

      context 'when mobile phone is present, it is not overridden' do

        let(:connec_hash_with_mobile) { connec_hash.merge({'phone' => {'mobile' => '123456', 'landline' => '0208 777 444 56'}})}

        it { expect(subject.map_to('Contact', connec_hash_with_mobile)).to eql(mapped_connec_hash.merge({mobile: '123456'})) }
      end
    end
  end
end
