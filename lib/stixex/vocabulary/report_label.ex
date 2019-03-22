defmodule StixEx.Vocabulary.ReportLabel do
  @behaviour StixEx.Vocabulary
  
  @impl StixEx.Vocabulary
  def values do
    ~w[
      threat-report
      attack-pattern
      campaign
      identity
      indicator
      malware
      observed-data
      threat-actor
      tool
      vulnerability
    ]
  end
end
