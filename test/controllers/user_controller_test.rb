require "test_helper"

describe UserController do
  it "must get username:string" do
    get user_username:string_url
    must_respond_with :success
  end

end
