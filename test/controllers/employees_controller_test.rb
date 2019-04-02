require 'test_helper'

class EmployeesControllerTest < ActionDispatch::IntegrationTest
setup do
    create_employees
  end

  teardown do
    remove_employees
  end

  test "should get index" do
    get employees_url
    assert_response :success
  end

  test "should get new" do
    get new_employee_url
    assert_response :success
  end

  test "should create employee" do
    assert_difference('Employee.count') do
      post employees_url, params: { employee: { active: @ben.active, first_name: "Jake", last_name: @ben.last_name, role: "employee", ssn: "010101010", date_of_birth: 19.years.ago.to_date } }
    end
  end


  test "should show employee" do
    get employee_url(@ben)
    assert_response :success
  end

  test "should get edit" do
    get edit_employee_url(@ben)
    assert_response :success
  end

  test "should update employee" do
    patch employee_url(@ben), params: { employee: { active: @ben.active, first_name: "Benjamin", last_name: @ben.last_name, role: @ben.role, ssn: @ben.ssn, date_of_birth: @ben.date_of_birth } }
    assert_redirected_to employee_url(@ben)
  end


  test "should destroy controller" do
    assert_difference('Controller.count', -1) do
      delete controller_url(@controller)
    end

    assert_redirected_to controllers_url
  end
end
