defmodule StixEx.Object.Indicator do
  use StixEx.Object, type_name: "indicator"

  @required_fields [:labels, :pattern, :valid_from]

  embedded_schema do
    name_and_description()
    first_and_last_seen(first_seen: :valid_from, last_seen: :valid_until)
    kill_chain_phases()
    field(:pattern, :string)
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
      :pattern,
      :kill_chain_phases
    ])
    |> validate_required(@required_fields)
    |> validate_change(:labels, validate_values_in_vocab("indicator-label-ov"))
  end
end
