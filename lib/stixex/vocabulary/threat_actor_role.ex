defmodule StixEx.Vocabulary.ThretActorRole do
  @behaviour StixEx.Vocabulary

  @impl StixEx.Vocabulary
  def values do
    ~w[
      agent
      director
      independent
      infrastructure-architect
      infrastructure-operator
      malware-author
      sponsor
    ]
  end
end
