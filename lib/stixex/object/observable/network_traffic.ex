defmodule StixEx.Object.Observable.NetworkTraffic do
  use StixEx.Object.Observable, type_name: "network-traffic"

  @required_fields [:protocols]

  embedded_schema do
    common_fields()
    field(:start, :utc_datetime)
    field(:end, :utc_datetime)
    field(:is_active, :boolean)
    field(:src_ref, StixEx.Types.ObjectRef)
    field(:dst_ref, StixEx.Types.ObjectRef)
    field(:src_port, :integer)
    field(:dst_port, :integer)
    field(:protocols, {:array, :string})
    field(:src_byte_count, :integer)
    field(:dst_byte_count, :integer)
    field(:src_packets, :integer)
    field(:dst_packets, :integer)
    field(:ipfix, :map)
    field(:src_payload_ref, StixEx.Types.ObjectRef)
    field(:dst_payload_ref, StixEx.Types.ObjectRef)
    field(:encapsulates_refs, {:array, StixEx.Types.ObjectRef})
    field(:encapulated_by_ref, StixEx.Types.ObjectRef)
  end

  common_functions()

  def changeset(struct, params) do
    struct
    |> cast_common(params)
    |> cast(params, [
      :start,
      :end,
      :is_active,
      :src_ref,
      :dst_ref,
      :src_port,
      :dst_port,
      :protocols,
      :src_byte_count,
      :dst_byte_count,
      :src_packets,
      :dst_packets,
      :ipfix,
      :src_payload_ref,
      :dst_payload_ref,
      :encapsulates_refs,
      :encapulated_by_ref
    ])
    |> validate_required(@required_fields)
  end
end
