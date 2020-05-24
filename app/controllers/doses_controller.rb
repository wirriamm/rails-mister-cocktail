class DosesController < ApplicationController
  def new
    @dose = Dose.new
  end

  def create
    @dose = Dose.find(dose_params)
  end

  def destroy
    @dose = Dose.find(params[:id])
  end

  private

  def dose_params
    params.require(:dose).permit(:description, :ingredient)
  end
end
