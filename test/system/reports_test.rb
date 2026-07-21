# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    visit root_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'Password!'
    click_button 'ログイン'
    assert_text 'ログインしました'
  end
  test 'visiting the index' do
    visit reports_url
    assert_selector 'h1', text: '日報の一覧'
  end

  test 'should create report' do
    visit reports_url
    click_on '日報の新規作成'

    fill_in 'タイトル', with: '今日はテストを勉強しました'
    fill_in '内容', with: 'テストを勉強しました。難しかったです。'
    click_on '登録する'

    assert_text '日報が作成されました。'
    assert_text '今日はテストを勉強しました'
  end

  test 'should update Report' do
    visit report_url(reports(:first_report))
    click_on 'この日報を編集'

    fill_in 'タイトル', with: '今日の日報を修正'
    fill_in '内容', with: '今日の日報、ちょっと修正しました！'
    click_on '更新する'

    assert_text '日報が更新されました。'
    assert_text '今日の日報を修正'
  end

  test 'should destroy Report' do
    report = reports(:first_report)
    title = report.title

    visit report_url(report)
    click_on 'この日報を削除'

    assert_text '日報が削除されました。'
    assert_no_text title
  end
end
