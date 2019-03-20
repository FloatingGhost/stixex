defmodule Stixex.Types.KillChainPhase do
  @moduledoc """
  The kill-chain-phase represents a phase in a kill chain,
  which describes the various phases an attacker may undertake in order
  to achieve their objective
  """

  use Ecto.Schema
  import Ecto.Changeset

  @required_fields [:kill_chain_name, :phase_name]

  embedded_schema do
    field :kill_chain_name, :string
    field :phase_name, :string
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:kill_chain_name, :phase_name])
    |> validate_required(@required_fields)
  end
end
