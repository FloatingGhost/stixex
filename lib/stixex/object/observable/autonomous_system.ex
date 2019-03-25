defmodule StixEx.Object.Observable.AutonomousSystem do
  use StixEx.Object.Observable, type_name: "autonomous-system"

  @required_fields [:number]

  embedded_schema do
    common_fields()
    field(:number, :integer)
    field(:name, :string)
    field(:rir, :string)
  end

  common_functions()

  def changeset(struct, params) do
    struct
    |> cast_common(params)
    |> cast(params, [:number, :name, :rir])
    |> validate_required(@required_fields)
  end
end
