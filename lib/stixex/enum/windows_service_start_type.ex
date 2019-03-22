defmodule StixEx.Enum.WindowsServiceStartType do
  @behaviour StixEx.Enum

  @impl StixEx.Enum
  def values do
    ~w[
      SERVICE_AUTO_START
      SERVICE_BOOT_START
      SERVICE_DEMAND_START
      SERVICE_DISABLED
      SERVICE_SYSTEM_ALERT
    ]
  end
end
