defmodule StixEx.Object.Observable.Mutex do
  use StixEx.Object.Observable, type_name: "mutex"

  @required_fields [:name]

  embedded_schema do
    field(:name, :string)
  end

  def changeset(struct, params) do
    struct
    |> cast_common(params)
    |> cast(params, [:name])
    |> validate_required(@required_fields)
  end
end
