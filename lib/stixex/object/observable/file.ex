defmodule StixEx.Object.Observable.File do
  use StixEx.Object.Observable, type_name: "file"

  embedded_schema do
    common_fields()
    field(:hashes, StixEx.Types.Hashes)
    field(:size, :integer)
    field(:name, :string)
    field(:name_enc, :string)
    field(:magic_number_hex, StixEx.Types.Hex)
    field(:mime_type, :string)
    field(:created, :utc_datetime)
    field(:modified, :utc_datetime)
    field(:accessed, :utc_datetime)
    field(:parent_directory_ref, StixEx.Types.ObjectRef)
    field(:is_encrypted, :boolean)
    field(:encryption_algorithm, :string)
    field(:decryption_key, :string)
    field(:contains_refs, {:array, StixEx.Types.ObjectRef})
    field(:content_ref, StixEx.Types.ObjectRef)
  end

  def changeset(struct, params) do
    struct
    |> cast_common(params)
    |> cast(params, [
      :hashes,
      :size,
      :name,
      :name_enc,
      :magic_number_hex,
      :mime_type,
      :created,
      :modified,
      :accessed,
      :parent_directory_ref,
      :is_encrypted,
      :encryption_algorithm,
      :decryption_key,
      :contains_refs,
      :content_ref
    ])
    |> validate_change(:encryption_algorithm, validate_values_in_vocab("encryption-algo-ov"))
  end
end
