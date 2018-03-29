require 'rails_helper'

RSpec.describe TestRunParser, type: :model do
  let(:simple_pending_create) do
    {
      id: "1",
      status: "pending",
      action: "create",
      created_at: "2018-02-08T19:50:20Z",
    }
  end

  let(:simple_pending_update) do
    {
      id: "2",
      status: "pending",
      action: "update",
      created_at: "2018-02-08T19:50:30Z",
    }
  end

  let(:simple_creating) do
    {
      id: "3",
      status: "creating",
      action: "update",
      created_at: "2018-02-08T19:50:45Z",
    }
  end

  let(:simple_building) do
    {
      id: "4",
      status: "building",
      action: "update",
      created_at: "2018-02-08T19:51:05Z",
    }
  end

  let(:simple_running) do
    {
      id: "5",
      status: "running",
      action: "update",
      created_at: "2018-02-08T19:51:30Z",
    }
  end

  let(:simple_succeeded) do
    {
      id: "6",
      status: "succeeded",
      action: "update",
      created_at: "2018-02-08T19:52:00Z",
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
    ].to_json
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
end
