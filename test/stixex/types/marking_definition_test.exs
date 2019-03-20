defmodule StixexTest.Types.MarkingDefinition do
  use ExUnit.Case

  alias Stixex.Types.MarkingDefinition

  test "Example data should be valid" do
    params = %{
      type: "marking-definition",
      id: "marking-definition--34098fce-860f-48ae-8e50-ebd3cc5e41da",
      created: "2016-08-01T00:00:00.000Z",
      definition_type: "statement",
      definition: %{
        statement: "Copyright 2016, Example Corp"
      }
    } 
    changeset = MarkingDefinition.changeset(%MarkingDefinition{}, params)
    assert changeset.valid? == true
  end

  test "Definition should validate" do
    params = %{
      type: "marking-definition",
      id: "marking-definition--34098fce-860f-48ae-8e50-ebd3cc5e41da",
      created: "2016-08-01T00:00:00.000Z",
      definition_type: "statement",
      definition: %{
        tlp: "red"
      }
    }
    changeset = MarkingDefinition.changeset(%MarkingDefinition{}, params)
    assert changeset.valid? == false

    params = %{
      type: "marking-definition",
      id: "marking-definition--34098fce-860f-48ae-8e50-ebd3cc5e41da",
      created: "2016-08-01T00:00:00.000Z",
      definition_type: "tlp",
      definition: %{          
        tlp: "red"            
      }                       
    }                         
    changeset = MarkingDefinition.changeset(%MarkingDefinition{}, params)
    assert changeset.valid? == true

    params = %{
      type: "marking-definition",
      id: "marking-definition--34098fce-860f-48ae-8e50-ebd3cc5e41da",
      created: "2016-08-01T00:00:00.000Z",
      definition_type: "tlp",
      definition: %{          
        tlp: "purple"            
      }                       
    }                         
    changeset = MarkingDefinition.changeset(%MarkingDefinition{}, params)
    assert changeset.valid? == false
  end
end
