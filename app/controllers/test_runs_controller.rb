class TestRunsController < ApplicationController
  def create
    render json: TestRunParser.new(params['_json']).report
  end
end
