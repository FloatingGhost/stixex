defmodule StixExTest.Loader do
  use ExUnit.Case

  test "JSON loader" do
    {:ok, files} = File.ls("test/data/")

    for file <- files do
      StixEx.Bundle.from_file("test/data/" <> file)
      |> case do
        {:ok, _bundle} ->
          :ok

        {:error, errors} ->
          IO.inspect(errors)
          throw(:validation_error)
      end
    end
    |> Enum.all?(fn x -> x == :ok end)
  end
end
