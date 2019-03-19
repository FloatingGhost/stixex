defmodule Stixex.Vocabulary.ReportLabel do
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
