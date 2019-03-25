defmodule StixEx.Object.Tool do
  use StixEx.Object, type_name: "tool"

  @required_fields [:labels, :name]

  embedded_schema do
    common_fields()
    field(:name, :string)
    field(:description, :string)
    field(:tool_version, :string)
    embeds_many(:kill_chain_phases, StixEx.Types.KillChainPhase)
  end

  common_functions()

  def changeset(struct, params) do
    struct
    |> cast_common(params)
    |> cast(params, [:name, :description, :tool_version])
    |> cast_embed(:kill_chain_phases)
    |> validate_required(@required_fields)
    |> validate_change(:labels, validate_values_in_vocab("tool-label-ov"))
  end
end
