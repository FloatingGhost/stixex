defmodule StixEx.Object.Observable.Extension.WindowsProcess do
  use StixEx.Object.Observable.Extension, type_name: "windows-process-ext"

  embedded_schema do
    field :asir_enabled, :boolean
    field :dep_enabled, :boolean
    field :priority, :string
    field :owner_sid, :string
    field :window_title, :string
    field :startup_info, :map
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:asir_enabled, :dep_enabled, :priority, :owner_sid, :window_title, :startup_info])
  end
end
