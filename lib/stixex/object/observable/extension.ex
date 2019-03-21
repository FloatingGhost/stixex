defmodule Stixex.Object.Observable.Extension do
  defmacro __using__(_) do
    use Ecto.Schema
    import Ecto.Changeset
    import Stixex.Validation
    alias Stixex.Object.Observable.Extension
  end
end
