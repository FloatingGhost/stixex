defmodule StixEx.Enum.WindowsRegistryDataType do
  @behaviour StixEx.Enum

  @impl StixEx.Enum
  def values do
    ~w[
      REG_NONE
      REG_SZ
      REG_EXPAND_SZ
      REG_BINARY
      REG_DWORD
      REG_DWORD_BIG_ENDIAN
      REG_LINK
      REG_MULTI_SZ
      REG_RESOURCE_LIST
      REG_FULL_RESOURCE_DESCRIPTION
      REG_RESOURCE_REQUIREMENTS_LIST
      REG_QWORD
      REG_INVALID_TYPE
    ]
  end
end
