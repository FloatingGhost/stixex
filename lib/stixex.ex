defmodule StixEx do
  @moduledoc """
  Documentation for StixEx, a STIX implementation.

  Refer to http://docs.oasis-open.org/cti/stix/v2.0/cs01/part1-stix-core/stix-v2.0-cs01-part1-stix-core.html#_Toc496709269
  for specification details

  Author's note:
    To whoever designed this "standard", go hecc yourself.
  """

  def load(filename) when is_binary(filename) do
    if File.exists?(filename) do
      data = File.read(filename)
      
    else
      {:error, {:file_does_not_exist, filename}}
    end
  end
end
