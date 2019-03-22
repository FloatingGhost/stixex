defmodule StixEx.Object.Observable.Extension.Socket do
  use StixEx.Object.Observable.Extension, type_name: "socket"

  @required_fields [:address_family]

  embedded_schema do
    field(:address_family, :string)
    field(:is_blocking, :boolean)
    field(:is_listening, :boolean)
    field(:protocol_family, :string)
    field(:options, :map)
    field(:socket_type, :string)
    field(:socket_descriptor, :integer)
    field(:socket_handle, :integer)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [
      :address_family,
      :is_blocking,
      :is_listening,
      :protocol_family,
      :options,
      :socket_type,
      :socket_descriptor,
      :socket_handle
    ])
    |> validate_required(@required_fields)
    |> validate_change(
      :address_family,
      validate_values_in_enum("network-socket-address-family-enum")
    )
    |> validate_change(
      :protocol_family,
      validate_values_in_enum("network-socket-protocol-family-enum")
    )
    |> validate_change(:socket_type, validate_values_in_enum("network-socket-type-enum"))
  end
end
