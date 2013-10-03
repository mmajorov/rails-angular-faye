class ItemsController < ApplicationController
  before_action :set_task

  # GET /tasks
  # GET /tasks.json
  def index
    @task_items = TaskItem.where task_id: @task.id
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:task_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_item_params
      params.require(:task).permit(:name, :task_id)
    end
end
