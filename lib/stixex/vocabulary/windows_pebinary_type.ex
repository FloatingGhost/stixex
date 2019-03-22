defmodule StixEx.Vocabulary.WindowsPebinaryType do
  @behaviour StixEx.Vocabulary
  
  @impl StixEx.Vocabulary
  def values do
    ~w[
      exe
      dll
      sys
    ]
  end
end
