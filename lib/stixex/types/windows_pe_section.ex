defmodule StixEx.Types.WindowsPESection do
  use Ecto.Schema
  import Ecto.Changeset

  @derive Jason.Encoder
  @required_fields [:name]

  embedded_schema do
    field(:name, :string)
    field(:size, :integer)
    field(:entropy, :float)
    field(:hashes, StixEx.Types.Hashes)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:name, :size, :entropy, :hashes])
    |> validate_required(@required_fields)
  end
end
