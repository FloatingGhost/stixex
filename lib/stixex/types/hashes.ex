defmodule Stixex.Types.Hashes do
  @moduledoc """
  The Hashes type represents 1 or more cryptographic hashes,
  as a special set of key/value pairs.

  Accordingly, the name of each hashing algorithm MUST be specified as a
  key in the dictionary and MUST identify the name of the hashing algorithm 
  used to generate the corresponding value.

  This name SHOULD either be one of the values defined in the hash-algorithm-ov 
  OR a custom value prepended with “x_” (e.g., “x_custom_hash”).
  """
  @behaviour Ecto.Type
  @vocabulary "hash-algorithm-ov"

  def type, do: :map

  defp key_matches_regex?(key) do
    ~r/[a-zA-Z0-9-_]{3, 255}/
    |> Regex.match?(key)
  end

  defp valid_key?("x_" <> _key_name = custom_key) do
    key_matches_regex?(custom_key)
  end

  defp valid_key?(key) do
    {:ok, vocabulary} =
      @vocabulary
      |> Stixex.Vocabularies.get()

    vocabulary
    |> Stixex.Vocabularies.has_value?(key)
  end

  @doc """
  Assert that all keys match what we expect

    iex> Stixex.Types.Hashes.cast(%{"SHA-1": "asdf"})
    {:ok, %{"SHA-1": "asdf"}}

    iex> Stixex.Types.Hashes.cast(%{"x_custom_hash": "abc"})
    {:ok, %{"x_custom_hash": "abc"}}

    iex> Stixex.Types.Hashes.cast(%{"ohno-hash": "abc"})
    :error
  """
  def cast(%{} = hashes) do
    keys_valid? =
      hashes
      |> Map.keys()
      |> Enum.all?(&valid_key?/1)

    if keys_valid? do
      {:ok, hashes}
    else
      :error
    end
  end

  # Technically we don't need to care about these since we're
  # only using ecto for validation, but it's required!!
  def load(%{} = hashes), do: {:ok, hashes}
  def dump(%{} = hashes), do: {:ok, hashes}
end
