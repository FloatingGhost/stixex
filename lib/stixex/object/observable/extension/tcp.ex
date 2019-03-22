defmodule StixEx.Object.Observable.Extension.TCP do
  use StixEx.Object.Observable.Extension, type_name: "tcp-ext"

  embedded_schema do
    field(:src_flags_hex, StixEx.Types.Hex)
    field(:dst_flags_hex, StixEx.Types.Hex)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:src_flags_hex, :dst_flags_hex])
  end
end
