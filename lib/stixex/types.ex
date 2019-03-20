defmodule Stixex.Types do
  import Ecto.Changeset

  def put_if_not_set(%{changes: %{} = changes} = changeset, field, value) do
    if Map.has_key?(changes, field) do
      changeset
    else
      changeset
      |> put_change(field, value)
    end
  end

  def format_id(%{changes: %{id: id, type: type}} = changeset) do
    changeset
    |> put_change(:id, "#{type}--#{id}")
  end
end
