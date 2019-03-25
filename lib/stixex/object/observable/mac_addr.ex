defmodule StixEx.Object.Observable.MACAddr do
  use StixEx.Object.Observable, type_name: "mac-addr"

  @required_fields [:value]

  embedded_schema do
    common_fields()
    field(:value, :string)
  end

  common_functions()

  def changeset(struct, params) do
    struct
    |> cast_common(params)
    |> cast(params, [:value])
    |> validate_required(@required_fields)
  end
end
