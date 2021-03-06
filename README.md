# StixEx

An implementation of CTI's STIX data format, as defined by http://docs.oasis-open.org/cti/stix/v2.0/

[![Build Status](https://travis-ci.org/FloatingGhost/stixex.svg?branch=master)](https://travis-ci.org/FloatingGhost/stixex)

This video response directed at everyone who "designed" this spec: [https://www.youtube.com/watch?v=Yje5oIQr92w](https://www.youtube.com/watch?v=Yje5oIQr92w)

>Why are we still here? Just to suffer?

>Every night, I feel my coherent data formats, and my naming conventions... even my json,

>The sanity I've lost, the trust in committees I've lost,

>It won't stop hurting...

>It's like they're all still there

>You feel it too, don't you?

>I'm gonna make them give back our formats

## Installation

The package can be installed by adding `stixex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:stixex, "~> 0.1.3"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/stixex](https://hexdocs.pm/stixex).

## Example Usage

```elixir
iex> {:ok, threat_actor} = StixEx.Object.ThreatActor.new(%{
    name: "OASIS",
    primary_motivation: "dominance"
})

iex> {:ok, campaign} = StixEx.Object.Campaign.new(%{
    name: "STIX"
})

iex> {:ok, relationship} = StixEx.Object.Relationship.new(%{
    source_ref: campaign.id,
    relationship_type: "attributed-to",
    target_ref: threat_actor.id
})

iex> {:ok, my_bundle} = StixEx.Bundle.new(%{objects: [threat_actor, campaign, relationship]})
iex> StixEx.Bundle.to_string(my_bundle, )
{:ok, "{\"id\":\"bundle--...\"}"}
```
