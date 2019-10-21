class HomepagesController < ApplicationController
  def index
    @user = User.find_by(id: session[:user_id])
    @works = Work.all
    @movies = Work.by_category("movie", 10)
    @albums = Work.by_category("album", 10)
    @books = Work.by_category("book", 10)
  end
end
