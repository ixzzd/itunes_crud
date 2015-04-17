require 'rake'

class AppsController < ApplicationController
  before_action :set_app, only: [:show, :edit, :update, :destroy]

  def index
    @apps = App.all
  end

  def show
    @reviews = @app.reviews.paginate(:page => params[:page])
    respond_to do |format|
        format.html
        format.js 
        format.json {
        render :json => {
          :app=> @app,
          :entries => @reviews,
          :current_page => @reviews.current_page,
          :per_page => @reviews.per_page,
          :total_entries => @reviews.total_entries
        }
      }
    end  
  end

  def new
    @app = App.new
  end

  def edit
  end

  def create
    @app = App.new(app_params)

    respond_to do |format|
      if @app.save
        format.html { redirect_to @app, notice: 'App was successfully created.' }
        format.json { render :show, status: :created, location: @app }
      else
        format.html { render :new }
        format.json { render json: @app.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @app.update(app_params)
        format.html { redirect_to @app, notice: 'App was successfully updated.' }
        format.json { render :show, status: :ok, location: @app }
      else
        format.html { render :edit }
        format.json { render json: @app.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @app.destroy
    respond_to do |format|
      format.html { redirect_to apps_url, notice: 'App was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import_reviews
    ItunesCrud::Application.load_tasks
    Rake.application.invoke_task("review:import[#{params[:id]}]")
    Rake::Task['review:import'].reenable
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end

  end

  private
    def set_app
      @app = App.find(params[:id])
    end

    def app_params
      params.require(:app).permit(:name, :itunes_id, :image_url)
    end
end
