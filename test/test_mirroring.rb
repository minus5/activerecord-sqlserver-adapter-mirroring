require 'test_helper'
require 'minitest/autorun'

class TestMirroring < ActiveSupport::TestCase
#  self.use_transactional_fixtures = false

  def setup
    setup_db
  end

  def test_working_with_two_servers
    print_current_server_name

    Programmer.create(:first_name => "Sasa",  :last_name => "Juric")
    assert_equal 1, Programmer.count                                                          

    failover

    Programmer.create(:first_name => "Goran",  :last_name => "Pizent")    
    assert_equal 2, Programmer.count
    
    failover

    Programmer.create(:first_name => "Vedran",  :last_name => "Skrnjug")    
    assert_equal 3, Programmer.count    
  end

  def test_status_flags
    assert Programmer.db_mirroring_active?
  end

  def test_mirroring_status
    status = Programmer.db_mirroring_status
    pp status
    assert !status.empty?
    assert_equal "activerecord_unittest_mirroring", status["database_name"]
    assert_equal "PRINCIPAL", status["mirroring_role_desc"]
    assert ["SYNCHRONIZED", "SYNCHRONIZING"].include? status["mirroring_state_desc"]
  end

end
