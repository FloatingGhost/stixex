defmodule StixEx.Vocabulary.AttackResourceLevel do
  @behaviour StixEx.Vocabulary

  @impl StixEx.Vocabulary
  def values do
    ~w[
      individual
      club
      contest
      team
      organization
      government
    ]
  end
end
