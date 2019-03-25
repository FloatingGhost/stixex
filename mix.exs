defmodule StixEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :stixex,
      description: "Implementation of CTI's STIX format",
      version: "0.1.2",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      source_url: "https://github.com/FloatingGhost/stixex"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:sweet_xml, "~> 0.6.6"},
      {:jason, "~> 1.1"},
      {:ecto, "~> 3.0.7"},
      {:valid_url, "~> 0.1.2"}
    ]
  end

  defp package() do
    [
      licenses: ["MIT"],
      links: %{
        "specification" => "http://docs.oasis-open.org/cti/stix/v2.0/",
        "introduction-to-stix" =>
          "https://oasis-open.github.io/cti-documentation/stix/intro.html",
        "github" => "https://github.com/FloatingGhost/stixex"
      }
    ]
  end
end
