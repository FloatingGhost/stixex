defmodule Stixex.Objects.Relationship.Sighting do
  @moduledoc """
  A Sighting denotes the belief that something in CTI
  (e.g., an indicator, malware, tool, threat actor, etc.) was seen.

  Sightings are used to track who and what are being targeted,
  how attacks are carried out, and to track trends in attack behavior.
  """
  use Stixex.Objects, type_name: "sighting"

  @required_fields [:sighting_of_ref, :observed_data_refs]

  embedded_schema do
    common_fields()
    field(:first_seen, :utc_datetime)
    field(:last_seen, :utc_datetime)
    field(:count, :integer)
    field(:sighting_of_ref, Stixex.Types.Identifier)
    field(:observed_data_refs, {:array, Stixex.Types.Identifier})
    field(:where_sighted_refs, {:array, Stixex.Types.Identifier})
    field(:summary, :boolean)
  end

  def changeset(struct, params) do
    struct
    |> cast_common(params)
    |> cast(params, [:first_seen, :last_seen, :count, :sighting_of_ref, :observed_data_refs, :where_sighted_refs, :summary])
    |> validate_required(@required_fields)
  end
end
