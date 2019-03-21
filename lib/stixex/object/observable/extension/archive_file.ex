defmodule Stixex.Object.Observable.Extension.ArchiveFile do
  use Stixex.Object.Observable.Extension, type_name: "archive-ext"

  @required_fields [:contains_refs]

  embedded_schema do
    field(:contains_refs, {:array, Stixex.Types.ObjectRef})
    field(:version, :string)
    field(:comment, :string)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:contains_refs, :version, :comment])
    |> validate_required(@required_fields)
    |> validate_length(:contains_refs, min: 1)
  end
end
