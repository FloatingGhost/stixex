defmodule StixEx.Validation do
  @moduledoc """
  Some extra validations for checking some of the more esoteric requirements
  demanded by the spec
  """
  import Ecto.Changeset
  require Logger

  @doc """
  Ensure that AT LEAST ONE of the fields is present in the changeset

      iex> StixEx.Validation.validate_one_of(%{changes: %{my_field: 1}}, [:my_field])
      %{changes: %{my_field: 1}, valid?: true}

      iex> StixEx.Validation.validate_one_of(%{changes: %{}}, [:my_field])
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

  def validate_url(_field, url) do
    if ValidUrl.validate(url) do
      []
    else
      ["invalid URL"]
    end
  end

  @doc """
  Wrapper to generate our validation function. Essentially curries
  the validate function with a set vocabulary name so we don't have
  to do captures on every validation.

      iex> validate_values_in_vocab("threat-actor-role-ov")
      #Function<...>
  """
  def validate_values_in_vocab(vocabulary) do
    &validate_values_in_vocab(vocabulary, &1, &2)
  end

  @doc """
  Validate that a given value (or list of values) are members of a vocabulary.

  Will *enforce* key validity if :stixex, :enforce_vocabularies is set.
  """
  if Application.get_env(:stixex, :enforce_vocabularies) do
    def validate_values_in_vocab(vocabulary, _field, value) do
      if StixEx.Vocabulary.has_value?(vocabulary, value) do
        []
      else
        ["is not valid for #{vocabulary}"]
      end
    end
  else
    def validate_values_in_vocab(_vocabulary, _field, _value), do: []
  end

  def validate_values_in_enum(enum) do
    &validate_values_in_enum(enum, &1, &2)
  end

  def validate_values_in_enum(enum, _field, value) do
    if StixEx.Enum.has_value?(enum, value) do
      []
    else
      ["is not valid for #{enum}"]
    end
  end

  def validate_mutually_exclusive(%{changes: changes} = changeset, field_a, field_b) do
    if Map.has_key?(changes, field_a) and Map.has_key?(changes, field_b) do
      changeset
      |> add_error(field_a, "mutually exclusive with #{field_b}")
    else
      changeset
    end
  end

  def selector_format do
    property_name = "[a-z_]+"
    index = "\\[\\d+\\]"

    ~r/(#{property_name}\.|#{index}\.)*(#{property_name}|#{index})/
  end
end
