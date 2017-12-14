defmodule ExSozu.Command do
  @moduledoc """
  Provides a set of helpers to prepare commands for Sozu.

  If you can't find a command in this list, you can create one like this:

      %ExSozu.Command{
        id: "<some random id>",
        type: <type (must be an atom)>,
        proxy_id: <the proxy id, if any>,
        data: <whatever needs to be send>
      }

  You can then send it using `ExSozu.command!/1`.
  """
  alias ExSozu.Command

  @derive {Poison.Encoder, except: [:client, :name]}
  defstruct [:client, :name, :id, :type, :data, :proxy_id, version: 0]

  @id_length 16

  def to_json!(command = %__MODULE__{}) do
    command = Map.update!(command, :type, &upcase_atom/1)
    command = with %{data: %{type: type}} <- command,
                do: put_in(command.data.type, upcase_atom(type))

    command = with %{proxy_id: nil} <- command, do: Map.delete(command, :proxy_id)
    command = with %{data: nil} <- command, do: Map.delete(command, :data)

    Poison.encode!(command)
  end

  defp upcase_atom(atom), do: atom |> Atom.to_string |> String.upcase

  # State

  def status(opts \\ []) do
    config(:proxy, %{type: :status}, opts)
  end

  def dump_state(opts \\ []) do
    config(:dump_state, opts)
  end

  def save_state(path, opts \\ []) do
    config(:save_state, %{path: path}, opts)
  end

  def load_state(path, opts \\ []) do
    config(:load_state, %{path: path}, opts)
  end

  # Lifecycle

  def soft_stop(opts \\ []) do
    config(:proxy, %{type: :soft_stop}, opts)
  end

  def hard_stop(opts \\ []) do
    config(:proxy, %{type: :hard_stop}, opts)
  end

  # Fronts

  def add_http_front(app_id, host, path_begin, opts \\ []) do
    data = %{app_id: app_id, hostname: host, path_begin: path_begin}

    config(:proxy, %{type: :add_http_front, data: data}, opts)
  end

  def add_https_front(app_id, host, path_begin, fingerprint, opts \\ []) do
    data = %{app_id: app_id,
            hostname: host,
            path_begin: path_begin,
            fingerprint: fingerprint}

    config(:proxy, %{type: :add_https_front, data: data}, opts)
  end

  def remove_http_front(app_id, host, path_begin, opts \\ []) do
    data = %{app_id: app_id, hostname: host, path_begin: path_begin}

    config(:proxy, %{type: :remove_http_front, data: data}, opts)
  end

  def remove_https_front(app_id, host, path_begin, fingerprint, opts \\ []) do
    data = %{app_id: app_id,
            hostname: host,
            path_begin: path_begin,
            fingerprint: fingerprint}

    config(:proxy, %{type: :remove_https_front, data: data}, opts)
  end

  # Workers

  def list_workers(opts \\ []) do
    config(:list_workers, opts)
  end

  # Instances

  def add_instance(app_id, ip_addr, port, opts \\ []) do
    data = %{app_id: app_id, ip_address: ip_addr, port: port}

    config(:proxy, %{type: :add_instance, data: data}, opts)
  end

  def remove_instance(app_id, ip_addr, port, opts \\ []) do
    data = %{app_id: app_id, ip_address: ip_addr, port: port}

    config(:proxy, %{type: :remove_instance, data: data}, opts)
  end

  # Certificates

  def add_certificate(cert, cert_chain, key, opts \\ []) do
    data = %{certificate: cert, certificate_chain: cert_chain, key: key}

    config(:proxy, %{type: :add_certificate, data: data}, opts)
  end

  def remove_certificate(data, opts \\ []) do
    config(:proxy, %{type: :remove_certificate, data: data}, opts)
  end

  # Upgrade

  def upgrade_master(opts \\ []) do
    config(:upgrade_master, opts)
  end

  # Helpers

  defp config(type, data \\ nil, opts) do
    %Command{
      id: id(),
      type: type,
      proxy_id: opts[:proxy_id],
      data: data
    }
  end

  defp id do
    :crypto.strong_rand_bytes(@id_length)
    |> Base.encode64
    |> binary_part(0, @id_length)
  end
end
