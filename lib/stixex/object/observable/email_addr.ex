defmodule StixEx.Object.Observable.EmailAddr do
  use StixEx.Object.Observable, type_name: "email-addr"

  @required_fields [:value]

  embedded_schema do
    common_fields()
    field(:value, :string)
    field(:display_name, :string)
    field(:belongs_to_ref, StixEx.Types.ObjectRef)
  end

  def changeset(struct, params) do
    struct
    |> cast_common(params)
    |> cast(params, [:value, :display_name, :belongs_to_ref])
    |> validate_required(@required_fields)
  end
end
