defmodule Stixex.Vocabulary.HashAlgorithm do
  def values do
    ~w[
      MD5
      MD6 
      RIPEMD-160
      SHA-1
      SHA-224
      SHA-256
      SHA-384
      SHA-512
      SHA3-224
      SHA3-256
      SHA3-384
      SHA3-512
      SSDEEP
      WHIRLPOOL
    ]
  end
end
