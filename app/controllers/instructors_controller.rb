class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response


    def index 
        instructors = Instructor.all
        render json: instructors
    end

    def show 
        instructor = Instructor.find(params[:id])
        render json: instructor
    end

    def create
        instructor = Instructor.create(instructor_params)
        if instructor.valid?
            render json: instructor, status: :created
          else
            render json: { errors: ["validation errors"] }, status: :unprocessable_entity
          end
    end

    def destroy
        instructor = Instructor.find(params[:id])
        instructor.destroy
        head :no_content
    end

    def update
        instructor = Instructor.find(params[:id]) 
        instructor.update(instructor_params)
        if instructor.valid?
            render json: instructor
        else
            render json: { errors: ["validation errors"] }, status: :unprocessable_entity
        end
    end

    private

    def instructor_params
        params.permit(:name)
    end

    def render_not_found_response
        render json: { error: "Activity not found" }, status: :not_found
    end
end
