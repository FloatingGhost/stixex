defmodule StixEx.Object.ObservedData do
  use StixEx.Object, type_name: "observed-data"

  @required_fields [:first_observed, :last_observed, :number_observed, :objects]

  embedded_schema do
    common_fields()
    field(:first_observed, :utc_datetime)
    field(:last_observed, :utc_datetime)
    field(:number_observed, :integer)
    field(:objects, :map)
  end

  common_functions()

  def changeset(struct, params) do
    struct
    |> cast_common(params)
    |> cast(params, [:first_observed, :last_observed, :number_observed, :objects])
    |> validate_required(@required_fields)
  end
end
