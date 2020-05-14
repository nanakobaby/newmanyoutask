class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    #params[:sort_expired]に値があれば、終了期限でソートした値を表示させる
    if params[:sort_expired]
      @tasks = Task.all.order(end_on: :desc)
      @tasks = Task.all.order(priority: :asc)
    else
      #値がなければ、Task.allで取り出せるそのままの値を出力
      @tasks = Task.all.order(created_at: :desc)
    end

    if params[:search].present?
      if params[:task_name].present? && params[:status].present?
        @tasks = Task.status(params[:status]).task_name_like(params[:task_name])
      elsif params[:task_name].present?
        @tasks = Task.task_name_like(params[:task_name])
      elsif params[:status].present?
        @tasks = Task.status(params[:status])
      end
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: t('notice.create')
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
      redirect_to tasks_path, notice: t('notice.update')
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: t('notice.destroy')
  end

  private
  def task_params
    params.require(:task).permit(:task_name, :content, :end_on, :status, :priority)
  end

  def set_task
    @task = Task.find(params[:id])
  end
  end
