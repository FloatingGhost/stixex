defmodule StixEx.Object.Observable.Extension.UnixAccount do
  use StixEx.Object.Observable.Extension, type_name: "unix-account-ext"

  embedded_schema do
    field :gid, :integer
    field :groups, {:array, :string}
    field :home_dir, :string
    field :shell, :string
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:gid, :groups, :home_dir, :shell])
  end
end
