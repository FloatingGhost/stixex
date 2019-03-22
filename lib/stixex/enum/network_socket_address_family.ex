defmodule StixEx.Enum.NetworkSocketAddressFamily do
  @behaviour StixEx.Enum

  @impl StixEx.Enum
  def values do
    ~w[
      AF_UNSPEC
      AF_INET
      AF_IPX
      AF_APPLETALK
      AF_NETBIOS
      AF_INET6
      AF_IRDA
      AF_BTH
    ]
  end
end
