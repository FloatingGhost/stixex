defmodule StixEx.Object.Identity do
  use StixEx.Object, type_name: "identity"

  @required_fields [:name, :identity_class]

  embedded_schema do
    common_fields()
    name_and_description()
    field(:identity_class, :string)
    field(:sectors, {:array, :string})
    field(:contact_information, :string)
  end

  common_functions()

  def changeset(struct, params) do
    struct
    |> cast_common(params)
    |> cast(params, [:name, :description, :identity_class, :sectors, :contact_information])
    |> validate_required(@required_fields)
    |> validate_change(:identity_class, validate_values_in_vocab("identity-class-ov"))
    |> validate_change(:sectors, validate_values_in_vocab("industry-sector-ov"))
  end
end
