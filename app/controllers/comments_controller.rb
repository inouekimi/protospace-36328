class CommentsController < ApplicationController
  def create
  # commentを保存する
    @comment = Comment.new(comment_params)
    # 空のインスタンスを生成
    # 引数よりcomment_paramsメソッドを呼び出す
    # 入力されたcommentパラメータを@commentに代入
    # binding.pry
    if @comment.save
    # もし入力されたcommentパラメータが保存できたら
      redirect_to prototype_path(@comment.prototype)
      # 情報を更新してprototype_path(show.html.erb)に転送する
    else   
      @prototype = @comment.prototype
      render "prototypes/show"
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
