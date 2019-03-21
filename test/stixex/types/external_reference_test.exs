defmodule StixExTest.Types.ExternalReference do
  use ExUnit.Case

  alias StixEx.Types.ExternalReference

  test "Example data should be valid" do
    params = %{
      source_name: "veris",
      external_id: "0001AA7F-C601-424A-B2B8-BE6C9F5164E7",
      url:
        "https://github.com/vz-risk/VCDB/blob/master/data/json/0001AA7F-C601-424A-B2B8-BE6C9F5164E7.json",
      hashes: %{
        "SHA-256": "6db12788c37247f2316052e142f42f4b259d6561751e5f401a1ae2a6df9c674b"
      }
    }

    changeset = ExternalReference.changeset(%ExternalReference{}, params)
    assert changeset.valid? == true
  end

  test "The source_name property MUST be present" do
    params = %{}
    changeset = ExternalReference.changeset(%ExternalReference{}, params)
    assert changeset.valid? == false
  end

  test "At least one of the description, url, or external_id properties MUST be present" do
    params = %{
      source_name: "veris"
    }

    changeset = ExternalReference.changeset(%ExternalReference{}, params)
    assert changeset.valid? == false

    params = %{
      source_name: "veris",
      description: "Provided"
    }

    changeset = ExternalReference.changeset(%ExternalReference{}, params)
    assert changeset.valid? == true

    params = %{
      source_name: "veris",
      url: "http://example.com"
    }

    changeset = ExternalReference.changeset(%ExternalReference{}, params)
    assert changeset.valid? == true

    params = %{
      source_name: "veris",
      external_id: "0001AA7F-C601-424A-B2B8-BE6C9F5164E7"
    }

    changeset = ExternalReference.changeset(%ExternalReference{}, params)
    assert changeset.valid? == true
  end
end
