defmodule Stixex.Object.Observable.EmailMessage do
  use Stixex.Object.Observable, type_name: "email-message"

  @required_fields [:is_multipart]

  # end my life
  embedded_schema do
    common_fields()
    field(:is_multipart, :boolean)
    field(:date, :utc_datetime)
    field(:content_type, :string)
    field(:from_ref, Stixex.Types.ObjectRef)
    field(:sender_ref, Stixex.Types.ObjectRef)
    field(:to_refs, Stixex.Types.ObjectRef)
    field(:cc_refs, Stixex.Types.ObjectRef)
    field(:bcc_refs, Stixex.Types.ObjectRef)
    field(:subject, :string)
    field(:received_lines, {:array, :string})
    field(:additional_header_fields, :map)
    field(:body, :string)
    field(:raw_email_ref, Stixex.Types.ObjectRef)

    embeds_many(:body_multipart, Stixex.Types.MimePartType)
  end

  def changeset(struct, params) do
    struct
    |> cast_common(params)
    |> cast(params, [
      :is_multipart,
      :date,
      :content_type,
      :from_ref,
      :sender_ref,
      :to_refs,
      :cc_refs,
      :bcc_refs,
      :subject,
      :received_lines,
      :additional_header_fields,
      :body,
      :raw_email_ref
    ])
    |> cast_embed(:body_multipart, with: &Stixex.Types.MimePartType.changeset/2)
    |> validate_required(@required_fields)
  end
end
