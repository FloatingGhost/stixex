defmodule StixEx.Object.Tool do
  use StixEx.Object, type_name: "tool"

  @required_fields [:labels, :name]

  embedded_schema do
    common_fields()
    name_and_description()
    kill_chain_phases()
    field(:tool_version, :string)
  end

  common_functions()

  def changeset(struct, params) do
    struct
    |> cast_common(params)
    |> cast(params, [:name, :description, :kill_chain_phases, :tool_version])
    |> validate_required(@required_fields)
    |> validate_change(:labels, validate_values_in_vocab("tool-label-ov"))
  end
end
