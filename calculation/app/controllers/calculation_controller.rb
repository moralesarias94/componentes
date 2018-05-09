class CalculationController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  def calcule
    @notes = params_calculation[:notes]
    @minimum = params_calculation[:minimum].to_f

    percentage = @notes.map { |f| f[:percentage].to_f / 100.0 }.sum
    grade = (@minimum - @notes.map { |f| f[:value].to_f * (f[:percentage].to_f / 100.0) }.sum) / (1.0 - percentage)

    render json: {
      final_score: grade,
      percentage: (1.0 - percentage)
    }
  end

  private

  def params_calculation
    params.permit(:minimum, notes: [:percentage, :value])
  end
end
