defmodule StixEx.Object.Observable.EmailMessage do
  use StixEx.Object.Observable, type_name: "email-message"

  @required_fields [:is_multipart]

  # end my life
  embedded_schema do
    common_fields()
    field(:is_multipart, :boolean)
    field(:date, :utc_datetime)
    field(:content_type, :string)
    field(:from_ref, StixEx.Types.ObjectRef)
    field(:sender_ref, StixEx.Types.ObjectRef)
    field(:to_refs, StixEx.Types.ObjectRef)
    field(:cc_refs, StixEx.Types.ObjectRef)
    field(:bcc_refs, StixEx.Types.ObjectRef)
    field(:subject, :string)
    field(:received_lines, {:array, :string})
    field(:additional_header_fields, :map)
    field(:body, :string)
    field(:raw_email_ref, StixEx.Types.ObjectRef)

    embeds_many(:body_multipart, StixEx.Types.MimePart)
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
    |> cast_embed(:body_multipart, with: &StixEx.Types.MimePart.changeset/2)
    |> validate_required(@required_fields)
  end
end
