require 'spec_helper'

describe User do
  before { @user = User.new(name: "Example User", email: "example@example.com", password: "foobar", password_confirmation: "foobar") }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should_not respond_to(:sex) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }

  it { should be_valid }

  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end

  describe "Name attribute should be present" do

  	before { @user.name = "" }
  	it { should be_invalid }
  end

  describe "Email attribute must be present" do
  	before { @user.email = "" }
  	it { should be_invalid }
  end

  describe "Name should be no more than 50 characters" do
  	before { @user.name = "a" * 51}
  	it { should be_invalid }
  end

  describe "Email Adress Should be unique" do
  	before do
  		user_with_same_email = @user.dup
  		user_with_same_email.email = @user.email.upcase
  		user_with_same_email.save
  	end

  	it { should be_invalid }
  end

  describe "return value of authentication method" do
    before { @user.save }
    let(:test_user) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it { should eq test_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:bad_user) { test_user.authenticate("badpassword")}
      it {should_not eq test_user.authenticate("badpassword")}
      specify { expect(bad_user).to be_false }
    end
  end

  describe "when user email format is invalid" do
  	it "should be invalid" do
  		address = %w[user@foo,com user_at_foo.org exampe.user@foo. foo@bar_baz.com foo@bar+bax.com]
  		address.each do |bad_email|
  			@user.email = bad_email
  			expect(@user).not_to be_valid
  		end
  	end
  end

  describe "when password is long enough" do
    before { @user.password = "a" * 5 }
    it { should be_invalid }
  end

  describe "when user email format is valid" do
  	it "should be valid" do
  		address = %w[user@foo.COM A-US-ER@f.b.org frst.last@foo.jp a+b@baz.cn]
  		address.each do |good_email|
  			@user.email = good_email
  			expect(@user).to be_valid
  		end
  	end
  end

  describe "when password is not present" do
    before do
      @user = User.new(name: "John Jonzz", email: "MartianManhunter@jl.com", password: "", password_confirmation: "")
    end

    it { should be_invalid }
  end

  describe "when passwords don't match" do
    before { @user.password = "mismatch" }

    it { should be_invalid }
  end

  describe "mixed case emails should be downcase" do
    let(:mixed_email) { "FoO@eXaMpLe.CoM"}

    it "should make the email all lowercase" do
      @user.email = mixed_email
      @user.save
      expect(@user.reload.email).to eq mixed_email.downcase
    end
  end
end
