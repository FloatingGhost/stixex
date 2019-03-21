defmodule Stixex.Object.Observable.Extension.NTFS do
  use Stixex.Object.Observable.Extension, type_name: "ntfs-ext"

  embedded_schema do
    field :sid, :string
    embeds_many :alternate_data_streams, Stixex.Types.AlternateDataStream
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:sid])
    |> cast_embed(:alternate_data_streams, with: &Stixex.Types.AlternateDataStream.changeset/2)
  end
end
