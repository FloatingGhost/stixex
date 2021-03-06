defmodule StixEx.Vocabulary do
  @moduledoc """
  Set vocabularies to restrict the values of certain fields to one of a given list

  See specification section 6
  """

  @callback values :: [String.t()]

  @doc """
  Get a vocabulary module based on its my-vocab-ov name

      iex> StixEx.Vocabulary.get("hash-algorithm-ov")
      {:ok, StixEx.Vocabulary.HashAlgorithm}

      iex> StixEx.Vocabulary.get("my-silly-vocab-ov")
      {:error, {:does_not_exist, "my-silly-vocab-ov"}}

      iex> StixEx.Vocabulary.get("not-formatted")
      {:error, {:invalid_name, "not-formatted"}}
  """
  def get(name) when is_binary(name) do
    if String.ends_with?(name, "-ov") do
      module =
        name
        |> String.trim_trailing("-ov")
        |> StixEx.Utils.kebab_case_to_upper_camel_case()
        |> (&("#{__MODULE__}." <> &1)).()

      try do
        module = String.to_existing_atom(module)
        {:ok, module}
      rescue
        _e in ArgumentError -> {:error, {:does_not_exist, name}}
      end
    else
      {:error, {:invalid_name, name}}
    end
  end

  @doc """
  Get a vocabulary, throwing an error if it doesn't exist
  """
  def get!(name) when is_binary(name) do
    case get(name) do
      {:ok, vocab_module} ->
        vocab_module

      {:error, _reason} ->
        throw("Cannot get #{name}")
    end
  end

  @doc """
  Is a given value valid for a vocabulary?

      iex> StixEx.Vocabulary.has_value?(StixEx.Vocabulary.HashAlgorithm, "MD5")
      true

      iex> StixEx.Vocabulary.has_value?("hash-algorithm-ov", "MD5")
      true

      iex> StixEx.Vocabulary.has_value?("hash-algorithm-ov", "notahash")
      false
  """
  def has_value?(vocabulary, value) when is_list(value) do
    value
    |> Enum.all?(&has_value?(vocabulary, &1))
  end

  def has_value?(vocabulary, value) when is_atom(vocabulary) and is_binary(value) do
    Enum.member?(vocabulary.values(), value)
  end

  def has_value?(vocabulary, value) when is_atom(vocabulary) and is_atom(value) do
    has_value?(vocabulary, to_string(value))
  end

  def has_value?(vocabulary, value) when is_binary(vocabulary) do
    vocab = get(vocabulary)

    case vocab do
      {:ok, vocab_module} ->
        has_value?(vocab_module, value)

      {:error, _reason} ->
        false
    end
  end
end
