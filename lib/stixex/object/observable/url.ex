defmodule StixEx.Object.Observable.URL do
  use StixEx.Object.Observable, type_name: "url"

  @required_fields [:value]

  embedded_schema do
    common_fields()
    field(:value, :string)
  end

  def changeset(struct, params) do
    struct
    |> cast_common(params)
    |> cast(params, [:value])
    |> validate_required(@required_fields)
  end
end
