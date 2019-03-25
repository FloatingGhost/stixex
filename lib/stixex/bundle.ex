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
    object = StixEx.Object.new(type, object)
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

  @doc """
  Load a stix bundle from string

      iex> StixEx.from_string("{...}")
      {:ok, %StixEx.Bundle{}}

      iex> StixEx.from_string("{...}", format: :json)
      {:ok, %StixEx.Bundle{}}

  currently supported formats: `:json`
  """
  def from_string(data, opts \\ [format: :json]) do
    {:ok, parsed} = parse_file_data(data, opts[:format])
    new(parsed)
  end

  @doc """
  Load a stix bundle from file

      iex> StixEx.from_file("my_bundle.json")
      {:ok, %StixEx.Bundle{
        # stuff here
      }}

  options:
    - `:format` - currently supported `:json`, `:autodetect` 
  """
  def from_file(filename, opts \\ [format: :autodetect]) when is_binary(filename) do
    filetype =
      if opts[:format] == :autodetect do
        {:ok, format} = infer_filetype(filename)
        format
      else
        opts[:format]
      end

    if File.exists?(filename) do
      {:ok, data} = File.read(filename)
      {:ok, parsed} = parse_file_data(data, filetype)
      StixEx.Bundle.new(parsed)
    else
      {:error, {:file_does_not_exist, filename}}
    end
  end

  defp infer_filetype(filename) do
    filename
    |> String.split(".")
    |> List.last()
    |> case do
      "json" -> {:ok, :json}
      "xml" -> {:ok, :xml}
      _other -> :error
    end
  end

  defp parse_file_data(data, :json) do
    Jason.decode(data)
  end

  @doc """
  Dump a STIX bundle to a specified format

      iex> StixEx.Bundle.to_string(%StixEx.Bundle{})
      {:ok, "{some_json}"}

  Opts:
    - `:serialiser` Any module implemeting StixEx.Serialiser behaviour. Defaults to
      StixEx.Serialiser.JSON.
  """
  def to_string(bundle, opts \\ [serialiser: StixEx.Serialiser.JSON]) do
    StixEx.Serialiser.dump(opts[:serialiser], bundle)
  end

  @doc """
  Dump a STIX bundle to disk

      iex> StixEx.Bundle.to_file(%StixEx.Bundle{}, "my_bundle.json")
      :ok
  """
  def to_file(bundle, filename, opts \\ [serialiser: StixEx.Serialiser.JSON]) do
    {:ok, string} = to_string(bundle, opts)
    File.write(filename, string)
  end
end
