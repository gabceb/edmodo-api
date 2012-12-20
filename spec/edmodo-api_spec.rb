# -*- encoding: utf-8 -*-

require File.join(File.dirname(__FILE__), "/spec_helper")

describe Edmodo::API::Client do
  describe 'Initialization' do
    it 'should accept an api key in the constructor' do
      Edmodo::API::Client.new('1234567890abcdefghijkl').api_key.should == '1234567890abcdefghijkl'
    end

    it "should be initialized with sandbox mode by default" do
      Edmodo::API::Client.new('1234567890abcdefghijkl' ).mode.should == :sandbox
    end

    it "should be initialized with production mode if passed to the initialize method" do
      Edmodo::API::Client.new('1234567890abcdefghijkl', mode: :production).mode.should == :production
    end

    it "should be initialized with sandbox mode if passed to the initialize method" do
      Edmodo::API::Client.new('1234567890abcdefghijkl', mode: :sandbox).mode.should == :sandbox
    end

    it "should throw an exception if an unkown mode is passed to the initialize method" do
      expect { Edmodo::API::Client.new('1234567890abcdefghijkl', mode: :mymode) }.to raise_error
    end
  end

  describe 'Config' do
    it 'should have a version on the config' do
      Edmodo::API::Config.version.should_not be_empty
    end

    it 'should have a production endopoint' do
      Edmodo::API::Config.endpoint[:production].should_not be_empty
    end

    it 'should have a sandbox endpoint' do
      Edmodo::API::Config.endpoint[:sandbox].should_not be_empty
    end
  end

end