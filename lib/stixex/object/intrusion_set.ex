defmodule StixEx.Object.IntrusionSet do
  use StixEx.Object, type_name: "intrusion-set"

  @required_fields [:name]

  embedded_schema do
    common_fields()
    field(:name, :string)
    field(:description, :string)
    field(:first_seen, :utc_datetime)
    field(:last_seen, :utc_datetime)
    field(:aliases, {:array, :string})
    field(:goals, {:array, :string})
    field(:resource_level, :string)
    field(:primary_motivation, :string)
    field(:secondary_motivations, {:array, :string})
  end

  common_functions()

  def changeset(struct, params) do
    struct
    |> cast_common(params)
    |> cast(params, [
      :name,
      :description,
      :first_seen,
      :last_seen,
      :goals,
      :resource_level,
      :primary_motivation,
      :secondary_motivations
    ])
    |> validate_required(@required_fields)
    |> validate_change(:resource_level, validate_values_in_vocab("attack-resource-level-ov"))
    |> validate_change(:primary_motivation, validate_values_in_vocab("attack-motivation-ov"))
    |> validate_change(:secondary_motivations, validate_values_in_vocab("attack-motivation-ov"))
  end
end
