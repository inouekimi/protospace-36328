
class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  # ログインしていないユーザーをログインぺージに促す
  # index,showアクションは除外される
  before_action :set_prototype, only: [:edit, :show, :update]
  before_action :move_to_index, except: [:index, :show,]

  def index
    @prototype = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else  
      render :new
    end
  end
  
  def show
    @comment = Comment.new
    @comments = Comment.all
  end
  
  def edit
  end
  
  def update
    if @prototype.update(prototype_params)
      redirect_to prototype_path
      # 更新が成功した場合は詳細画面に移行
    else
      render :edit
    end
  end
  
  def destroy
    prototype = Prototype.find(params[:id])
    # binding.pry
    prototype.destroy
    redirect_to root_path
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def move_to_index
    unless @prototype.user.id == current_user.id
      redirect_to action: :index
    end
  end
end
