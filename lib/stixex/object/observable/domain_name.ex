defmodule StixEx.Object.Observable.DomainName do
  use StixEx.Object.Observable, type_name: "domain-name"

  @required_fields [:value]

  embedded_schema do
    common_fields()
    field(:value, :string)
    field(:resolves_to_refs, {:array, StixEx.Types.ObjectRef})
  end

  def changeset(struct, params) do
    struct
    |> cast_common(params)
    |> cast(params, [:value, :resolves_to_refs])
    |> validate_required(@required_fields)
  end
end
