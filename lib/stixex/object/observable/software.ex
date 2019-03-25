defmodule StixEx.Object.Observable.Software do
  use StixEx.Object.Observable, type_name: "software"

  @required_fields [:name]

  embedded_schema do
    common_fields()
    field(:name, :string)
    field(:cpe, :string)
    field(:languages, {:array, :string})
    field(:vendor, :string)
    field(:version, :string)
  end

  common_functions()

  def changeset(struct, params) do
    struct
    |> cast_common(params)
    |> cast(params, [:name, :cpe, :languages, :vendor, :version])
    |> validate_required(@required_fields)
  end
end
