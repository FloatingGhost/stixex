defmodule StixEx.Object do
  @moduledoc """
  An object is a set of STIX data with a set schema.
  The awkward part here is that is can be any kind of type,
  and they all sit in the same array. 
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

  @callback new(term) :: term
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
    end
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

  defmacro common_functions do
    quote do
      def new(params) do
        new_changeset = 
          changeset(%__MODULE__{}, params)
          |> StixEx.Utils.put_if_not_set(:id, StixEx.Types.Identifier.generate(@type_name))
        
        if new_changeset.valid? do
          Ecto.Changeset.apply_action(new_changeset, :insert)
        else
          {:error, {:invalid, new_changeset}}
        end
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
