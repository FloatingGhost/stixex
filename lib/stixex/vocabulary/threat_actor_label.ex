defmodule StixEx.Vocabulary.ThreatActorLabel do
  @behaviour StixEx.Vocabulary

  @impl StixEx.Vocabulary
  def values do
    ~w[
      activist
      competitor
      crime-syndicate
      criminal
      hacker
      insider-accidental
      insider-disgruntled
      nation-state
      sensationalist
      spy
      terrorist
    ]
  end
end
