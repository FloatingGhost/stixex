defmodule StixEx.Object.Observable.UserAccount do
  use StixEx.Object.Observable, type_name: "user-account"

  @required_fields [:user_id]

  embedded_schema do
    common_fields()
    field :user_id, :string
    field :account_login, :string
    field :account_type, :string
    field :display_name, :string
    field :is_service_account, :boolean
    field :is_privileged, :boolean
    field :can_escalate_privs, :boolean
    field :is_disabled, :boolean
    field :account_created, :utc_datetime
    field :account_expires, :utc_datetime
    field :password_last_changed, :utc_datetime
    field :account_first_login, :utc_datetime
    field :account_last_login, :utc_datetime
  end

  def changeset(struct, params) do
    struct
    |> cast_common(params)
    |> cast(params, [:user_id, :account_login, :account_type, :display_name, :is_service_account, :is_privileged, :can_escalate_privs, :is_disabled, :account_created, :account_expires, :password_last_changed, :account_first_login, :account_last_login])
    |> validate_required(@required_fields)
    |> validate_change(:account_type, validate_values_in_vocab("account-type-ov"))
  end
end
