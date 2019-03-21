defmodule StixEx.Object.Observable.Directory do
  use StixEx.Object.Observable, type_name: "directory"

  @required_fields [:path]

  embedded_schema do
    common_fields()
    field(:path, :string)
    field(:path_enc, :string)
    field(:created, :utc_datetime)
    field(:modified, :utc_datetime)
    field(:accessed, :utc_datetime)
    field(:contains_refs, {:array, StixEx.Types.ObjectRef})
  end

  def changeset(struct, params) do
    struct
    |> cast_common(params)
    |> cast(params, [:path, :path_enc, :created, :modified, :accessed, :contains_refs])
    |> validate_required(@required_fields)
  end
end
