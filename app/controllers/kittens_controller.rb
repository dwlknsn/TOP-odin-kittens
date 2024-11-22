class KittensController < ApplicationController
  before_action :set_kitten, only: [ :show, :edit, :update, :destroy ]

  def index
    @kittens = Kitten.all.select(:id, :name)

    respond_to do |format|
      format.html
      format.json { render json: @kittens }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @kitten }
    end
  end

  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(kitten_params)
    if @kitten.save
      flash[:notice] = "Kitten created successfully"
      redirect_to @kitten
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @kitten.update(kitten_params)
      flash[:notice] = "Kitten edited successfully"
      redirect_to @kitten
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @kitten.destroy
    flash[:notice] = "Kitten deleted successfully"
    redirect_to kittens_path
  end

  private

  def set_kitten
    @kitten ||= Kitten.find(params[:id])
  end

  def kitten_params
    params.require(:kitten).permit(:name, :age, :cuteness, :softness)
  end
end
