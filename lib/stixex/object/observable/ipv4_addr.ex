defmodule StixEx.Object.Observable.IPv4Addr do
  use StixEx.Object.Observable, type_name: "ipv4-addr"

  @required_fields [:value]

  embedded_schema do
    field(:value, :string)
    field(:resolves_to_refs, {:array, StixEx.Types.ObjectRef})
    field(:belongs_to_ref, StixEx.Types.ObjectRef)
  end

  def changeset(struct, params) do
    struct
    |> cast_common(params)
    |> cast(params, [:value, :belongs_to_ref, :resolves_to_refs])
    |> validate_required(@required_fields)
  end
end
