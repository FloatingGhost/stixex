defmodule StixEx.Vocabulary.IndicatorLabel do
  @behaviour StixEx.Vocabulary
  
  @impl StixEx.Vocabulary
  def values do
    ~w[
      anomalous-activity
      anonymization
      benign
      compromised
      malicious-activity
      attribution
    ]
  end
end
