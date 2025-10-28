# frozen_string_literal: true

class Reports::CommentsController < CommentsController
  def set_commentable
    @commentable = Report.find(params[:report_id])
  end

  def render_commentable_show
    @report = @commentable
    @comments = @commentable.comments.includes(:user)
    render 'reports/show', status: :unprocessable_entity
  end
end
