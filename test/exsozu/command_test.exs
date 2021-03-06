defmodule ExSozu.CommandTest do
  use ExUnit.Case
  doctest ExSozu.Command

  defp fetch_asset!(name) do
    File.read!("test/assets/#{name}.json")
    |> Poison.decode!
    |> Map.delete("id")
  end

  def execute(command, args \\ []) do
    apply(ExSozu.Command, command, args)
    |> ExSozu.Protocol.encode!
    |> String.trim_trailing(<<0>>)
    |> Poison.decode!
    |> Map.delete("id")
  end

  test "add_certificate/4 returns a valid command" do
    assert fetch_asset!("add_certificate")
             == execute(:add_certificate, ["-----BEGIN CERTIFICATE-----\nMIIDJjCCAg6gAwIBAgIJAKio5/9xAoHyMA0GCSqGSIb3DQEBBQUAMBYxFDASBgNV\nBAMTC2xvbGNhdGhvLnN0MB4XDTE1MTExODE1MDczOFoXDTE1MTIxODE1MDczOFow\nFjEUMBIGA1UEAxMLbG9sY2F0aG8uc3QwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw\nggEKAoIBAQDBfVivbeRNNfd+lXJ9JUhC6zJGgs0+n781d43/uP4Ye77DVNmLVArT\nKbUYTFpWe69Glwap1r7kIuayqsSYljIL5Z7TJD/XgnHXW8Hb74B1j5JlwsKBu3O1\nTkQ0AhTM7WHYPbE1xPjIaqJz+6y23q9A/SomOiYCN2a4WmhKH67fU1D/cjdE0ubS\neXfaKz1lm0iH6kBBGavTWtDx+BXn0D+SASlsRd0PzF6b7QoioYLUMip0vltOehxM\na+xyTKVkLYasXnXo+0270aIVF1Sm8tjVwWepxcXvRFIlPFV5mB8slr+ASkiVRn/7\nIpYKRl8YbYZT5CvTvpgLdpNTIXtsJer9AgMBAAGjdzB1MB0GA1UdDgQWBBRMvY+c\nt0s3XiiXiCcBdZa1WIyEzTBGBgNVHSMEPzA9gBRMvY+ct0s3XiiXiCcBdZa1WIyE\nzaEapBgwFjEUMBIGA1UEAxMLbG9sY2F0aG8uc3SCCQCoqOf/cQKB8jAMBgNVHRME\nBTADAQH/MA0GCSqGSIb3DQEBBQUAA4IBAQA4DEmS+ScCDNhMWy4ZHkRekfdcmW4+\ngm6EghnL1G3iyUS/GBZ4mbcPDTvNmHdbyjUiN0aphFoqCQk4tsF8eUluQpy0mD3/\nbjvWK7FJk99KLEBFw0hyxp4esZ5j3xnd6oG7QG2rA4GOhpDvLe5GQ8EWJAb5OeE1\nKuoL9vLaFdBcA5kG6xWVGJ5pqN9n37GKcBwWRsbiF37wjGR3iIPUnpGRUNubztXU\n/5EbJshZRIDlTldKZoKgfD0XMQjvkbC/wOaZNUvsFjvq6miRmSAmoKZ16oKDsUq2\nXmNFv7LrfHj+sUmJnu6ZRwWhtF8RTjBgNOwEqf+lDSYkg3Y3giVzzO3v\n-----END CERTIFICATE-----\n",
                                           ["-----BEGIN CERTIFICATE-----\nMIIDJjCCAg6gAwIBAgIJAKio5/9xAoHyMA0GCSqGSIb3DQEBBQUAMBYxFDASBgNV\nBAMTC2xvbGNhdGhvLnN0MB4XDTE1MTExODE1MDczOFoXDTE1MTIxODE1MDczOFow\nFjEUMBIGA1UEAxMLbG9sY2F0aG8uc3QwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw\nggEKAoIBAQDBfVivbeRNNfd+lXJ9JUhC6zJGgs0+n781d43/uP4Ye77DVNmLVArT\nKbUYTFpWe69Glwap1r7kIuayqsSYljIL5Z7TJD/XgnHXW8Hb74B1j5JlwsKBu3O1\nTkQ0AhTM7WHYPbE1xPjIaqJz+6y23q9A/SomOiYCN2a4WmhKH67fU1D/cjdE0ubS\neXfaKz1lm0iH6kBBGavTWtDx+BXn0D+SASlsRd0PzF6b7QoioYLUMip0vltOehxM\na+xyTKVkLYasXnXo+0270aIVF1Sm8tjVwWepxcXvRFIlPFV5mB8slr+ASkiVRn/7\nIpYKRl8YbYZT5CvTvpgLdpNTIXtsJer9AgMBAAGjdzB1MB0GA1UdDgQWBBRMvY+c\nt0s3XiiXiCcBdZa1WIyEzTBGBgNVHSMEPzA9gBRMvY+ct0s3XiiXiCcBdZa1WIyE\nzaEapBgwFjEUMBIGA1UEAxMLbG9sY2F0aG8uc3SCCQCoqOf/cQKB8jAMBgNVHRME\nBTADAQH/MA0GCSqGSIb3DQEBBQUAA4IBAQA4DEmS+ScCDNhMWy4ZHkRekfdcmW4+\ngm6EghnL1G3iyUS/GBZ4mbcPDTvNmHdbyjUiN0aphFoqCQk4tsF8eUluQpy0mD3/\nbjvWK7FJk99KLEBFw0hyxp4esZ5j3xnd6oG7QG2rA4GOhpDvLe5GQ8EWJAb5OeE1\nKuoL9vLaFdBcA5kG6xWVGJ5pqN9n37GKcBwWRsbiF37wjGR3iIPUnpGRUNubztXU\n/5EbJshZRIDlTldKZoKgfD0XMQjvkbC/wOaZNUvsFjvq6miRmSAmoKZ16oKDsUq2\nXmNFv7LrfHj+sUmJnu6ZRwWhtF8RTjBgNOwEqf+lDSYkg3Y3giVzzO3v\n-----END CERTIFICATE-----",
                                            "-----BEGIN CERTIFICATE-----\nMIIDJjCCAg6gAwIBAgIJAKio5/9xAoHyMA0GCSqGSIb3DQEBBQUAMBYxFDASBgNV\nBAMTC2xvbGNhdGhvLnN0MB4XDTE1MTExODE1MDczOFoXDTE1MTIxODE1MDczOFow\nFjEUMBIGA1UEAxMLbG9sY2F0aG8uc3QwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw\nggEKAoIBAQDBfVivbeRNNfd+lXJ9JUhC6zJGgs0+n781d43/uP4Ye77DVNmLVArT\nKbUYTFpWe69Glwap1r7kIuayqsSYljIL5Z7TJD/XgnHXW8Hb74B1j5JlwsKBu3O1\nTkQ0AhTM7WHYPbE1xPjIaqJz+6y23q9A/SomOiYCN2a4WmhKH67fU1D/cjdE0ubS\neXfaKz1lm0iH6kBBGavTWtDx+BXn0D+SASlsRd0PzF6b7QoioYLUMip0vltOehxM\na+xyTKVkLYasXnXo+0270aIVF1Sm8tjVwWepxcXvRFIlPFV5mB8slr+ASkiVRn/7\nIpYKRl8YbYZT5CvTvpgLdpNTIXtsJer9AgMBAAGjdzB1MB0GA1UdDgQWBBRMvY+c\nt0s3XiiXiCcBdZa1WIyEzTBGBgNVHSMEPzA9gBRMvY+ct0s3XiiXiCcBdZa1WIyE\nzaEapBgwFjEUMBIGA1UEAxMLbG9sY2F0aG8uc3SCCQCoqOf/cQKB8jAMBgNVHRME\nBTADAQH/MA0GCSqGSIb3DQEBBQUAA4IBAQA4DEmS+ScCDNhMWy4ZHkRekfdcmW4+\ngm6EghnL1G3iyUS/GBZ4mbcPDTvNmHdbyjUiN0aphFoqCQk4tsF8eUluQpy0mD3/\nbjvWK7FJk99KLEBFw0hyxp4esZ5j3xnd6oG7QG2rA4GOhpDvLe5GQ8EWJAb5OeE1\nKuoL9vLaFdBcA5kG6xWVGJ5pqN9n37GKcBwWRsbiF37wjGR3iIPUnpGRUNubztXU\n/5EbJshZRIDlTldKZoKgfD0XMQjvkbC/wOaZNUvsFjvq6miRmSAmoKZ16oKDsUq2\nXmNFv7LrfHj+sUmJnu6ZRwWhtF8RTjBgNOwEqf+lDSYkg3Y3giVzzO3v\n-----END CERTIFICATE-----"],
                                           "-----BEGIN RSA PRIVATE KEY-----\nMIIEpAIBAAKCAQEAwX1Yr23kTTX3fpVyfSVIQusyRoLNPp+/NXeN/7j+GHu+w1TZ\ni1QK0ym1GExaVnuvRpcGqda+5CLmsqrEmJYyC+We0yQ/14Jx11vB2++AdY+SZcLC\ngbtztU5ENAIUzO1h2D2xNcT4yGqic/ustt6vQP0qJjomAjdmuFpoSh+u31NQ/3I3\nRNLm0nl32is9ZZtIh+pAQRmr01rQ8fgV59A/kgEpbEXdD8xem+0KIqGC1DIqdL5b\nTnocTGvsckylZC2GrF516PtNu9GiFRdUpvLY1cFnqcXF70RSJTxVeZgfLJa/gEpI\nlUZ/+yKWCkZfGG2GU+Qr076YC3aTUyF7bCXq/QIDAQABAoIBABFSUl0qHlUXLrfj\nUyOG8egjvBV54jvn+ysjL9Aj1IOGmHZOI0eI14s94ZtyQmgZnIBaRttvgRlVUofO\nJ9ltIL/V55kJVrnJUL2x1jIFR9++YaHAhL8uc9ZYUlzBjvElkyvTogipQIhYm4B8\nmGKqns/Xmi1f6UUrhoOcfFeebH5LhEAPs4zbqm52ISsw3JkNmKnbh5FYV6oLIPC2\nxYqF9A0Jm8yo+D9gIj4AyvYzTD4ouyJsJO8RwbXBLHtjP82UsuhcvKiof5Olsvo0\nKd8o84Cbgder92Yswgk/yGgch2gflZzP461khIaeMrSk38YOyNAm4qv9lRpgYWCQ\ne8TcoPUCgYEA6dPT4dJYp+WoinkXvpIhGyVQO7NYnxYvfbgD9yp6vpQJPOt2e66l\nSg0b6Qu+TITdm+iKuRNfe+ykrHeGCYnTWnphmcMn+l6xX5lsJu6ksxUCN/tX1o13\nqRA2wT+LwQXEchOGZ+rpkpfLczBRd52eDCGJEH07TDtYBiRBsKWIGksCgYEA09ZQ\n/OO93Z2u893eI/C/QxhUDdpsOZ8SJijRa4W5DST989JqXznz6hicdvYQREC2zrn2\nI1WPRPuDQgytbHlVC9D2I7CpYhsNYfKFbpbjsg4b+dRP3kV5ZdeMrz2hDKih97Xq\n0kEFtOt9eehq9ZOR9Y1u1kVaibsylxckuBXhwtcCgYAcXGoNsOK58pwft5JOthC3\n5y21IAq2uQ0nlYM9nnRm2zPHpNOpKsS3l6F0Ac2iIFd0yp7Q1e217T0IAjNKwuHU\nzpU5/jbCImwnKUe57SYi5oBvY9gCmQQTiHjrtZZw4g8yuvWJcy/DbQ/rN8gZ1w9N\nb1/dlSL1GxmRHSKul1VLwwKBgQCoBd/rFoDsnTu9toeSHky2XT+eVVduRNvSZKHn\nFQP4hxTfJlC1A3SSg77nJLk2SdY2Fo5C7IRdBNnRs9iCp6JrYu041dEkPazZudFY\nLFqiSkqqWFqZRKXLv7KY9Nse/Uqq/iIpbuWl4Pt/jHf6HXiyOeJmFlB/2nmAGh1H\n3iNZtQKBgQCXrD05rdsaNf3Hy9xC1+iHE9YDRzZ5pV0lCyswYR/0GwItF68lqbsI\nhiQyzq8pehWxB021EqkNR+Wn/U5V3vHoVQY13hHaeGkoZvXxOiYeB64Y6cG6dJb+\nF/dzHvorjY0vXaztensj562uXdCp433soeZThX2Ag5y0B7fMszffbQ==\n-----END RSA PRIVATE KEY-----\n"])
  end

  test "add_http_front/4 returns a valid command" do
    assert fetch_asset!("add_http_front") == execute(:add_http_front, ["xxx", "yyy", "xxx"])
  end

  test "add_https_front/5 returns a valid command" do
    assert fetch_asset!("add_https_front") == execute(:add_https_front, ["xxx",
                                                                         "yyy",
                                                                         "xxx",
                                                                         "ab2618b674e15243fd02a5618c66509e4840ba60e7d64cebec84cdbfeceee0c5"])
  end

  test "add_instance/4 returns a valid command" do
    assert fetch_asset!("add_instance") == execute(:add_instance, ["xxx", "xxx-0", "127.0.0.1", 8080])
  end

  test "dump_state/1 returns a valid command" do
    assert fetch_asset!("dump_state") == execute(:dump_state)
  end

  test "hard_stop/1 returns a valid command" do
    assert fetch_asset!("hard_stop") == execute(:hard_stop, [[proxy_id: 0]])
  end

  test "list_workers/1 returns a valid command" do
    assert fetch_asset!("list_workers") == execute(:list_workers)
  end

  test "load_state/2 returns a valid command" do
    assert fetch_asset!("load_state") == execute(:load_state, ["./config_dump.json"])
  end

  test "remove_certificate/2 returns a valid command" do
    assert fetch_asset!("remove_certificate") == execute(:remove_certificate, ["ab2618b674e15243fd02a5618c66509e4840ba60e7d64cebec84cdbfeceee0c5"])
  end

  test "remove_http_front/4 returns a valid command" do
    assert fetch_asset!("remove_http_front") == execute(:remove_http_front, ["xxx", "yyy", "xxx"])
  end

  test "remove_https_front/5 returns a valid command" do
    assert fetch_asset!("remove_https_front") == execute(:remove_https_front, ["xxx", "yyy", "xxx", "ab2618b674e15243fd02a5618c66509e4840ba60e7d64cebec84cdbfeceee0c5"])
  end

  test "remove_instance/4 returns a valid command" do
    assert fetch_asset!("remove_instance") == execute(:remove_instance, ["xxx", "xxx-0", "127.0.0.1", 8080])
  end

  test "save_state/2 returns a valid command" do
    assert fetch_asset!("save_state") == execute(:save_state, ["./config_dump.json"])
  end

  test "soft_stop/1 returns a valid command" do
    assert fetch_asset!("soft_stop") == execute(:soft_stop, [[proxy_id: 0]])
  end

  test "status/1 returns a valid command" do
    assert fetch_asset!("status") == execute(:status, [[proxy_id: 0]])
  end

  test "upgrade_master/1 returns a valid command" do
    assert fetch_asset!("upgrade_master") == execute(:upgrade_master)
  end
end
