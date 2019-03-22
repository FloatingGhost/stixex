defmodule StixEx.Vocabulary.ThreatActorSophistication do
  @behaviour StixEx.Vocabulary
  
  @impl StixEx.Vocabulary
  def values do
    ~w[
      none
      minimal
      intermediate
      advanced
      expert
      innovator
      strategic
    ]
  end
end
