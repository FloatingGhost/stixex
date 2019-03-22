defmodule StixEx.Object.Observable.Extension.ICMP do
  use StixEx.Object.Observable.Extension, type_name: "icmp-ext"

  @required_fields [:icmp_type_hex, :icmp_code_hex]

  embedded_schema do
    field(:icmp_type_hex, StixEx.Types.Hex)
    field(:icmp_code_hex, StixEx.Types.Hex)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:icmp_type_hex, :icmp_code_hex])
    |> validate_required(@required_fields)
  end
end
