defmodule Stixex.Validation do
  @moduledoc """
  Some extra validations for checking some of the more esoteric requirements
  demanded by the spec
  """
  import Ecto.Changeset

  @doc """
  Ensure that AT LEAST ONE of the fields is present in the changeset

      iex> Stixex.Validation.validate_one_of(%{changes: %{my_field: 1}}, [:my_field])
      %{changes: %{my_field: 1}, valid?: true}

      iex> Stixex.Validation.validate_one_of(%{changes: %{}}, [:my_field])
      %{changes: %{}, valid?: false}
  """
  def validate_one_of(%{changes: %{} = changes} = changeset, fields \\ []) do
    ok? =
      fields
      |> Enum.any?(&Map.has_key?(changes, &1))

    if ok? do
      changeset
    else
      expected_fields = Enum.map(fields, &to_string/1)
      add_error(changeset, :one_of, "Expected one of #{expected_fields} to be defined")
    end
  end

  def validate_url(%{changes: %{} = changes} = changeset, field) do
    if Map.has_key?(changes, field) do
      if ValidUrl.validate(changes[field]) do
        # okiedokie!
        changeset
      else
        add_error(changeset, field, "URL not valid")
      end
    else
      # key wasn't even specified, we're cool
      changeset
    end
  end

  def validate_values_in_vocab(%{changes: %{} = changes} = changeset, field, vocabulary) do
    if Map.has_key?(changes, field) do
      if Stixex.Vocabularies.has_value?(vocabulary, changes[field]) do
        vocabulary
      else
        add_error(changeset, field, "is not valid for #{vocabulary}")
      end
    else
      changeset
    end
  end
end
