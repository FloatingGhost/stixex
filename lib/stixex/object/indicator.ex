defmodule StixEx.Object.Indicator do
  use StixEx.Object, type_name: "indicator"

  @required_fields [:labels, :pattern, :valid_from]

  embedded_schema do
    common_fields()
    field(:name, :string)
    field(:description, :string)
    field(:valid_from, :utc_datetime)
    field(:valid_until, :utc_datetime)
    field(:pattern, :string)
    embeds_many(:kill_chain_phases, StixEx.Types.KillChainPhase)
  end

  common_functions()

  def changeset(struct, params) do
    struct
    |> cast_common(params)
    |> cast(params, [
      :pattern,
      :name,
      :description,
      :valid_from,
      :valid_until,
      :pattern
    ])
    |> cast_embed(:kill_chain_phases)
    |> validate_required(@required_fields)
    |> validate_change(:labels, validate_values_in_vocab("indicator-label-ov"))
  end
end
