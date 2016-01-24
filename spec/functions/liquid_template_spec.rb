require 'spec_helper'

describe 'liquid_template' do
  ############### Test normal usage

  describe 'when a single template is specified' do
    it 'should return the contents of the given template' do
      should run.with_params('single_expansion/hello.liquid').and_return(/^Hello WORLD/)
    end
  end

  ############### Test error conditions

  describe 'handling expected error conditions' do
    it 'should throw Puppet::ParseError if called with no templates' do
      should run.with_params.and_raise_error(Puppet::ParseError)
    end
  end
end
