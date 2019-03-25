defmodule StixExTest.Serialiser.JSON do
  use ExUnit.Case

  test "JSON serialiser" do
    {:ok, files} = File.ls("test/data/")

    for file <- files do
      StixEx.Bundle.from_file("test/data/" <> file)
      |> case do
        {:ok, bundle} ->
          {:ok, data} = StixEx.Bundle.to_string(bundle, serialiser: StixEx.Serialiser.JSON)

        {:error, errors} ->
          IO.inspect(errors)
          throw(:validation_error)
      end
    end
    |> Enum.all?(fn x -> x == :ok end)
  end
end
