defmodule Stixex.Vocabulary do
  @moduledoc """
  Set vocabularies to make sure certain fields have certain
  values
  """

  @doc """
  Get a vocabulary module based on its my-vocab-ov name

      iex> Stixex.Vocabulary.get("hash-algorithm-ov")
      {:ok, Stixex.Vocabulary.HashAlgorithm}

      iex> Stixex.Vocabulary.get("my-silly-vocab-ov")
      {:error, {:does_not_exist, "my-silly-vocab-ov"}}

      iex> Stixex.Vocabulary.get("not-formatted")
      {:error, {:invalid_name, "not-formatted"}}
  """
  def get(name) when is_binary(name) do
    if String.ends_with?(name, "-ov") do
      module = 
        name
        |> String.trim_trailing("-ov")
        |> kebab_case_to_upper_camel_case()
        |> (&("#{__MODULE__}."<>&1)).()
        |> String.to_atom()

      has_values? = Keyword.has_key?(module.__info__(:functions), :values)

      if has_values? do
        {:ok, module}
      else
        {:error, {:does_not_exist, name}}
      end
    else
      {:error, {:invalid_name, name}}
    end
  end

  defp kebab_case_to_upper_camel_case(string) do
    string
    |> String.split("-")
    |> Enum.map(&String.capitalize/1)
    |> Enum.join("")
  end
end
