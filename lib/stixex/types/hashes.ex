defmodule Stixex.Types.Hashes do
  @moduledoc """
  The Hashes type represents 1 or more cryptographic hashes, as a special set of key/value pairs.
  Accordingly, the name of each hashing algorithm MUST be specified as a key in the dictionary
  and MUST identify the name of the hashing algorithm used to generate the corresponding value.

  This name SHOULD either be one of the values defined in the hash-algorithm-ov 
  OR a custom value prepended with “x_” (e.g., “x_custom_hash”).
  """
end
