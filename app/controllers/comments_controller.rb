class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :set_post
  
  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    
    if @comment.save
      redirect_to @post, notice: "Комментарий добавлен!"
    else
      render 'posts/show'
    end
  end
  
  def destroy
    @comment = @post.comments.find(params[:id])
    
    # Проверяем права
    if @comment.user == current_user || @post.user == current_user
      @comment.destroy
      redirect_to @post, notice: "Комментарий удален!"
    else
      redirect_to @post, alert: "Вы не можете удалить этот комментарий!"
    end
  end
  
  private
  
  def set_post
    @post = Post.find(params[:post_id])
  end
  
  def comment_params
    params.require(:comment).permit(:body)
  end
end