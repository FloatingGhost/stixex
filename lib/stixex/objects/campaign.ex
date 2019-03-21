defmodule Stixex.Objects.Campaign do
  use Stixex.Objects, type_name: "campaign"

  @required_fields [:name]

  embedded_schema do
    common_fields()
    name_and_description()
    first_and_last_seen()
    field :objective, :string
    field :aliases, {:array, :string}
  end

  def changeset(struct, params) do
    struct
    |> cast_common(params)
    |> cast(params, [:name, :description, :first_seen, :last_seen, :objective, :aliases])
    |> validate_required(@required_fields)
  end
end

