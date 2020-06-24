class DosesController < ApplicationController
  before_action :set_cocktail, only: %i[new create dose]

  def new
    @dose = Dose.new
  end

  def create
    # @dose = Dose.new(dose_params)
    # @dose.cocktail = @cocktail
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = @cocktail.doses.build(dose_params)

    if @dose.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @dose = Dose.find(params[:id])
    @cocktail = @dose.cocktail
    @dose.delete

    redirect_to cocktail_path(@cocktail)
  end

  private

  def set_dose
    @dose = Dose.find(params[:id])
  end

  def set_cocktail
    @cocktail = Cocktail.find(params[:cocktail_id])
  end

  def dose_params
    params.require(:dose).permit(:description, :ingredient_id)
  end

  def ingredient_params
    params.require(:ingredient).permit(:name)
  end
end
