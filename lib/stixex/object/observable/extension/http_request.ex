defmodule StixEx.Object.Observable.Extension.HTTPRequest do
  use StixEx.Object.Observable.Extension, type_name: "http-request-ext"

  @required_fields [:request_method, :request_value]

  embedded_schema do
    field :request_method, :string
    field :request_value, :string
    field :request_version, :string
    field :request_header, :map
    field :message_body_length, :integer
    field :message_body_data_ref, StixEx.Types.ObjectRef
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:request_method, :request_value, :request_version, :request_header, :message_body_length, :message_body_data_ref])
    |> validate_required(@required_fields)
  end
end
