defmodule StixEx.Enum.NetworkSocketProtocolFamily do
  @behaviour StixEx.Enum

  @impl StixEx.Enum
  def values do
    ~w[
      PF_INET
      PF_AX25
      PF_IPX
      PF_INET6
      PF_APPLETALK
      PF_NETROM
      PF_BRIDGE
      PF_ATMPVC
      PF_X25
      PF_ROSE
      PF_DECNET
      PF_NETBEUI
      PF_SECURITY
      PF_KEY
      PF_NETLINK
      PF_ROUTE
      PF_PACKET
      PF_ASH
      PF_ECONET
      PF_ATMSVC
      PF_SNA
      PF_IRDA
      PF_PPPOX
      PF_WANPIPE
      PF_BLUETOOTH
    ]
  end
end
