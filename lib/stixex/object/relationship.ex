defmodule StixEx.Object.Relationship do
  use StixEx.Object, type_name: "relationship"

  @required_fields [:type, :relationship_type, :source_ref, :target_ref]

  embedded_schema do
    common_fields()
    field(:relationship_type, :string)
    field(:description, :string)
    field(:source_ref, StixEx.Types.Identifier)
    field(:target_ref, StixEx.Types.Identifier)
  end

  def changeset(struct, params) do
    struct
    |> cast_common(params)
    |> validate_required(@required_fields)
    |> validate_format(:relationship_type, ~r/[a-z0-9-]+/)
  end

  def possible_relationships do
    [
      ~w[attack-pattern targets vulnerability],
      ~w[attack-pattern targets identity],
      ~w[attack-pattern uses malware],
      ~w[attack-pattern uses tool],
      ~w[campaign attributed-to intrusion-set],
      ~w[campaign attributed-to threat-actor],
      ~w[campaign targets identity],
      ~w[campaign targets vulnerability],
      ~w[course-of-action mitigates attack-pattern],
      ~w[course-of-action mitigates malware],
      ~w[course-of-action mitigates tool],
      ~w[course-of-action mitigates vulnerability],
      ~w[indicator indicates attack-pattern],
      ~w[indicator indicates campaign],
      ~w[indicator indicates intrusion-set],
      ~w[indicator indicates malware],
      ~w[indicator indicates threat-actor],
      ~w[indicator indicates tool],
      ~w[intrusion-set attributed-to threat-actor],
      ~w[intrusion-set targets identity],
      ~w[intrusion-set targets vulnerability],
      ~w[intrusion-set uses attack-pattern],
      ~w[intrusion-set uses malware],
      ~w[intrusion-set uses tool],
      ~w[malware targets identity],
      ~w[malware targets vulnerability],
      ~w[malware uses tool],
      ~w[malware variant-of malware],
      ~w[threat-actor attributed-to identity],
      ~w[threat-actor impersonates identity],
      ~w[threat-actor uses attack-pattern],
      ~w[threat-actor uses malware],
      ~w[threat-actor uses tool],
      ~w[tool targets identity],
      ~w[tool targets vulnerability]
    ]
  end
end
