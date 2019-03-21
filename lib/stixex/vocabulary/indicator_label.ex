defmodule StixEx.Vocabulary.IndicatorLabel do
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
