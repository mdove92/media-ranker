class WorksController < ApplicationController
  before_action :find_user, only: [:index, :show, :create, :edit, :update, :destroy]
  before_action :find_work, only: [:index, :show, :create, :edit, :update, :destroy]

  def index
    @works = Work.all
    @movies = Work.by_category("movie")
    @albums = Work.by_category("album")
    @books = Work.by_category("book")
  end

  def show
    @work_id = params[:id].to_i
    if @work.nil?
      redirect_to works_path
      return
    end
  end

  def new
    @work = Work.new
  end

  def create
    if @work.save
      redirect_to works_path(@work.id)
    else
      new_work_path(id: params[:id])
    end
  end

  def edit
    if !@work
      redirect_to works_path
    end
  end

  def update
    if !@work
      redirect_to works_path
      return
    end
    if @work.update(work_params)
      redirect_to work_path(@work.id)
    else
      render new_work_path
    end
  end

  def destroy
    work_to_delete = Work.find_by(id: params[:id])
    if work_to_delete.nil?
      redirect_to works_path
      return
    else
      work_to_delete.destroy
      redirect_to works_path
      return
    end
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

  def find_user
    @user = User.find_by(id: session[:user_id])
  end

  def find_work
    @work = Work.find_by_id(params[:id])
  end
end