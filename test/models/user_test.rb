# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # 名前が登録されていれば、名前を表示する。
  test '#name_or_email returns name' do
    user = users(:alice)
    assert_equal 'Alice', user.name_or_email
  end

  # 名前が登録されていなければ、メールアドレスを表示する。
  test '#name_or_email returns email' do
    user = users(:bob)
    assert_equal 'bob@example.com', user.name_or_email
  end
end
