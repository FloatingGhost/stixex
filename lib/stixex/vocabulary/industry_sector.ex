defmodule StixEx.Vocabulary.IndustrySector do
  @behaviour StixEx.Vocabulary

  @impl StixEx.Vocabulary
  def values do
    ~w[
      agriculture
      aerospace
      automotive
      communications
      construction
      defence
      education
      energy
      entertainment
      financial-services
      government-national
      government-regional
      government-local
      government-public-services
      healthcare
      hospitality-leisure
      infrastructure
      insurance
      manufacturing
      mining
      non-profit
      pharmaceuticals
      retail
      technology
      telecommunications
      transportation
      utilities
    ]
  end
end
