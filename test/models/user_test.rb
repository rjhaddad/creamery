require 'test_helper'

class UserTest < ActiveSupport::TestCase
should belong_to(:employee)
should have_secure_password

  # Validating email...
  should allow_value("reem@gmail.com").for(:email)
  should allow_value("reem@andrew.cmu.edu").for(:email)
  should allow_value("reem@cmu.org").for(:email)
  should allow_value("reem123@qatar.gov").for(:email)
  should allow_value("reemy@cmu.net").for(:email)
  
  should_not allow_value("reem").for(:email)
  should_not allow_value("reem@r,com").for(:email)
  should_not allow_value("reem@rm.uk").for(:email)
  should_not allow_value("i reem@qq.com").for(:email)
  should_not allow_value("me@me.con").for(:email)

  should validate_uniqueness_of(:email).case_insensitive

  context "Creating a context for users" do
    setup do 
      create_employees
      create_users
    end
    
    teardown do
      remove_employees
      remove_users
    end

       should "shows proper name as first and last name" do
      assert_equal "Alex Heimann", @user.employee.proper_name
    end 

    # test role? method
    should "have working role? method" do 
      assert @reem_user.role?(:manager)
      deny @reem_user.role?(:admin)
      assert @reem_user.role?(:admin)
    end

  end
end
