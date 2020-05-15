class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    #params[:sort_expired]に値があれば、終了期限でソートした値を表示させる
    if params[:sort_expired]
      @tasks = Task.current_user.tasks.order(end_on: :desc).page(params[:page]).per(10)
    elsif params[:sort_priority]
      @tasks = Task.all.order(priority: :asc).page(params[:page]).per(10)
    elsif
      #値がなければ、Task.allで取り出せるそのままの値を出力
      @tasks = Task.all.order(created_at: :desc).page(params[:page]).per(10)
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
  end

  def new
    @task = Task.new
  end

  def create
    #login中のユーザのtaskをnew(build)する。
    @task = current_user.tasks.build(task_params)
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
