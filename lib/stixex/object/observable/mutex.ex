defmodule StixEx.Object.Observable.Mutex do
  use StixEx.Object.Observable, type_name: "mutex"

  @required_fields [:name]

  embedded_schema do
    common_fields()
    field(:name, :string)
  end

  common_functions()

  def changeset(struct, params) do
    struct
    |> cast_common(params)
    |> cast(params, [:name])
    |> validate_required(@required_fields)
  end
end
