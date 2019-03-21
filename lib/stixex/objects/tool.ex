defmodule Stixex.Objects.Tool do
  use Stixex.Objects, type_name: "tool"

  @required_fields [:labels, :name]

  embedded_schema do
    common_fields()
    name_and_description()
    kill_chain_phases()
    field :tool_version, :string
  end

  def changeset(struct, params) do
    struct
    |> cast_common(params)
    |> cast(params, [:name, :description, :kill_chain_phases, :tool_version])
    |> validate_required(@required_fields)
    |> Stixex.Validation.validate_values_in_vocab(:labels, "tool-label-ov")
  end
end
