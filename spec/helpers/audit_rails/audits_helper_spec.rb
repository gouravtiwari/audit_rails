require 'spec_helper'

describe AuditRails::AuditsHelper do
  context 'active_class' do
    it 'should return "active" when current action is "analytics"' do
      controller.should_receive(:action_name).and_return('analytics')

      helper.active_class('analytics').should eq('active')
    end
  end
end
