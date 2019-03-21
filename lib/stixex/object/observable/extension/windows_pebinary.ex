defmodule Stixex.Object.Observable.Extension.WindowsPEBinary do
  use Stixex.Object.Observable.Extension, type_name: "windows-pe-binary"

  @required_fields [:pe_type]

  embedded_schema do
    field(:pe_type, :string)
    field(:imphash, :string)
    field(:machine_hex, :string)
    field(:number_of_sections, :integer)
    field(:time_date_stamp, :utc_datetime)
    field(:pointer_to_symbol_table_hex, :string)
    field(:number_of_symbols, :integer)
    field(:size_of_optional_header, :integer)
    field(:characteristics_hex, :string)
    field(:file_header_hashes, Stixex.Types.Hashes)
    embeds_one(:optional_header, Stixex.Types.WindowsPEOptionalHeader)
    embeds_many(:sections, Stixex.Types.WindowsPESection)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [
      :pe_type,
      :imphash,
      :machine_hex,
      :number_of_sections,
      :time_date_stamp,
      :pointer_to_symbol_table_hex,
      :number_of_symbols,
      :size_of_optional_header,
      :characteristics_hex,
      :file_header_hashes
    ])
    |> cast_embed(:optional_header)
    |> cast_embed(:sections)
    |> validate_required(@required_fields)
    |> validate_format(:pointer_to_symbol_table_hex, hex_format)
    |> validate_format(:characteristics_hex, hex_format)
  end
end
