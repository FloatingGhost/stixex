defmodule Stixex.Objects.ThreatActor do
  use Stixex.Objects, type_name: "threat-actor"

  @required_fields [:labels, :name]

  embedded_schema do
    common_fields()
    name_and_description()
    field(:aliases, {:array, :string})
    field(:roles, {:array, :string})
    field(:goals, {:array, :string})
    field(:sophistication, :string)
    field(:resource_level, :string)
    field(:primary_motivation, :string)
    field(:secondary_motivations, {:array, :string})
    field(:personal_motivations, {:array, :string})
  end

  def changeset(struct, params) do
    changeset
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
    |> Stixex.Validation.validate_values_in_vocab(:labels, "threat-actor-label-ov")
    |> Stixex.Validation.validate_values_in_vocab(:roles, "threat-actor-role-ov")
    |> Stixex.Validation.validate_values_in_vocab(
      :sophistication,
      "threat-actor-sophistication-ov"
    )
    |> Stixex.Validation.validate_values_in_vocab(:resource_level, "attack-resource-level-ov")
    |> Stixex.Validation.validate_values_in_vocab(:primary_motivation, "attack-motivation-ov")
    |> Stixex.Validation.validate_values_in_vocab(:secondary_motivations, "attack-motivation-ov")
    |> Stixex.Validation.validate_values_in_vocab(:personal_motivations, "attack-motivation-ov")
  end
end
