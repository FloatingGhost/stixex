defmodule StixexTest.Types.KillChainPhase do
  use ExUnit.Case
  alias Stixex.Types.KillChainPhase

  test "Example data should be valid" do
    params = %{
      kill_chain_name: "lockheed-martin-cyber-kill-chain",
      phase_name: "reconnaissance"
    }

    changeset = KillChainPhase.changeset(%KillChainPhase{}, params)
    assert changeset.valid? == true
  end

  test "Kill chain name MUST be present" do
    params = %{
      phase_name: "reconnaissance"
    }

    changeset = KillChainPhase.changeset(%KillChainPhase{}, params)
    assert changeset.valid? == false
  end

  test "Phase name MUST be present" do
    params = %{
      phase_name: "reconnaissance"
    }

    changeset = KillChainPhase.changeset(%KillChainPhase{}, params)
    assert changeset.valid? == false
  end
end
