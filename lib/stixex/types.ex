defmodule Stixex.Types do
  import Ecto.Changeset

  @doc """
  If an ID is not explicitly set by a cast, generate one!
  """
  def generate_id_if_not_set(changeset, type_name, opts \\ [id_field: :id])

  def generate_id_if_not_set(%{changes: %{id: _id}} = changeset, _type_name, _opts) do
    changeset
  end

  def generate_id_if_not_set(%{changes: %{}} = changeset, type_name, opts) do
    changeset
    |> put_change(opts[:id_field], Stixex.Types.Identifier.generate(type_name))
  end

  def put_if_not_set(%{changes: %{} = changes} = changeset, field, value) do
    if Map.has_key?(changes, field) do
      changeset
    else
      changeset
      |> put_change(field, value)
    end
  end
end
