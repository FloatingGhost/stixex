defmodule Stixex.Types.Object do
  @moduledoc """
  Wrapper type to cast to other embeds
  """
  use Ecto.Schema

  embedded_schema do
  end

  def changeset(struct, params) do
  end
end
