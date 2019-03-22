defmodule StixEx.Vocabulary.AttackMotivation do
  @behaviour StixEx.Vocabulary

  @impl StixEx.Vocabulary
  def values do
    ~w[
      accidental
      coercion
      dominance
      ideology
      notoriety
      organizational-gain
      personal-gain
      personal-satisfaction
      revenge
      unpredictable
    ]
  end
end
