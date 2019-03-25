defmodule StixEx.Object.Observable.WindowsRegistryKey do
  use StixEx.Object.Observable, type_name: "windows-registry-key"

  @required_fields [:key]

  embedded_schema do
    common_fields()
    field(:key, :string)
    field(:modified, :utc_datetime)
    field(:creator_user_ref, StixEx.Types.ObjectRef)
    field(:number_of_subkeys, :integer)
    embeds_many(:values, StixEx.Types.WindowsRegistryValue)
  end

  common_functions()

  def changeset(struct, params) do
    struct
    |> cast_common(params)
    |> cast(params, [:key, :modified, :creator_user_ref, :number_of_subkeys])
    |> cast_embed(:values)
    |> validate_required(@required_fields)
  end
end
