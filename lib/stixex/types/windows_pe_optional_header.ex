defmodule Stixex.Types.WindowsPEOptionalHeader do
  use Ecto.Schema
  import Ecto.Changeset
  import Stixex.Validation

  embedded_schema do
    field :magic_hex, :string
    field :major_linker_version, :integer
    field :minor_linker_version, :integer
    field :size_of_code, :integer
    field :size_of_initialized_data, :integer
    field :size_of_uninitialized_data, :integer
    field :address_of_entry_point, :integer
    field :base_of_code, :integer
    field :base_of_data, :integer
    field :image_base, :integer
    field :section_alignment, :integer
    field :file_alignment, :integer
    field :major_os_version, :integer
    field :minor_os_version, :integer
    field :major_image_version, :integer
    field :minor_image_version, :integer
    field :major_subsystem_version, :integer
    field :win32_version_value_hex, :string
    field :size_of_image, :integer
    field :size_of_headers, :integer
    field :checksum_hex, :string
    field :subsystem_hex, :string
    field :dll_characteristics_hex, :string
    field :size_of_stack_reserve, :integer
    field :size_of_stack_commit, :integer
    field :size_of_heap_reserve, :integer
    field :size_of_heap_commit, :integer
    field :loader_flags_hex, :string
    field :number_of_rva_and_sizes, :integer
    field :hashes, Stixex.Types.Hashes
  end
end
