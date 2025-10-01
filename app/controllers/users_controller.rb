# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_book, only: :show
  def index
    @users = User.order(:id).page(params[:page])
  end

  def show; end

  private

  def set_book
    @user = User.find(params.expect(:id))
  end
end
