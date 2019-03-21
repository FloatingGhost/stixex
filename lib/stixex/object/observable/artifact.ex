defmodule Stixex.Object.Observable.Artifact do
  @moduledoc """
  The Artifact Object permits capturing an array of bytes (8-bits),
  as a base64-encoded string, or linking to a file-like payload.
  The size of the base64-encoded data captured in the payload_bin
  property MUST be less than or equal to 10MB.
  """
  use Stixex.Object.Observable, type_name: "artifact"

  embedded_schema do
    common_fields()
    field(:mime_type, :string)
    field(:payload_bin, :binary)
    field(:url, :string)
    field(:hashes, Stixex.Types.Hashes)
  end

  def changeset(struct, params) do
    struct
    |> cast_common(params)
    |> cast(params, [:mime_type, :payload_bin, :url, :hashes])
    |> validate_mutually_exclusive(:payload_bin, :url)
    |> validate_mutually_exclusive(:hashes, :url)
  end
end
