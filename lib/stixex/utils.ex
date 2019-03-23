defmodule StixEx.Utils do
  import Ecto.Changeset

  def put_if_not_set(%{changes: %{} = changes} = changeset, field, value) do
    if Map.has_key?(changes, field) do
      changeset
    else
      changeset
      |> put_change(field, value)
    end  
  end 

  def kebab_case_to_upper_camel_case(string) do
    string
    |> String.split("-")
    |> Enum.map(&String.capitalize/1)
    |> Enum.join("")
  end
end
