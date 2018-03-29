require 'rails_helper'

RSpec.describe TestRunParser, type: :model do
  let(:simple_pending_create) do
    {
      data: {
        id: "1",
        status: "pending",
      },
      action: "create",
      created_at: "2018-02-08T19:50:20Z"
    }
  end

  let(:simple_pending_update) do
    {
      data: {
        id: "2",
        status: "pending",
      },
      action: "update",
      created_at: "2018-02-08T19:50:30Z"
    }
  end

  let(:simple_creating) do
    {
      data: {
        id: "3",
        status: "creating",
      },
      action: "update",
      created_at: "2018-02-08T19:50:45Z",
    }
  end

  let(:simple_building) do
    {
      data: {
        id: "4",
        status: "building",
        action: "update",
      },
      action: "update",
      created_at: "2018-02-08T19:51:05Z"
    }
  end

  let(:simple_running) do
    {
      data: {
        id: "5",
        status: "running",
      },
      action: "update",
      created_at: "2018-02-08T19:51:31Z"
    }
  end

  let(:simple_succeeded) do
    {
      data: {
        id: "6",
        status: "succeeded",
      },
      action: "update",
      created_at: "2018-02-08T19:52:00Z"
    }
  end

  let(:simplified_data) do
    [
      simple_pending_create,
      simple_pending_update,
      simple_creating,
      simple_building,
      simple_running,
      simple_succeeded
    ].map(&:with_indifferent_access)
  end

  describe '#pending_start_time' do
    it 'returns the timestamp when the test run was created' do
      pending_start_time = described_class.new(simplified_data).pending_start_time
      expect(pending_start_time).to eq(simple_pending_create[:created_at])
    end
  end

  describe '#creating_start_time' do
    it 'returns the timestamp when state changed to creating' do
      creating_start_time = described_class.new(simplified_data).creating_start_time
      expect(creating_start_time).to eq(simple_creating[:created_at])
    end
  end

  describe '#building_start_time' do
    it 'returns the timestamp when state changed to building' do
      building_start_time = described_class.new(simplified_data).building_start_time
      expect(building_start_time).to eq(simple_building[:created_at])
    end
  end

  describe '#running_start_time' do
    it 'returns the timestamp when state changed to running' do
      running_start_time = described_class.new(simplified_data).running_start_time
      expect(running_start_time).to eq(simple_running[:created_at])
    end
  end

  describe '#succeeded_start_time' do
    it 'returns the timestamp when state changed to succeeded' do
      succeeded_start_time = described_class.new(simplified_data).succeeded_start_time
      expect(succeeded_start_time).to eq(simple_succeeded[:created_at])
    end
  end

  describe '#pending_duration' do
    it 'returns the difference in seconds between pending start and creating start' do
      expected_duration = 25
      actual_duration = described_class.new(simplified_data).pending_duration
      expect(actual_duration).to eq(expected_duration)
    end
  end

  describe '#creating_duration' do
    it 'returns the difference in seconds between creating start and building start' do
      expected_duration = 20
      actual_duration = described_class.new(simplified_data).creating_duration
      expect(actual_duration).to eq(expected_duration)
    end
  end

  describe '#building_duration' do
    it 'returns the difference in seconds between building start and running start' do
      expected_duration = 26
      actual_duration = described_class.new(simplified_data).building_duration
      expect(actual_duration).to eq(expected_duration)
    end
  end

  describe '#running_duration' do
    it 'returns the difference in seconds between running start and succeeded start' do
      expected_duration = 29
      actual_duration = described_class.new(simplified_data).running_duration
      expect(actual_duration).to eq(expected_duration)
    end
  end
end
