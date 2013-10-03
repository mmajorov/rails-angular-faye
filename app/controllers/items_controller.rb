class ItemsController < ApplicationController
  before_action :set_task

  # GET /tasks/:task_id/items
  # GET /tasks/:task_id/items.json
  def index
    @task_items = TaskItem.where task_id: @task.id
  end

  # GET /tasks/:task_id/items/1
  # GET /tasks/:task_id/items/1.json
  def show
  end

  # POST /tasks/:task_id/items
  # POST /tasks/:task_id/items.json
  def create
    @task_item = TaskItem.new(task_item_params)
    @task_item.task_id = @task.id

    respond_to do |format|
      if @task_item.save
        format.html { redirect_to task_item_path(@task, @task_item), notice: 'Task Item was successfully created.' }
        format.json { render action: 'show', status: :created, location: task_item_path(@task, @task_item) }
      else
        format.html { render action: 'new' }
        format.json { render json: @task_item.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:task_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_item_params
      params.require(:task_item).permit(:name, :task_id)
    end
end
