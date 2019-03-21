defmodule Stixex.Object.Observable.AutonomousSystem do
  use Stixex.Object.Observable, type_name: "autonomous-system"

  @required_fields [:number]

  embedded_schema do
    common_fields()
    field(:number, :integer)
    field(:name, :string)
    field(:rir, :string)
  end

  def changeset(struct, params) do
    struct
    |> cast_common(params)
    |> cast(params, [:number, :name, :rir])
    |> validate_required(@required_fields)
  end
end
