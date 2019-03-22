defmodule StixEx.Types.WindowsRegistryValue do
  use Ecto.Schema
  import Ecto.Changeset
  import StixEx.Validation

  @required_fields [:name]

  embedded_schema do
    field(:name, :string)
    field(:data, :string)
    field(:data_type, :string)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:name, :data, :data_type])
    |> validate_required(@required_fields)
    |> validate_change(:data_type, validate_values_in_enum("windows-registry-datatype-enum"))
  end
end
