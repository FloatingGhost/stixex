defmodule Stixex.Types.MarkingDefinition.TLP do
  use Ecto.Schema
  import Ecto.Changeset

  @valid_colours ~w[white green amber red]
  @required_fields [:tlp]

  embedded_schema do
    field(:tlp, :string)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:tlp])
    |> validate_required(@required_fields)
    |> validate_inclusion(:tlp, @valid_colours)
  end
end
