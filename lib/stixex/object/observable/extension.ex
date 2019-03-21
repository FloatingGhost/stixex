defmodule StixEx.Object.Observable.Extension do
  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset
      import StixEx.Validation
      alias StixEx.Object.Observable.Extension
    end
  end
end
