class WorksController < ApplicationController
  def index
    @works = Work.all.order(:id)
    @user = User.find_by(id: session[:user_id])
  end

  def show
    work_id = params[:id].to_i
    @work = Work.find_by(id: work_id)
    @user = User.find_by(id: session[:user_id])
    if @work.nil?
      redirect_to works_path
      return
    end
  end

  # def new
  #   @passenger = Passenger.find_by(id: params[:passenger_id])
  #   @work = Work.new(passenger_id: @passenger.id)
  # end

  def create
    @work = Work.new(passenger_id: params[:id])
    @user = User.find_by(id: session[:user_id])
    if @work.save
      redirect_to works_path(@work.id)
    else
      new_work_path(id: params[:id])
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])
    @user = User.find_by(id: session[:user_id])
    if !@work
      redirect_to works_path
    end
  end

  def update
    @work = Work.find_by(id: params[:id])
    @user = User.find_by(id: session[:user_id])
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
    @user = User.find_by(id: session[:user_id])
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
end
