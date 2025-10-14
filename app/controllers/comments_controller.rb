# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable, only: %i[create]

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to polymorphic_path(@commentable), notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_commentable
    @commentable =
      if params[:book_id]
        Book.find(params[:book_id])
      elsif params[:report_id]
        Report.find(params[:report_id])
      end
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
