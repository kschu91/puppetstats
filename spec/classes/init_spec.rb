require 'spec_helper'
describe 'puppetstats' do
  context 'with default values for all parameters' do
    it {
      stub_request(:post, 'https://puppetstats.com/api/modules/puppetstats').
          to_return(status: 200, body: '', headers: {})
      is_expected.to contain_class('puppetstats')
    }
  end
  context 'with enabled to false' do
    let(:params) {{'enabled' => false}}
    it {
      expect(a_request(:post, 'https://puppetstats.com/api/modules/puppetstats')).not_to have_been_made
      is_expected.to contain_class('puppetstats')
    }
  end
  context 'with fact puppetstats_disabled' do
    let(:facts) {{:puppetstats_disabled => true}}
    it {
      expect(a_request(:post, 'https://puppetstats.com/api/modules/puppetstats')).not_to have_been_made
      is_expected.to contain_class('puppetstats')
    }
  end
end
