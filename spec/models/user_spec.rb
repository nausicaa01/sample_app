# -*- encoding: utf-8 -*-
require 'spec_helper'

describe User do

  before do
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  subject { @user }

  #name属性のデータがある
  it { should respond_to(:name) }
  #email属性のデータがある
  it { should respond_to(:email) }
  #password_digest属性のデータがある
  it { should respond_to(:password_digest) }
   #password属性のデータがユーザー入力にある
  it { should respond_to(:password) }
  #password_　confirmation属性のデータがユーザー入力にある
  it { should respond_to(:password_confirmation) }

  #@userがvalidである
  it { should be_valid }

  describe ":nameが空の場合のテスト" do
    before { @user.name = " " }
    #validではないと検証する
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe ":emailが空の場合のテスト" do
    before { @user.email = " " }
    #validではないと検証する
    it { should_not be_valid }
  end

  describe "emailフォーマットのテスト" do
    it "emailフォーマットが不正な場合" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
 
    it "emailフォーマットが正しい場合" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "email addressが登録済みの場合" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end
    #validではないと検証する
    it { should_not be_valid }
  end

  describe ":passwordが空のとき" do
    before do
      @user = User.new(name: "Example User", email: "user@example.com", password: " ", password_confirmation: " ")
    end
    #validではないと検証する
    it { should_not be_valid }
  end
 
  describe ":passwordとpassword_confirmationが一致しないとき" do
    before { @user.password_confirmation = "mismatch" }
    #validではないと検証する
    it { should_not be_valid }
  end

end