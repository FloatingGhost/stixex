defmodule StixEx.Types.WindowsPEOptionalHeader do
  use Ecto.Schema
  import Ecto.Changeset

  @derive Jason.Encoder

  embedded_schema do
    field(:magic_hex, StixEx.Types.Hex)
    field(:major_linker_version, :integer)
    field(:minor_linker_version, :integer)
    field(:size_of_code, :integer)
    field(:size_of_initialized_data, :integer)
    field(:size_of_uninitialized_data, :integer)
    field(:address_of_entry_point, :integer)
    field(:base_of_code, :integer)
    field(:base_of_data, :integer)
    field(:image_base, :integer)
    field(:section_alignment, :integer)
    field(:file_alignment, :integer)
    field(:major_os_version, :integer)
    field(:minor_os_version, :integer)
    field(:major_image_version, :integer)
    field(:minor_image_version, :integer)
    field(:major_subsystem_version, :integer)
    field(:minor_subsystem_version, :integer)
    field(:win32_version_value_hex, StixEx.Types.Hex)
    field(:size_of_image, :integer)
    field(:size_of_headers, :integer)
    field(:checksum_hex, StixEx.Types.Hex)
    field(:subsystem_hex, StixEx.Types.Hex)
    field(:dll_characteristics_hex, StixEx.Types.Hex)
    field(:size_of_stack_reserve, :integer)
    field(:size_of_stack_commit, :integer)
    field(:size_of_heap_reserve, :integer)
    field(:size_of_heap_commit, :integer)
    field(:loader_flags_hex, StixEx.Types.Hex)
    field(:number_of_rva_and_sizes, :integer)
    field(:hashes, StixEx.Types.Hashes)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [
      :magic_hex,
      :major_linker_version,
      :minor_linker_version,
      :size_of_code,
      :size_of_initialized_data,
      :size_of_uninitialized_data,
      :address_of_entry_point,
      :base_of_code,
      :base_of_data,
      :image_base,
      :section_alignment,
      :file_alignment,
      :major_os_version,
      :minor_os_version,
      :major_image_version,
      :minor_image_version,
      :major_subsystem_version,
      :minor_subsystem_version,
      :win32_version_value_hex,
      :size_of_image,
      :size_of_headers,
      :checksum_hex,
      :subsystem_hex,
      :dll_characteristics_hex,
      :size_of_stack_reserve,
      :size_of_stack_commit,
      :size_of_heap_reserve,
      :size_of_heap_commit,
      :loader_flags_hex,
      :number_of_rva_and_sizes,
      :hashes
    ])
  end
end
