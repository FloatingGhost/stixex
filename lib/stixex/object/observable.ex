defmodule Stixex.Object.Observable do
  import Ecto.Changeset

  @required_fields [:type]

  defmacro __using__(opts \\ [type_name: "observable"]) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset
      import Stixex.Object.Observable
      import Stixex.Validation

      @primary_key false
      @type_name unquote(opts[:type_name])
    end
  end

  defmacro common_fields do
    quote do
      field(:type, :string, default: @type_name)
      field(:extensions, :map)
    end
  end

  def cast_common(changeset, params) do
    changeset
    |> cast(params, [:type, :extensions])
    |> validate_required(@required_fields)
  end
end
