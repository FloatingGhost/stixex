defmodule Stixex.Objects.ObservedData do
  use Stixex.Objects, type_name: "observed-data"

  @required_fields [:first_observed, :last_observed, :number_observed, :objects]

  embedded_schema do
    common_fields()
    first_and_last_seen(first_seen: :first_observed, last_seen: :last_observed)
    field :number_observed, :integer
    field :objects, :map
  end

  def changeset(struct, params) do
    struct
    |> cast_common(params)
    |> cast(params, [:first_observed, :last_observed, :number_observed, :objects])
    |> validate_required(@required_fields)
  end
end
