defmodule StixEx.Object.Observable do
  import Ecto.Changeset

  defmacro __using__(opts \\ [type_name: "observable"]) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset
      import StixEx.Object.Observable
      import StixEx.Validation

      @behaviour StixEx.Object
      @primary_key false
      @type_name unquote(opts[:type_name])
      @derive Jason.Encoder
    end
  end

  @doc """
  Common functions for observable objects

  injects:
    - new/1
  """
  defmacro common_functions do
    quote do
      def new(params) do
        new_changeset = changeset(%__MODULE__{}, params)

        if new_changeset.valid? do
          Ecto.Changeset.apply_action(new_changeset, :insert)
        else
          {:error, {:invalid, new_changeset}}
        end
      end
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
  end
end
