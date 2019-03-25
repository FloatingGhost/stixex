defmodule StixEx.Types.AlternateDataStream do
  use Ecto.Schema
  import Ecto.Changeset

  @derive Jason.Encoder
  @required_fields [:name]

  embedded_schema do
    field(:name, :string)
    field(:hashes, StixEx.Types.Hashes)
    field(:size, :integer)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:name, :hashes, :size])
    |> validate_required(@required_fields)
    |> validate_number(:size, greater_than: 0)
  end
end
