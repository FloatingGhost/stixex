defmodule Stixex.Object.AttackPattern do
  use Stixex.Object, type_name: "attack-pattern"

  @required_fields [:name]

  embedded_schema do
    common_fields()
    name_and_description()
    kill_chain_phases()
  end

  def changeset(struct, params) do
    struct
    |> cast_common(params)
    |> cast(params, [:name, :description, :kill_chain_phases])
    |> validate_required(@required_fields)
  end
end
