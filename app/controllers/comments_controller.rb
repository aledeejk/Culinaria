class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :set_post
  
  def create
  @comment = @post.comments.new(comment_params)
  
  if user_signed_in?
    @comment.user = current_user
    @comment.username = current_user.name.presence || current_user.email
  else
    redirect_to new_user_session_path, alert: "Войдите, чтобы оставить комментарий"
    return
  end
  
  if @comment.save
    redirect_to @post, notice: "Комментарий добавлен!"
  else
    @comments = @post.comments.where.not(id: nil).order(created_at: :desc)
    flash.now[:alert] = @comment.errors.full_messages.to_sentence
    render 'posts/show'
  end
end
  

  def destroy
    @comment = @post.comments.find(params[:id])
    if user_signed_in? && (@comment.user == current_user || @post.user == current_user)
      @comment.update(body: "Комментарий удален!")
      redirect_to @post, notice: "1 уведомление"
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