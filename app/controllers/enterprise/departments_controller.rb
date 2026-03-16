module Enterprise
  class DepartmentsController < BaseController
    before_action :require_hr_admin!, except: [:index, :show]
    before_action :set_department, only: [:show, :edit, :update, :destroy]

    def index
      @departments = @company.departments.includes(:head).order(:name)
    end

    def show
      @members = @department.company_members.includes(:user).order(:title)
    end

    def new
      @department = @company.departments.build
    end

    def create
      @department = @company.departments.build(department_params)
      if @department.save
        redirect_to enterprise_department_path(@department), notice: "Department created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @department.update(department_params)
        redirect_to enterprise_department_path(@department), notice: "Department updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @department.destroy!
      redirect_to enterprise_departments_path, notice: "Department deleted."
    end

    private

    def set_department
      @department = @company.departments.find(params[:id])
    end

    def department_params
      params.require(:department).permit(:name, :description, :head_id, :parent_department_id)
    end
  end
end
