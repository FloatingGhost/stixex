defmodule Stixex.Object.Observable.Extension.RasterImage do
  use Stixex.Object.Observable.Extension, type_name: "raster-image-ext"

  embedded_schema do
    field(:image_height, :integer)
    field(:image_width, :integer)
    field(:bits_per_pixel, :integer)
    field(:image_compression_algorithm, :string)
    field(:exif_tags, :map)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [
      :image_height,
      :image_width,
      :bits_per_pixel,
      :image_compression_algorithm,
      :exif_tags
    ])
  end
end
