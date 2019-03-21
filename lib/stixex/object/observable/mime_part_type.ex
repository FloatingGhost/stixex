defmodule Stixex.Object.Observable.MimePartType do
  use Stixex.Object.Observable, type_name: "mime-part-type"

  embedded_schema do
    field(:body, :string)
    field(:body_raw_ref, Stixex.Types.ObjectRef)
    field(:content_type, :string)
    field(:content_disposition, :string)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:body, :body_raw_ref, :content_type, :content_disposition])
    |> validate_one_of([:body, :body_raw_ref])
  end
end
