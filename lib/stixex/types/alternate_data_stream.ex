defmodule Stixex.Types.AlternateDataStream do
  use Stixex.Object.Observable.Extension, type_name: "alternate-data-stream-type"

  @required_fields [:name]

  embedded_schema do
    field :name, :string
    field :hashes, Stixex.Types.Hashes
    field :size, :integer
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:name, :hashes, :size])
    |> validate_required(@required_fields)
    |> validate_number(:size, greater_than: 0)
  end
end
