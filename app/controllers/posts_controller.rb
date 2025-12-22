class PostsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]


    #Обработка главной страницы
    def index 
        @post = Post.all 
    end

    #Добавление нового поста
    def new
        @post = Post.new
    end

    def show 
        @post = Post.find(params[:id])
        @comments = @post.comments.order(created_at: :desc)
    end

    def edit
        @post = Post.find(params[:id])
    end
    
    def update
        @post = Post.find(params[:id])
        if(@post.update(post_params))
            redirect_to @post, notice: "Рецепт успешно обновлен!" 
        else
            render 'edit'
        end
    end

    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        redirect_to posts_path, notice: "Рецепт удален!" 
    end

    #Создание нового поста
    def create 
        @post = current_user.posts.new(post_params)
        if(@post.save)
            redirect_to @post, notice: "Рецепт успешно создан!"
        else
            render 'new'
        end
    end

    private def post_params
        params.require(:post).permit(:title, :body)
    end
end
