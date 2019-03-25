defmodule StixEx.Object.ThreatActor do
  use StixEx.Object, type_name: "threat-actor"

  @required_fields [:labels, :name]

  embedded_schema do
    common_fields()
    field(:name, :string)
    field(:description, :string)
    field(:aliases, {:array, :string})
    field(:roles, {:array, :string})
    field(:goals, {:array, :string})
    field(:sophistication, :string)
    field(:resource_level, :string)
    field(:primary_motivation, :string)
    field(:secondary_motivations, {:array, :string})
    field(:personal_motivations, {:array, :string})
  end

  common_functions()

  def changeset(struct, params) do
    struct
    |> cast_common(params)
    |> cast(params, [
      :aliases,
      :name,
      :description,
      :roles,
      :goals,
      :sophistication,
      :resource_level,
      :primary_motivation,
      :secondary_motivations,
      :personal_motivations
    ])
    |> validate_required(@required_fields)
    |> validate_change(:labels, validate_values_in_vocab("threat-label-ov"))
    |> validate_change(:roles, validate_values_in_vocab("threat-actor-role-ov"))
    |> validate_change(
      :sophistication,
      validate_values_in_vocab("threat-actor-sophistication-ov")
    )
    |> validate_change(:resource_level, validate_values_in_vocab("attack-resource-level-ov"))
    |> validate_change(:primary_motivation, validate_values_in_vocab("attack-motivation-ov"))
    |> validate_change(:secondary_motivations, validate_values_in_vocab("attack-motivation-ov"))
    |> validate_change(:personal_motivations, validate_values_in_vocab("attack-motivation-ov"))
  end
end
