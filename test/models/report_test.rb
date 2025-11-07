# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  # 現在ログインしているユーザーが日報の投稿者であることを確認する。
  test ' # editable? true ' do
    report = reports(:first_report)
    target_user = users(:alice)
    assert report.editable?(target_user)
  end

  # 現在ログインしているユーザーが日報の投稿者でなければfalseを返す。
  test ' # editable? false ' do
    report = reports(:first_report)
    target_user = users(:bob)
    assert_not report.editable?(target_user)
  end

  # 投稿日時を投稿日のみに変換する。
  test '# created_on' do
    report = reports(:first_report)
    assert_equal Date.new(2025, 10, 26), report.created_on
  end
end
