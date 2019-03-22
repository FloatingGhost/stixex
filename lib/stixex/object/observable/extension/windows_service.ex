defmodule StixEx.Object.Observable.Extension.WindowsService do
  use StixEx.Object.Observable.Extension, type_name: "windows-service-ext"

  @required_fields [:service_name]

  embedded_schema do
    field :service_name, :string
    field :descriptions, {:array, :string}
    field :display_name, :string
    field :group_name, :string
    field :start_type, :string
    field :service_dll_refs, {:array, StixEx.Types.ObjectRef}
    field :service_type, :string
    field :service_status, :string
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:service_name, :descriptions, :display_name, :group_name, :start_type, :service_dll_refs, :service_type, :service_status])
    |> validate_required(@required_fields)
    |> validate_change(:start_type, validate_values_in_enum("windows-service-start-type-enum"))
    |> validate_change(:service_type, validate_values_in_enum("windows-service-type-enum"))
    |> validate_change(:service_status, validate_values_in_enum("windows-service-status-enum"))
  end
end
