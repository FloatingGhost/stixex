defmodule StixEx.Object.CourseOfAction do
  use StixEx.Object, type_name: "course-of-action"

  @required_fields [:name]

  embedded_schema do
    common_fields()
    name_and_description()
  end

  def changeset(struct, params) do
    struct
    |> cast_common(params)
    |> cast(params, [:name, :description])
    |> validate_required(@required_fields)
  end
end
