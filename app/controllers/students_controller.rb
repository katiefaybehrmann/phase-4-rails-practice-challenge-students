class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index
        students = Student.all
        render json: students
    end

    def show
        student = Student.find(params[:id])
        render json: student
    end

    def create
        student = Student.create(student_params)
        if student.valid?
            render json: student, status: :created
        else
            render json: { errors: ["validation errors"] }, status: :unprocessable_entity
        end
    end

    def update
        student = Student.find(params[:id]) 
        student.update(student_params)
        if student.valid?
            render json: student
        else
            render json: { errors: ["validation errors"] }, status: :unprocessable_entity
        end
    end

    def destroy
        student = Student.find(params[:id])
        student.destroy
        head :no_content
    end

    private

    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end

    def render_not_found_response
        render json: { error: "Activity not found" }, status: :not_found
    end
end
