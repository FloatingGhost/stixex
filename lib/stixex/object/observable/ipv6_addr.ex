defmodule StixEx.Object.Observable.IPv6Addr do
  use StixEx.Object.Observable, type_name: "ipv6-addr"

  @required_fields [:value]

  embedded_schema do
    common_fields()
    field(:value, :string)
    field(:resolves_to_refs, {:array, StixEx.Types.ObjectRef})
    field(:belongs_to_ref, StixEx.Types.ObjectRef)
  end

  common_functions()

  def changeset(struct, params) do
    struct
    |> cast_common(params)
    |> cast(params, [:value, :resolves_to_refs, :belongs_to_ref])
    |> validate_required(@required_fields)
  end
end
