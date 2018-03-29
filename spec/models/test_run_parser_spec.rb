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

  describe '#pending_end_time' do
    it 'returns the timestamp when the test run was updated in the pending state' do
      pending_end_time = described_class.new(simplified_data).pending_end_time
      expect(pending_end_time).to eq(simple_pending_update[:created_at])
    end
  end
end
