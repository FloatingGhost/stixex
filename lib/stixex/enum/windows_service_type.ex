defmodule StixEx.Enum.WindowsServiceType do
  @behaviour StixEx.Enum

  @impl StixEx.Enum
  def values do
    ~w[
      SERVICE_KERNEL_DRIVER
      SERVICE_FILE_SYSTEM_DRIVER
      SERVICE_WIN32_OWN_PROCESS
      SERVICE_WIN32_SHARE_PROCESS
    ]
  end
end
