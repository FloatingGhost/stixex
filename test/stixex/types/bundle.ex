defmodule StixExTest.Types.Bundle do
  use ExUnit.Case

  alias StixEx.Types.Bundle

  test "Example data should be valid" do
    params = %{
      type: "bundle",
      id: "bundle--5d0092c5-5f74-4287-9642-33f4c354e56d",
      spec_version: "2.0",
      objects: [
        %{
          type: "indicator",
          id: "indicator--8e2e2d2b-17d4-4cbf-938f-98ee46b3cd3f",
          created_by_ref: "identity--f431f809-377b-45e0-aa1c-6a4751cae5ff",
          created: "2016-04-29T14:09:00.000Z",
          modified: "2016-04-29T14:09:00.000Z",
          object_marking_refs: ["marking-definition--089a6ecb-cc15-43cc-9494-767639779123"],
          name: "Poison Ivy Malware",
          description: "This file is part of Poison Ivy",
          pattern:
            "[file:hashes.'SHA-256' = 'aec070645fe53ee3b3763059376134f058cc337247c978add178b6ccdfb0019f']"
        },
        %{
          type: "marking-definition",
          id: "marking-definition--34098fce-860f-48ae-8e50-ebd3cc5e41da",
          created: "2016-08-01T00:00:00.000Z",
          definition_type: "tlp",
          definition: %{
            tlp: "green"
          }
        }
      ]
    }

    changeset = Bundle.changeset(%Bundle{}, params)
    assert changeset.valid? == true
  end
end
