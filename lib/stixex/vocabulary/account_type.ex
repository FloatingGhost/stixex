defmodule StixEx.Vocabulary.AccountType do
  @behaviour StixEx.Vocabulary

  @impl StixEx.Vocabulary
  def values do
    ~w[
      unix
      windows-local
      windows-domain
      ldap
      tacacs
      radius
      nis
      openid
      facebook
      skype
      twitter
    ]
  end
end
