defmodule StixEx.Enum.WindowsServiceStatus do
  @behaviour StixEx.Enum

  @impl StixEx.Enum
  def values do
    ~w[
      SERVICE_CONTINUE_PENDING
      SERVICE_PAUSE_PENDING
      SERVICE_PAUSED
      SERVICE_RUNNING
      SERVICE_START_PENDING
      SERVICE_STOP_PENDING
      SERVICE_STOPPED
    ]
  end
end
