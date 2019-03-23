defmodule StixEx do
  @moduledoc """
  Documentation for StixEx, a STIX implementation.

  Refer to http://docs.oasis-open.org/cti/stix/v2.0/cs01/part1-stix-core/stix-v2.0-cs01-part1-stix-core.html#_Toc496709269
  for specification details

  Author's note:
    To whoever designed this "standard", go hecc yourself.
  """

  @doc """
  Load a stix bundle from file

      iex> StixEx.load("my_bundle.json")
      {:ok, %StixEx.Bundle{
        # stuff here
      }
  """
  def load(filename, opts \\ [format: :autodetect]) when is_binary(filename) do
    filetype = if opts[:format] == :autodetect do
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
