defmodule StixEx.Types.X509V3Extensions do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field(:basic_constraints, :string)
    field(:name_constraints, :string)
    field(:policy_constraints, :string)
    field(:key_usage, :string)
    field(:extended_key_usage, :string)
    field(:subject_key_identifier, :string)
    field(:authority_key_identifier, :string)
    field(:subject_alternative_name, :string)
    field(:issuer_alternative_name, :string)
    field(:subject_directory_attributes, :string)
    field(:crl_distribution_points, :string)
    field(:inhibit_any_policy, :string)
    field(:private_key_usage_period_not_before, :utc_datetime)
    field(:private_key_usage_period_not_after, :utc_datetime)
    field(:certificate_policies, :string)
    field(:policy_mappings, :string)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [
      :basic_constraints,
      :name_constraints,
      :policy_constraints,
      :key_usage,
      :extended_key_usage,
      :subject_key_identifier,
      :authority_key_identifier,
      :subject_alternative_name,
      :issuer_alternative_name,
      :subject_directory_attributes,
      :crl_distribution_points,
      :inhibit_any_policy,
      :private_key_usage_period_not_before,
      :private_key_usage_period_not_after,
      :certificate_policies,
      :policy_mappings
    ])
  end
end
