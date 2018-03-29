class TestRunsController < ApplicationController
  def create
    render json: TestRunParser.new(params[:test_data]).report
  end
end
