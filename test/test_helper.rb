require 'rubygems'
require 'test/unit'
require 'active_support'
require 'active_record'
require 'active_model'
require 'pp'

$:.unshift "#{File.dirname(__FILE__)}/../"
$:.unshift "#{File.dirname(__FILE__)}/../lib/"

require 'activerecord-sqlserver-adapter-mirroring.rb'

config = YAML.load(File.read(File.join(File.dirname(__FILE__), "database.yml")))['test']
#ActiveRecord::Base.establish_connection(config)

#define model
class Programmer < ActiveRecord::Base 
end                

Programmer.establish_connection(config)

def setup_db
  ActiveRecord::Schema.define do
    
    Programmer.connection.create_table :programmers, :force => true do |t|
      t.column :first_name, :string
      t.column :last_name, :string
    end
    
  end  
end     

def db_failover
  Programmer.connection.execute("use master; ALTER DATABASE activerecord_unittest_mirroring SET PARTNER FAILOVER") 
end

def failover                    
  begin
    db_failover
  rescue 
    sleep 1
    retry
  end
  Programmer.connection.reconnect!
  print_current_server_name
end         

def print_current_server_name
  print "connected to #{Programmer.server_name}\n"
end

#dummy class to include SqlServerMirroring module, and test it
class DummyModel
  include ActiveRecord::ConnectionAdapters::SqlServerMirroring

  def initialize(options)
    @connection_options = options
  end

  attr_reader :connection_options
end
