class AddIndexToCommentsCommentable < ActiveRecord::Migration[8.0]
  def change
    add_index :comments, [:commentable_type, :commentable_id]
  end
end
