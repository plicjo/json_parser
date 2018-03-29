class TestRunParser
  attr_reader :test_run_data

  def initialize(test_run_data)
    @test_run_data = JSON.parse(test_run_data)
  end

  def pending_start_time
    test_run_data.detect { |state_update| first_state_update?(state_update) }['created_at']
  end

  def pending_end_time
    test_run_data.detect { |state_update| pending_update?(state_update) }['created_at']
  end

  private

  def first_state_update?(state_update)
    pending?(state_update) && state_update['action'] == 'create'
  end

  def pending_update?(state_update)
    pending?(state_update) && state_update['action'] == 'update'
  end

  def pending?(state_update)
    state_update['status'] == 'pending'
  end
end

# Pending start time - where status "pending" and action "create
# Pending end time   - where status "creating"
# Creating start time - where status "creating"
# Creating end time -   where status "building"
# Building start time - where status "building"
# Building end time -   where status "running"
# Running start time - where status "running"
# Running end time -   where status "succeeded"
