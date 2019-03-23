defmodule StixEx.TypeRegistry do
  @moduledoc """
  Maintains a map from string-type name to module,
  since STIX itself won't tell us if something is an observable or
  not, it's hard to automatically do it.
  """

  alias StixEx.Object

  alias StixEx.Object.{
    Observable,
    Relationship
  }

  @registry %{
    report: Object.Report,
    campaign: Object.Campaign,
    vulnerability: Object.Vulnerability,
    identity: Object.Identity,
    indicator: Object.Indicator,
    "observed-data": Object.ObservedData,
    "intrusion-set": Object.IntrusionSet,
    "threat-actor": Object.ThreatActor,
    "course-of-action": Object.CourseOfAction,
    "attack-pattern": Object.AttackPattern,
    process: Observable.Process,
    mutex: Observable.Mutex,
    "autonomous-system": Observable.AutonomousSystem,
    "windows-registry-key": Observable.WindowsRegistryKey,
    "mac-addr": Observable.MACAddr,
    url: Observable.URL,
    artifact: Observable.Artifact,
    file: Observable.File,
    "user-account": Observable.UserAccount,
    "ipv6-addr": Observable.IPv6Addr,
    "ipv4-addr": Observable.IPv4Addr,
    "email-addr": Observable.EmailAddr,
    software: Observable.Software,
    directory: Observable.Directory,
    "x509-certificate": Observable.X509Certificate,
    "email-message": Observable.EmailMessage,
    "domain-name": Observable.DomainName,
    "network-traffic": Observable.NetworkTraffic,
    malware: ObjectkMalware,
    tool: Object.Tool,
    relationship: Relationship,
    sighting: Relationship.Sighting
  }

  @doc """
  Get a type based on its name

      iex> StixEx.TypeRegistry.get("software")
      {:ok, StixEx.Object.Observable.Software}

      iex> StixEx.TypeRegistry.get("my-type")
      {:error, {:does_not_exist, "my-type"}}
  """
  def get(type_name) when is_atom(type_name) do
    if Map.has_key?(@registry, type_name) do
      {:ok, Map.get(@registry, type_name)}
    else
      {:error, {:does_not_exist, type_name}}
    end
  end

  def get(type_name) when is_binary(type_name) do
    type_name
    |> String.to_atom()
    |> get()
  end
end
