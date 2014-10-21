require 'test_helper'
require 'minitest/autorun'

class TestChangeConnectionParams  < MiniTest::Test
  def test_config
    @model = DummyModel.new({  
                             :adapter  => :sqlserver,
                             :mode     => :dblib,
                             :username => "sa",
                             :password => "cheese",
                             :database => "db_name",
                             :host     => "primary_server",
                             :mirror   => {
                               :host     => "mirror_server",
                               :port     => 1434,
                               :password => "mouse"
                             }
                           })    
    
    @model.send(:switch_to_mirror)
    assert_mirror
    @model.send(:switch_to_mirror)
    assert_primary
  end  

  def test_config_with_string_keys
    @model = DummyModel.new({  
                             'adapter' => :sqlserver,
                             'mode'    => :dblib,
                             'username'=> "sa",
                             'password'=> "cheese",
                             'database'=> "db_name",
                             'host'    => "primary_server",
                             'mirror'  => {
                               'host'    => "mirror_server",
                               'port'    => 1434,
                               'password'=> "mouse"
                             }
                           })    
    
    @model.send(:switch_to_mirror)
    assert_mirror
    @model.send(:switch_to_mirror)
    assert_primary
  end  

  private
  
  def assert_primary
    assert_equal "primary_server" , value_for(:host)
    assert_nil   value_for(:port)
    assert_equal "cheese"         , value_for(:password)
    assert_common
  end

  def assert_mirror
    assert_equal "mirror_server" , value_for(:host)
    assert_equal 1434            , value_for(:port)
    assert_equal "mouse"         , value_for(:password)
    assert_common
  end

  def assert_common
    assert_equal :sqlserver      , value_for(:adapter)
    assert_equal :dblib          , value_for(:mode)
    assert_equal "sa"            , value_for(:username)
    assert_equal "db_name"       , value_for(:database)
  end

  def value_for(key)
    @model.connection_options[key] || @model.connection_options[key.to_s]
  end
end
