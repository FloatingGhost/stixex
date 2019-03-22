defmodule StixEx.Object.Observable.Process do
  use StixEx.Object.Observable, type_name: "process"

  embedded_schema do
    common_fields()
    field(:is_hidden, :boolean)
    field(:pid, :integer)
    field(:name, :string)
    field(:created, :utc_datetime)
    field(:cwd, :string)
    field(:arguments, {:array, :string})
    field(:command_line, :string)
    field(:environment_varaibles, :map)
    field(:opened_connection_refs, {:array, StixEx.Types.ObjectRef})
    field(:creator_user_ref, StixEx.Types.ObjectRef)
    field(:binary_ref, StixEx.Types.ObjectRef)
    field(:parent_ref, StixEx.Types.ObjectRef)
    field(:child_refs, {:array, StixEx.Types.ObjectRef})
  end

  def changeset(struct, params) do
    struct
    |> cast_common(params)
    |> cast(params, [
      :is_hidden,
      :pid,
      :name,
      :created,
      :cwd,
      :arguments,
      :command_line,
      :environment_varaibles,
      :opened_connection_refs,
      :creator_user_ref,
      :binary_ref,
      :parent_ref,
      :child_refs
    ])
  end
end
