defmodule StixEx.Object do
  @moduledoc """
  Wrapper type to cast to other embeds
  """
  import Ecto.Changeset

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

  @callback changeset(term, term) :: term

  defmacro __using__(opts) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset
      import StixEx.Object
      import StixEx.Validation
      @behaviour StixEx.Object
      @primary_key {:id, StixEx.Types.Identifier, []}
      @type_name unquote(opts[:type_name])
      @after_compile __MODULE__

      register_type()
      defp generate_id do
        StixEx.Types.Identifier.generate(unquote(opts[:type_name]))
      end
    end
  end

  defmacro register_type do
    quote do
      def __after_compile__(_env, _bytecode) do
        StixEx.Object.register_type(@type_name, __MODULE__)
      end
    end
  end


  def register_type(type_name, module) do
    table = 
      case :ets.whereis(:type_registry) do
        :undefined ->
          :ets.new(:type_registry, [:set, :named_table, :public])
        table -> table
      end

    IO.inspect type_name
    :ets.insert(:type_registry, {type_name, module})
  end

  defmacro common_fields do
    quote do
      field(:type, :string, default: @type_name)
      field(:created_by_ref, StixEx.Types.Identifier)
      field(:revoked, :boolean, default: false)
      field(:labels, {:array, :string})
      field(:object_marking_refs, {:array, StixEx.Types.Identifier})
      field(:created, :utc_datetime)
      field(:modified, :utc_datetime)

      embeds_many(:external_references, StixEx.Types.ExternalReference)
      embeds_many(:granular_markings, StixEx.Types.GranularMarking)
    end
  end

  defmacro first_and_last_seen(opts \\ [first_seen: :first_seen, last_seen: :last_seen]) do
    quote do
      field(unquote(opts[:first_seen]), :utc_datetime)
      field(unquote(opts[:last_seen]), :utc_datetime)
    end
  end

  defmacro name_and_description do
    quote do
      field(:name, :string)
      field(:description, :string)
    end
  end

  defmacro kill_chain_phases do
    quote do
      field(:kill_chain_phases, {:array, StixEx.Types.KillChainPhase})
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
