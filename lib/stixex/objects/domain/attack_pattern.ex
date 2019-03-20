defmodule Stixex.Objects.Domain.AttackPattern do
  use Stixex.Objects

  @type_name "attack-pattern"

  embedded_schema do
    common_fields()
    field :name, :string
  end

  def changeset(struct, params) do
    struct
    |> cast_common(params)
    |> validate()
  end
end 
