# frozen_string_literal: true

class Books::CommentsController < CommentsController
  def set_commentable
    @commentable = Book.find(params[:book_id])
  end

  def render_commentable_show
    @book = @commentable
    @comments = @commentable.comments.includes(:user)
    render 'books/show', status: :unprocessable_entity
  end
end
