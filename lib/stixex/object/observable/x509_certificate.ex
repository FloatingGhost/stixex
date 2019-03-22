defmodule StixEx.Object.Observable.X509Certificate do
  use StixEx.Object.Observable, type_name: "x509-certificate"

  embedded_schema do
    common_fields()
    field(:is_self_signed, :boolean)
    field(:hashes, StixEx.Types.Hashes)
    field(:version, :string)
    field(:serial_number, :string)
    field(:signature_algorithm, :string)
    field(:issuer, :string)
    field(:validity_not_before, :utc_datetime)
    field(:validity_not_after, :utc_datetime)
    field(:subject, :string)
    field(:subject_public_key_algorithm, :string)
    field(:subject_public_key_modulus, :string)
    field(:subject_public_key_exponent, :string)
    embeds_one(:x509_v3_extensions, StixEx.Types.X509V3Extensions)
  end

  def changeset(struct, params) do
    struct
    |> cast_common(params)
    |> cast(params, [
      :is_self_signed,
      :hashes,
      :version,
      :serial_number,
      :signature_algorithm,
      :issuer,
      :validity_not_before,
      :validity_not_after,
      :subject,
      :subject_public_key_algorithm,
      :subject_public_key_modulus,
      :subject_public_key_exponent
    ])
    |> cast_embed(:x509_v3_extensions)
  end
end
