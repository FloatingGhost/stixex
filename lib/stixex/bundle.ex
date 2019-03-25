defmodule StixEx.Bundle do
  @moduledoc """
  A Bundle is a collection of arbitrary STIX Objects and Marking Definitions grouped together in a single container.
  A Bundle does not have any semantic meaning and Objects are not considered related by virtue of being in the same Bundle.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias StixEx.{
    Types,
    Utils
  }

  @derive Jason.Encoder
  @type_name "bundle"
  @spec_version "2.0"
  @primary_key false
  @required_fields [:type, :id, :spec_version]

  embedded_schema do
    field(:type, :string)
    field(:id, Types.Identifier)
    field(:spec_version, :string)
    field(:objects, {:array, StixEx.Types.Object}, default: [])
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:id, :spec_version, :objects])
    |> Utils.put_if_not_set(:id, StixEx.Types.Identifier.generate(@type_name))
    |> Utils.put_if_not_set(:type, @type_name)
    |> Utils.put_if_not_set(:spec_version, @spec_version)
    |> validate_length(:objects, min: 1)
    |> validate_required(@required_fields)
  end

  @doc """
  Create a new bundle

      iex> StixEx.Bundle.new()
      {:ok, %StixEx.Bundle{}}
  """
  def new do
    new(%{})
  end

  @doc """
  Create a new bundle with specified parameters

      iex> StixEx.Bundle.new(%{objects: []})
      {:ok, %StixEx.Bundle{}}
  """
  def new(params) do
    this_changeset = changeset(%StixEx.Bundle{}, params)

    if this_changeset.valid? do
      Ecto.Changeset.apply_action(this_changeset, :insert)
    else
      {:error, {:invalid, this_changeset}}
    end
  end

  @doc """
  Add an object to a stix bundle

      iex> {:ok, my_object} = StixEx.Object.Observable.IPv4Addr.new(%{value: "8.8.8.8"})
      iex> {:ok, my_bundle} = StixEx.Bundle.new()
      iex> StixEx.Bundle.add_object(my_bundle, my_object)
  """
  def add_object(%StixEx.Bundle{} = bundle, %_object{type: _} = object) do
    bundle
    |> Map.put(:objects, [object | bundle.objects])
  end

  def add_object(%StixEx.Bundle{} = bundle, %{"type" => type} = object) do
    object =
      StixEx.Object.new(type, object)
    add_object(bundle, object)
  end

  @doc """
  Add multiple objects to a bundle
  """
  def add_objects(%StixEx.Bundle{} = bundle, []), do: bundle

  def add_objects(%StixEx.Bundle{} = bundle, [object | rest]) do
    bundle
    |> add_object(object)
    |> add_objects(rest)
  end

end
