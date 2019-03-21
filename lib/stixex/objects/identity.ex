defmodule Stixex.Objects.Identity do
  use Stixex.Objects, type_name: "identity"

  @required_fields [:name, :identity_class]

  embedded_schema do
    common_fields()
    name_and_description()
    field :identity_class, :string
    field :sectors, {:array, :string}
    field :contact_information, :string
  end

  def changeset(struct, params) do
    struct
    |> cast_common(params)
    |> cast(params, [:name, :description, :identity_class, :sectors, :contact_information])
    |> validate_required(@required_fields)
    |> Stixex.Validation.validate_values_in_vocab(:identity_class, "identity-class-ov")
    |> Stixex.Validation.validate_values_in_vocab(:sectors, "industry-sector-ov")
  end
end
