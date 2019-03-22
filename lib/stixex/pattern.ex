defmodule StixEx.Pattern do
  @moduledoc """
  A parser for stix patterning. It's some fancy-pants set of expressions

  Writing parsers...
  wish me luck

  See part 5 of the spec
  """

  def parse(str) do
    str
    |> lex()
    |> case do
      {:ok, tokens, _} ->
        extract(tokens)
      error -> error
    end
  end
        
  def extract(tokens) do
    tokens
    |> :pattern_parser.parse()
  end
        
  def lex(str) do
    str
    |> to_charlist()
    |> :pattern_lexer.string()
  end
end 
