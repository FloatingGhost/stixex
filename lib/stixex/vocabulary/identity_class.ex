defmodule StixEx.Vocabulary.IdentityClass do
  @behaviour StixEx.Vocabulary
  
  @impl StixEx.Vocabulary
  def values do
    ~w[
      individual
      group
      organization
      class
      unknown
    ]
  end
end
