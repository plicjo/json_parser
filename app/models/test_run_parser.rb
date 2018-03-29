class TestRunParser
  attr_reader :test_run_data

  def initialize(test_run_data)
    @test_run_data = JSON.parse(test_run_data)
  end

  def pending_start_time
    test_run_data.detect { |state_update| initial_state?(state_update) }['created_at']
  end

  def creating_start_time
    find_state_update_timestamp('creating')
  end

  def building_start_time
    find_state_update_timestamp('building')
  end

  def running_start_time
    find_state_update_timestamp('running')
  end

  def succeeded_start_time
    find_state_update_timestamp('succeeded')
  end

  def pending_duration
    calculate_duration(pending_start_time, creating_start_time)
  end

  def creating_duration
    calculate_duration(creating_start_time, building_start_time)
  end

  def building_duration
    calculate_duration(building_start_time, running_start_time)
  end

  def running_duration
    calculate_duration(running_start_time, succeeded_start_time)
  end

  private

  def initial_state?(state_update)
    state_update['status'] == 'pending' && state_update['action'] == 'create'
  end

  def find_state_update_timestamp(state_update)
    test_run_data.detect { |test_run| test_run['status'] == state_update }['created_at']
  end

  def calculate_duration(beginning, ending)
    (DateTime.parse(beginning).to_i - DateTime.parse(ending).to_i).abs
  end
end
