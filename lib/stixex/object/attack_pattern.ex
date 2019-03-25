defmodule StixEx.Object.AttackPattern do
  use StixEx.Object, type_name: "attack-pattern"

  @required_fields [:name]

  embedded_schema do
    common_fields()
    field(:name, :string)
    field(:description, :string)
    embeds_many(:kill_chain_phases, StixEx.Types.KillChainPhase)
  end

  common_functions()

  def changeset(struct, params) do
    struct
    |> cast_common(params)
    |> cast(params, [:name, :description])
    |> cast_embed(:kill_chain_phases)
    |> validate_required(@required_fields)
  end
end
