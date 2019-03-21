defmodule Stixex.Types.GranularMarking do
  @moduledoc """
  Whereas object markings apply to an entire STIX Object or Marking Definition and all 
  its properties, granular markings allow data markings to be applied to individual 
  portions of STIX Object and Marking Definitions. 

  Granular markings are specified in the granular_markings property, 
  which is a list of granular-marking instances. 

  Each of those instances contains a list of selectors to indicate what is marked 
  and a reference to the marking-definition object to be applied. 

  Granular markings can be used, for example, to indicate that 
  the name property of an indicator should be handled as TLP:GREEN,
  the description property as TLP:AMBER, and the pattern property as TLP:RED.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @required_fields [:marking_ref, :selectors]

  embedded_schema do
    field(:marking_ref, Stixex.Types.Identifier)
    field(:selectors, {:array, :string})
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:marking_ref, :selectors])
    |> validate_required(@required_fields)
    |> validate_length(:selectors, min: 1)
  end
end
