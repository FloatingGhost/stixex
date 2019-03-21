defmodule Stixex.Objects do
  @moduledoc """
  Wrapper type to cast to other embeds
  """
  import Ecto.Changeset

  @primary_key false
  @common_field_names [
    :type,
    :id,
    :created_by_ref,
    :revoked,
    :labels,
    :object_marking_refs,
    :created,
    :modified
  ]

  defmacro common_fields do
    quote do
      field(:type, :string, default: @type_name)
      field(:created_by_ref, Stixex.Types.Identifier)
      field(:revoked, :boolean, default: false)
      field(:labels, {:array, :string})
      field(:object_marking_refs, {:array, Stixex.Types.Identifier})
      field(:created, :utc_datetime)
      field(:modified, :utc_datetime)

      embeds_many(:external_references, Stixex.Types.ExternalReference)
      embeds_many(:granular_markings, Stixex.Types.GranularMarking)
    end
  end

  defmacro first_and_last_seen(opts \\ [first_seen: :first_seen, last_seen: :last_seen]) do
    quote do
      field unquote(opts[:first_seen]), :utc_datetime
      field unquote(opts[:last_seen]), :utc_datetime
    end
  end

  defmacro valid_from_until do
    quote do
      field :valid_from, :utc_datetime
      field :valid_until, :utc_datetime
    end
  end

  defmacro name_and_description do
    quote do
      field :name, :string
      field :description, :string
    end
  end

  defmacro kill_chain_phases do
    quote do
      field(:kill_chain_phases, {:array, Stixex.Types.KillChainPhase})
    end
  end

  defmacro __using__(opts) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset
      import Stixex.Objects

      @primary_key {:id, Stixex.Types.Identifier, []}
      @type_name unquote(opts[:type_name])

      defp generate_id do
        Stixex.Types.Identifier.generate(unquote(opts[:type_name]))
      end
    end
  end

  def cast_common(changeset, params) do
    changeset
    |> cast(params, @common_field_names)
    |> cast_embed(:external_references)
    |> cast_embed(:granular_markings)
  end

  defp truncate_time(timestamp) do
    DateTime.truncate(timestamp, :millisecond)
  end
end
