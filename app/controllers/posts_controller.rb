class PostsController < ApplicationController
    #Обработка главной страницы
    def index 

    end

    #Добавление нового поста
    def new

    end

    #Создание нового поста
    def create 
        render plain: params[:post].inspect
    end
end
