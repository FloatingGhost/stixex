defmodule Stixex.Types.MarkingDefinition.Statement do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields [:statement]

  embedded_schema do
    field(:statement, :string)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:statement])
    |> validate_required(@required_fields)
  end
end
