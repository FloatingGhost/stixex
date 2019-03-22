defmodule StixEx.Enum.NetworkSocketType do
  @behaviour StixEx.Enum

  @impl StixEx.Enum
  def values do
    ~w[
      SOCK_STREAM
      SOCK_DGRAM
      SOCK_RAW
      SOCK_RDM
      SOCK_SEQPACKET
    ]
  end
end
