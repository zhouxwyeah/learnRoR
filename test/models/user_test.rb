require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
  	@user = User.new(name:"Test User", email:"test@user.com",password: "foobar", password_confirmation: "foobar");
  end

  test "should be valid" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  # test "name should be present" do
  # 	@user.name = "a" * 51
  # 	assert_not @user.valid?
  # end


  # test "email should be present" do
  # 	@user.email = "  "
  # 	assert_not @user.valid?
  # end

  # test "email validation" do
  # 	invalid_addresses = %w[user@example,com user_at_oo.org user.name@example.
  #                          foo@bar_baz.com foo@bar_baz.com]
  #   invalid_addresses.each do |valid_address|
  #   	@user.email=valid_address;
  #   	assert_not @user.valid?,"#{valid_address.inspect} is invalid"
  #   end
  # end
  # test "email should be unique" do
  #   dup_user = @user.dup
  #   @user.save
  #   assert_not dup_user.valid?
  # end
end
