require 'test_helper'

class ShiftTest < ActiveSupport::TestCase
  should belong_to(:assignment)
  should have_many(:shift_jobs)
  should have_many(:jobs).through(:shift_jobs)
  should have_one(:employee).through(:assignment)
  should have_one(:store).through(:assignment)

  should allow_value(Time.now).for(:start_time)
  should allow_value(1.hour.from_now).for(:start_time)
  should allow_value(2.hours.ago).for(:start_time)
  should_not allow_value("fred").for(:start_time)
  should_not allow_value(3.14159).for(:start_time)
  should_not allow_value(nil).for(:start_time)

  context "Creating a context for shifts" do
    setup do 
      create_stores
      create_employees
      create_assignments
      create_shifts
    end
    
    teardown do
      remove_stores
      remove_employees
      remove_assignments
      remove_shifts
    end
    
    # test the scope 'chronological'
    should "have a scope to order chronologically" do
      assert_equal ["Ed", "Ed", "Ed", "Kathryn", "Ben", "Kathryn", "Ben", "Cindy"], Shift.chronological.map{|s| s.employee.first_name}
    end
    # test the scope 'by_store'
    should "have a scope to order by store name" do
      assert_equal ["CMU", "CMU", "CMU", "CMU", "CMU", "CMU", "Oakland", "Oakland"], Shift.by_store.map{|s| s.store.name}
    end
    # test the scope 'by_employee'
    should "have a scope to order by employee name" do
      assert_equal ["Crawford, Cindy", "Gruberman, Ed", "Gruberman, Ed", "Gruberman, Ed", "Janeway, Kathryn", "Janeway, Kathryn", "Sisko, Ben", "Sisko, Ben"], Shift.by_employee.map{|s| s.employee.name}
    end
    # test the scope 'past'
    should "have a scope for past shifts" do
      assert_equal 4, Shift.past.size
    end
    # test the scope 'upcoming'
    should "have a scope for upcoming shifts" do
      assert_equal 4, Shift.upcoming.size
    end
    # test the scope 'for_employee'
    should "have a scope called for_employee" do
      assert_equal 2, Shift.for_employee(@ben.id).size
      assert_equal 1, Shift.for_employee(@cindy.id).size
      assert_equal 2, Shift.for_employee(@kathryn.id).size
    end
    # test the scope 'for_store'
    should "have a scope called for_store" do
      assert_equal 6, Shift.for_store(@cmu.id).size
      assert_equal 2, Shift.for_store(@oakland.id).size
    end
    # test the scope 'for_next_days'
    should "have a scope called for_next_days" do
      assert_equal 2, Shift.for_next_days(0).size
      assert_equal 4, Shift.for_next_days(2).size
    end
    # test the scope 'for_past_days'
    should "have a scope called for_past_days" do
      assert_equal 2, Shift.for_past_days(1).size
      assert_equal 3, Shift.for_past_days(2).size
      assert_equal 4, Shift.for_past_days(3).size
    end
    # test the scope 'completed'
    should "have a scope for completed shifts" do
      create_jobs
      create_shift_jobs
      assert_equal 3, Shift.completed.to_a.size
      remove_jobs
      remove_shift_jobs
    end
    # test the scope 'incomplete'
    should "have a scope for incomplete shifts" do
      create_jobs
      create_shift_jobs
      assert_equal 5, Shift.incomplete.to_a.size
      remove_jobs
      remove_shift_jobs    
    end



    
  end
end