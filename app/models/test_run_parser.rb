class TestRunParser
  attr_reader :test_run_data

  def initialize(test_run_data)
    @test_run_data = JSON.parse(test_run_data)
  end

  def pending_start_time
    test_run_data.detect { |state_update| first_state_update?(state_update) }['created_at']
  end

  def creating_start_time
    find_state_update_timestamp('creating')
  end

  def building_start_time
    find_state_update_timestamp('building')
  end

  private

  def first_state_update?(state_update)
    state_update['status'] == 'pending' && state_update['action'] == 'create'
  end

  def find_state_update_timestamp(state_update)
    test_run_data.detect do |test_run|
      test_run['status'] == state_update
    end['created_at']
  end
end

# Creating start time - where status "creating"
# Building start time - where status "building"
# Running start time - where status "running"
# Running end time -   where status "succeeded"
