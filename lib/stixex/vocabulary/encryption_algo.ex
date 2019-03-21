defmodule Stixex.Vocabularies.EncryptionAlgo do
  @moduledoc """
  An open vocabulary of encryption algorithms.
  """

  def values do
    ~w[
      AES128-ECB
      AES128-CBC
      AES128-CFB
      AES128-OFB
      AES128-CTR
      AES128-XTS
      AES128-GCM
      Salsa20
      Salsa12
      Salsa8
      ChaCha20-Poly1305
      ChaCha20
      DES-CBC
      3DES-CBC
      DES-ECB
      3DES-ECB
      CAST128-CBC
      CAST256-CBC
      RSA
      DSA
  ]
  end
end
