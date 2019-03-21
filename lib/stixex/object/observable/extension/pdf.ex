defmodule Stixex.Object.Observable.Extension.PDF do
  use Stixex.Object.Observable.Extension, type_name: "pdf-ext"

  embedded_schema do
    field(:version, :string)
    field(:is_optimized, :boolean)
    field(:document_info_dict, :map)
    field(:pdfid0, :string)
    field(:pdfid1, :string)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:version, :is_optimized, :document_info_dict, :pdfid0, :pdfid1])
  end
end
