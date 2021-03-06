class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book_id = @book.id
    if @comment.save
      flash.now[:notice] = "You have created comment successfully"
      render :book_comments #render先にjsファイルを指定
    else
      render :error   #render先にjsファイルを指定
    end
  end

  def destroy
    BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
    flash.now[:alert] = "You have destroyed comment successfully"
    #renderしたときに@bookのデータがないので@bookを定義
    @book = Book.find(params[:book_id])
    render :book_comments  #render先にjsファイルを指定
  end


  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
