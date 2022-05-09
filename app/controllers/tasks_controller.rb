class TasksController < ApplicationController
  
  before_action :require_user_logged_in
  
  before_action :is_own_task, only: [:show, :edit, :update, :destroy ]
  
  def index
    @pagy, @tasks = pagy(Task.order(id: :desc), items: 5)
  end
 
  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)

    if @task.save
      flash[:success] = 'task が正常に投稿されました'
      redirect_to @task
    else
      flash.now[:danger] = 'task が投稿されませんでした'
      render :new
    end
  end
  
  def edit
     @task = Task.find(params[:id])
  end

  def update
     @task = Task.find(params[:id])

    if @task.update(task_params)
      flash[:success] = 'task は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'task は更新されませんでした'
      render :edit
    end
  end

  def destroy
     @task = Task.find(params[:id])
    @task.destroy

    flash[:success] = 'task は正常に削除されました'
    redirect_to tasks_url
  end
  
  private
  

  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  
  def is_own_task

    task = current_user.tasks.find_by_id(params[:id])

    return redirect_to root_path if !task
    
  end
end
