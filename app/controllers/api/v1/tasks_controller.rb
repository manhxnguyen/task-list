module Api
  module V1
    class TasksController < ApplicationController
      before_action :set_task, only: %i[show update destroy]

      # GET /api/v1/tasks
      def index
        @tasks = case params[:filter]
                 when 'completed'
                   Task.completed
                 when 'pending'
                   Task.pending
                 else
                   Task.all
                 end
        render json: @tasks.ordered_by_title
      end

      # GET /api/v1/tasks/1
      def show
        render json: @task
      end

      # POST /api/v1/tasks
      def create
        @task = Task.new(task_params.merge(completed: false))
        if @task.save
          render json: @task, status: :created
        else
          render json: @task.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/tasks/1
      def update
        if @task.update(task_params)
          render json: @task
        else
          render json: @task.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/tasks/1
      def destroy
        @task.destroy!
        render status: :no_content
      end

      private

      def set_task
        @task = Task.find(params[:id])
      end

      def task_params
        params.require(:task).permit(:title, :description, :completed)
      end
    end
  end
end
