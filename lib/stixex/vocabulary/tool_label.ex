defmodule StixEx.Vocabulary.ToolLabel do
  @behaviour StixEx.Vocabulary

  @impl StixEx.Vocabulary
  def values do
    ~w[
      denial-of-service
      exploitation
      information-gathering
      network-capture
      credential-exploitation
      remote-access
      vulnerability-scanning
    ]
  end
end
