class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:edit, :update, :show, :destroy, :change]

  def index
    @to_do = current_user.tasks.where(state: 'to_do')
    @in_progress = current_user.tasks.where(state: 'in_progress')
    @complete = current_user.tasks.where(state: 'complete')
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = current_user.tasks.new(tasks_params)
    if @task.save
      flash[:notice] = "Task was successfully created"
      redirect_to tasks_path
    else
      render 'new'
    end
  end

  def show
  end

  def update
    if @task.update(tasks_params)
      flash[:notice] = "Task was successfully updated"
      redirect_to task_path(@task)
    else
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    flash[:notice] = "Task was successfully deleted"
    redirect_to tasks_path
  end

  def change
    @task.update_attributes(state: params[:state])
    flash[:notice] = "Task status was successfully updated"
    redirect_to tasks_path
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  # White list
  def tasks_params
    params.require(:task).permit(:content, :state)
  end

end
