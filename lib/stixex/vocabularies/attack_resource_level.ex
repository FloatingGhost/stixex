defmodule Stixex.Vocabularies.AttackResourceLevel do
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