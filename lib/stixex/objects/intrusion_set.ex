defmodule Stixex.Objects.IntrusionSet do
  use Stixex.Objects, type_name: "intrusion-set"

  @required_fields [:name]

  embedded_schema do
    common_fields()
    name_and_description()
    first_and_last_seen()
    field :aliases, {:array, :string}
    field :goals, {:array, :string}
    field :resource_level, :string
    field :primary_motivation, :string
    field :secondary_motivation, {:array, :string}
  end

  def changeset(struct, params) do
    struct
    |> cast_common(params)
    |> cast(params, [:name, :description, :first_seen, :last_seen, :goals, :resource_level, :primary_motivation, :secondary_motivation])
    |> validate_required(@required_fields)
    |> Stixex.Validation.validate_values_in_vocab(:resource_level, "attack-resource-level-ov")
    |> Stixex.Validation.validate_values_in_vocab(:primary_motivation, "attack-motivation-ov")
    |> Stixex.Validation.validate_values_in_vocab(:secondary_motivation, "attack-motivation-ov")
  end
end
