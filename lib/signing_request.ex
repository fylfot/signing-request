defmodule SigningRequest do

  def extract_and_check_signature(conn, signature) do

    params = conn.params
    headers = Enum.into(conn.req_headers, %{})

    list = [signature]
    list = for key <- Enum.sort(Map.keys(params)) do
      list = List.insert_at(list, 0, params[key])
      list = List.insert_at(list, 0, key)
      list
    end

    local_signature = String.downcase(:crypto.hash(:md5, Enum.join(list, "")) |> Base.encode64)
    external_signature = headers["x-request-signature"]

    unless(not(is_list(external_signature)) && String.equivalent?(local_signature, external_signature)) do
      Logger.debug("SIG: #{local_signature} <> #{external_signature}")
      conn
        |> render("signature_failed.json")
        |> halt()
    end

    conn
  end

end
