module Admin
  class ExperimentsController < BaseController
    def index
      @experiments = Experiment.recent.page(params[:page]).per(20)
    end

    def show
      @experiment = Experiment.find(params[:id])
      @stats = @experiment.variant_stats
    end

    def new
      @experiment = Experiment.new
    end

    def create
      variants = params[:experiment][:variants_text].to_s.split(",").map(&:strip).reject(&:blank?)

      @experiment = Experiment.new(
        name: params[:experiment][:name],
        description: params[:experiment][:description],
        metric: params[:experiment][:metric],
        variants: variants,
        traffic_percentage: params[:experiment][:traffic_percentage] || 100
      )

      if @experiment.save
        audit!("create_experiment", resource: @experiment)
        redirect_to admin_experiment_path(@experiment), notice: "Experiment created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def start
      @experiment = Experiment.find(params[:id])
      @experiment.start!
      audit!("start_experiment", resource: @experiment)
      redirect_to admin_experiment_path(@experiment), notice: "Experiment started."
    end

    def stop
      @experiment = Experiment.find(params[:id])
      @experiment.stop!
      audit!("stop_experiment", resource: @experiment, metadata: @experiment.variant_stats)
      redirect_to admin_experiment_path(@experiment), notice: "Experiment stopped."
    end
  end
end
