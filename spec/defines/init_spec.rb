require 'spec_helper'
describe 'puppetstats', :type => :define do
  context 'with default values for all parameters' do
    let(:title) { 'username-modulename' }
    it {
      stub_request(:post, 'https://puppetstats.com/api/modules/puppetstats').
          to_return(status: 200, body: '', headers: {})
      is_expected.to contain_puppetstats('username-modulename')
    }
  end
  context 'with enabled to false' do
    let(:title) { 'username-modulename' }
    let(:params) {{'enabled' => false}}
    it {
      expect(a_request(:post, 'https://puppetstats.com/api/modules/puppetstats')).not_to have_been_made
      is_expected.to contain_puppetstats('username-modulename')
    }
  end
  context 'with fact puppetstats_disabled' do
    let(:title) { 'username-modulename' }
    let(:facts) {{:puppetstats_disabled => true}}
    it {
      expect(a_request(:post, 'https://puppetstats.com/api/modules/puppetstats')).not_to have_been_made
      is_expected.to contain_puppetstats('username-modulename')
    }
  end
end
