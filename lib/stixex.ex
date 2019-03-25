defmodule StixEx do
  @moduledoc """
  Documentation for StixEx, a STIX implementation.

  Refer to http://docs.oasis-open.org/cti/stix/v2.0/cs01/part1-stix-core/stix-v2.0-cs01-part1-stix-core.html
  for specification details

  Author's note:
    To whoever designed this "standard", go hecc yourself.

  Common load options:
    - format; specify the format of the data to load in case you don't use standard extensions (current supported: :json)
  """

  @doc """
  Load a stix bundle from string

      iex> StixEx.from_string("{...}")
      {:ok, %StixEx.Bundle{}}

      iex> StixEx.from_string("{...}", format: :json)
      {:ok, %StixEx.Bundle{}}
  """
  def from_string(data, opts \\ [format: :json]) do
    {:ok, parsed} = parse_file_data(data, opts[:format])
    StixEx.Bundle.new(parsed)
  end

  @doc """
  Load a stix bundle from file

      iex> StixEx.from_file("my_bundle.json")
      {:ok, %StixEx.Bundle{
        # stuff here
      }}
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
end
