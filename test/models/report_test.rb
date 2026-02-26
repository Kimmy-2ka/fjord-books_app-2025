# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  # 現在ログインしているユーザーが日報の投稿者であることを確認する。
  test '# editable? true' do
    report = reports(:first_report)
    login_user = users(:alice)
    report.user = login_user
    assert report.editable?(login_user)
  end

  # 現在ログインしているユーザーが日報の投稿者でなければfalseを返す。
  test '# editable? false' do
    report = reports(:first_report)
    report.user = users(:alice)
    login_user = users(:bob)
    assert_not report.editable?(login_user)
  end

  # 投稿日時を投稿日のみに変換する。
  test '# created_on' do
    report = reports(:first_report)
    report.created_at = '2025-10-26 06:52:49.106361000 +0900'
    assert_equal Date.new(2025, 10, 26), report.created_on
  end

  # 新規作成した日報にほかの日報のURLが含まれるとき、保存した日報に言及が紐づく。
  test '# report_mention add mention when create' do
    mentioned_report = reports(:first_report)

    mentioning_report = Report.create!(
      user: users(:alice),
      title: '今日見た日報',
      content: "http://localhost:3000/reports/#{mentioned_report.id}を見ました。"
    )

    assert_includes(mentioning_report.mentioning_reports, mentioned_report)
  end

  # 更新した日報にほかの日報のURLが含まれるとき、保存した日報に言及が紐づく。
  test '# report_mention add mention when update' do
    mentioning_report = reports(:first_report)
    mentioned_report = reports(:second_report)

    mentioning_report.update(
      content: "http://localhost:3000/reports/#{mentioned_report.id}を見ました。"
    )

    assert_includes(mentioning_report.mentioning_reports, mentioned_report)
  end

  # ほかの日報のURLが記載された日報を更新しURLを削除した時、言及の紐づきがなくなる。
  test '# report_mention remove mention' do
    mentioning_report = reports(:first_report)
    mentioned_report = reports(:second_report)

    mentioning_report.update(
      content: "http://localhost:3000/reports/#{mentioned_report.id}を見ました。"
    )

    assert_includes(mentioning_report.mentioning_reports, mentioned_report)

    mentioning_report.update(content: 'URLを削除。')
    mentioning_report.reload

    assert_not_includes(mentioning_report.mentioning_reports, mentioned_report)
  end
end
