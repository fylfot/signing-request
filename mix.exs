defmodule SigningRequest.Mixfile do
  use Mix.Project

  @version "0.0.1"

  def project do
    [app: :signing_request,
     version: @version,
     elixir: "~> 1.2.3 or ~> 1.3",
     deps: deps(),
     package: package(),
     description: "Signing request signatures",
     name: "SigningRequest",
     xref: [exclude: [:ranch, :cowboy, :cowboy_req, :cowboy_router]],
     docs: [extras: [], main: "readme",
            source_ref: "v#{@version}",
            source_url: "https://github.com/fylfot/signing-request"]]
  end

  # Configuration for the OTP application
  def application do
    [applications: [:crypto, :logger, :mime],
     mod: {SigningRequest, []}]
  end

  def deps do
    [{:mime, "~> 1.0"},
     {:cowboy, "~> 1.0", optional: true}]
  end

  defp package do
    %{licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/fylfot/signing-request"}}
  end
end
