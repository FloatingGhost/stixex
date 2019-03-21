defmodule StixEx.Types.ObjectRef do
  @moduledoc """
  The Object Reference data type specifies a local reference to an Observable Object,
  that is, one which MUST be valid within the local scope of
  the Observable Objects (observable-objects) container that holds both the
  source Observable Object and the Observable Object that it references. 

  Examples
  The following example demonstrates how a Network Traffic Object specifies its
  destination via a reference to an IPv4 Address Object.
  {
    "0": {
      "type": "ipv4-addr",
      "value": "198.51.100.2"
    },
    "1": {
      "type": "network-traffic",
      "dst_ref": "0"
    }
  }

  Implementer's note: SO IT'S A FUGGING STRING THEN ISN'T IT YOU BUMBLING IMBECILES
  Also what the FRICK is up with that object... you're implementing an array using
  a map. Have you recently had a lobotomy?

  To developers: PLEASE don't hate me for implementing this as-specced. I hate myself
  enough for doing it.
  """

  @behaviour Ecto.Type

  def type, do: :string
  def cast(value), do: {:ok, value}
  def load(value), do: {:ok, value}
  def dump(value), do: {:ok, value}
end
