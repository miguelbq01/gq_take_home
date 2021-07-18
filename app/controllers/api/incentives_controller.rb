class Api::IncentivesController < ApplicationController

  def index
    @incentives = Incentive.all
    
    render json: @incentives.to_json
  end

  def get_code
    @incentives = Incentive.unredeemed
    if @incentives.size > 0
      random_incentive = @incentives[rand(1..@incentives.size) - 1]
      random_incentive.update(redeemed: true)
      render json: random_incentive.to_json
    else
      render json: { error: "No codes available." }, status: :not_found
    end
  end

  def update
    @incentive = Incentive.find(params[:id])
    @incentive.update!(incentive_params)
    render json: @incentive.to_json
  end

  def create
    if Incentive.create(code: incentive_params[:code]).valid?
      render json: incentives.to_json
    else
      render json: { error: 'Code already created' }, status: :unprocessable_entity
    end
  end

  private

  def incentive_params
    params.require(:incentive).permit(:code, :redeemed)
  end

  def incentives
    @_incentives ||= Incentive.all
  end
end
