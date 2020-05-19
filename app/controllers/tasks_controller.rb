class TasksController < ApplicationController
  before_action :authenticate_user
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    #params[:sort_expired]に値があれば、終了期限でソートした値を表示させる
    if params[:sort_expired]
      @tasks = current_user.tasks.order(end_on: :desc).page(params[:page]).per(10)
    elsif params[:sort_priority]
      @tasks = current_user.tasks.order(priority: :asc).page(params[:page]).per(10)
    elsif
      #値がなければ、Task.allで取り出せるそのままの値を出力
      @tasks = current_user.tasks.order(created_at: :desc).page(params[:page]).per(10)
    end

    if params[:search].present?
      if params[:task_name].present? && params[:status].present?
        @tasks = Task.status(params[:status]).task_name_like(params[:task_name]).page(params[:page]).per(10)
      elsif params[:task_name].present?
        @tasks = Task.task_name_like(params[:task_name]).page(params[:page]).per(10)
      elsif params[:status].present?
        @tasks = Task.status(params[:status]).page(params[:page]).per(10)
      end
    end
    @tasks = @tasks.joins(:labels).where(labels: { id: params[:label_id] }) if params[:label_id].present?
  end

  def new
    @task = Task.new
  end

  def create
    #login中のユーザのtaskをnew(build)する。
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to tasks_path, notice: t('notice.task_create')
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: t('notice.task_update')
    else
      render :edit
    end
  end

  def destroy
    if @task.destroy
      redirect_to tasks_path, notice: t('notice.task_deleted')
    else
      redirect_to admin_users_path, notice: t('notice.notdeleted')
    end
  end

  private
  def task_params
    params.require(:task).permit(:task_name, :content, :end_on, :status, :priority, label_ids: [] )
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
