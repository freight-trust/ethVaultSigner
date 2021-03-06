# EthVaultSigner
[![Build Status](https://travis-ci.com/freight-trust/ethVaultSigner.svg?token=WSycjKTmZXAzmyXpmVgz&branch=master)](https://travis-ci.com/freight-trust/ethVaultSigner)

> HashiCorp Vault Extension for EthSigner 

## What is EthVaultSigner?

EthVaultSigner is an open-source, client-agnostic, Ethereum transaction signer developed under the Apache
2.0 license and written in Java. EthSigner separates private key management from transaction
validation by [signing transactions](Concepts/Overview.md) using a private key that can be secured
in a variety of cloud providers, or encrypted on a local disk.

EthVaultSigner is based off of *EthSinger*
**EthVaultSigner** includes additional functionality for integrating HashiCorp Vault


- [EthVaultSigner](#ethvaultsigner)
  * [What is EthVaultSigner?](#what-is-ethvaultsigner-)
  * [description: Secure communication using TLS](#description--secure-communication-using-tls)
  * [Configure TLS](#configure-tls)
    + [Client TLS connection](#client-tls-connection)
      - [Create the known clients file](#create-the-known-clients-file)
      - [Start EthVaultSigner](#start-ethvaultsigner)
    + [Server TLS connection](#server-tls-connection)
      - [Create the known servers file](#create-the-known-servers-file)
      - [Start EthVaultSigner](#start-ethvaultsigner-1)
  * [description: EthSigner command line interface reference](#description--ethsigner-command-line-interface-reference)
  * [EthSigner command line](#ethsigner-command-line)
    + [Options](#options)
      - [`chain-id`](#-chain-id-)
      - [`data-path`](#-data-path-)
      - [`downstream-http-host`](#-downstream-http-host-)
    + [`downstream-http-path`](#-downstream-http-path-)
    + [`downstream-http-port`](#-downstream-http-port-)
      - [`downstream-http-request-timeout`](#-downstream-http-request-timeout-)
      - [`downstream-http-tls-enabled`](#-downstream-http-tls-enabled-)
      - [`downstream-http-tls-ca-auth-enabled`](#-downstream-http-tls-ca-auth-enabled-)
      - [`downstream-http-tls-keystore-file`](#-downstream-http-tls-keystore-file-)
      - [`downstream-http-tls-keystore-password-file`](#-downstream-http-tls-keystore-password-file-)
      - [`downstream-http-tls-known-servers-file`](#-downstream-http-tls-known-servers-file-)
      - [`http-cors-origins`](#-http-cors-origins-)
      - [`http-listen-host`](#-http-listen-host-)
      - [`http-listen-port`](#-http-listen-port-)
      - [`logging`](#-logging-)
      - [`help`](#-help-)
      - [`tls-allow-any-client`](#-tls-allow-any-client-)
      - [`tls-allow-ca-clients`](#-tls-allow-ca-clients-)
      - [`tls-keystore-file`](#-tls-keystore-file-)
      - [`tls-keystore-password-file`](#-tls-keystore-password-file-)
      - [`tls-known-clients-file`](#-tls-known-clients-file-)
      - [`version`](#-version-)
    + [File options](#file-options)
      - [`key-file`](#-key-file-)
      - [`password-file`](#-password-file-)
    + [Hashicorp options](#hashicorp-options)
      - [`auth-file`](#-auth-file-)
      - [`host`](#-host-)
      - [`port`](#-port-)
      - [`signing-key-path`](#-signing-key-path-)
      - [`timeout`](#-timeout-)
      - [tls-enabled](#tls-enabled)
      - [tls-known-server-file](#tls-known-server-file)
    + [Azure options](#azure-options)
      - [`client-id`](#-client-id-)
      - [`client-secret-path`](#-client-secret-path-)
      - [`key-name`](#-key-name-)
      - [`key-version`](#-key-version-)
      - [`keyvault-name`](#-keyvault-name-)
    + [Multikey Options](#multikey-options)
      - [`directory`](#-directory-)
      

---
description: Secure communication using TLS
---

## Configure TLS

Configure TLS communication from the command line. Clients and servers
communicate using HTTP JSON-RPCs.

**EthSigner prerequisites**:

* EthSigner's password-protected PKCS #12 keystore.
* File containing the keystore password.

### Client TLS connection

Allow clients (for example a dApp, or curl) to send and receive secure
HTTP JSON-RPCs.

**Client prerequisites**:

* The client must be configured for TLS.
* Client's PKCS #12 keystore information.

#### Create the known clients file

Create a file (in this example, `knownClients`) that lists one or more clients
that are trusted to connect to EthSigner. The file contents use the format
`<common_name> <hex-string>` where:

* `<common_name>` is the Common Name used for the client's keystore
* `<hex-string>` is the SHA-256 fingerprint of the client's keystore.

!!! example

    ```
    curl_client DF:65:B8:02:08:5E:91:82:0F:91:F5:1C:96:56:92:C4:1A:F6:C6:27:FD:6C:FC:31:F2:BB:90:17:22:59:5B:50
    ```

You can use [OpenSSL](https://www.openssl.org/) or
[keytool](https://docs.oracle.com/javase/6/docs/technotes/tools/solaris/keytool.html)
to display the fingerprint. For example:

!!! example

    ```
    keytool -list -v -keystore <keystore> -storetype PKCS12 -storepass <password>
    ```

#### Start EthVaultSigner

```bash
ethsigner --tls-keystore-file=/Users/me/my_node/keystore.pfx --tls-keystore-password-file=/Users/me/my_node/keystorePassword --tls-known-clients-file=/Users/me/my_node/knownClients  --tls-allow-ca-clients
```

The command line:

* Specifies the EthSigner keystore using the [`--tls-keystore-file`](../Reference/CLI/CLI-Syntax.md#tls-keystore-file) option.
* Specifies the file that contains the password to decrypt the
  keystore using the [`--tls-keystore-password-file`](../Reference/CLI/CLI-Syntax.md#tls-keystore-password-file) option.
* [Specifies the clients](#create-the-known-clients-file) that are trusted to connect to EthSigner
  using the [`tls-known-clients-file`](../Reference/CLI/CLI-Syntax.md#tls-known-clients-file) option.
* Allow access to clients with trusted CA certificates using the [`--tls-allow-ca-clients`](../Reference/CLI/CLI-Syntax.md#tls-allow-ca-clients)
  option.

!!! note
    Use the [`--tls-allow-any-client`](../Reference/CLI/CLI-Syntax.md#tls-allow-any-client) option to allow
    access to any client.

    [`--tls-allow-any-client`](../Reference/CLI/CLI-Syntax.md#tls-allow-any-client) cannot be used with [`tls-known-clients-file`](../Reference/CLI/CLI-Syntax.md#tls-known-clients-file) or [`--tls-allow-ca-clients`](../Reference/CLI/CLI-Syntax.md#tls-allow-ca-clients).

### Server TLS connection

Allow EthVaultSigner to send and receive secure HTTP JSON-RPCs from the
server (for example Besu).

**Server prerequisites**:

* [The server must be configured to allow TLS communication](https://besu.hyperledger.org/en/latest/HowTo/Configure/Configure-TLS/).
* Server's password-protected PKCS #12 keystore information.

#### Create the known servers file

Create a file (in this example, `knownServers`) that lists one or more trusted
servers. The file contents use the format `<hostame>:<port> <hex-string>`
where:

* `<hostname>` is the server hostname
* `<port>` is the port used for communication
* `<hex-string>` is the SHA-256 fingerprint of the server's certificate.

!!! example

    ```
    localhost:8590 6C:B2:3E:F9:88:43:5E:62:69:9F:A9:9D:41:14:03:BA:83:24:AC:04:CE:BD:92:49:1B:8D:B2:A4:86:39:4C:BB
    127.0.0.1:8590 6C:B2:3E:F9:88:43:5E:62:69:9F:A9:9D:41:14:03:BA:83:24:AC:04:CE:BD:92:49:1B:8D:B2:A4:86:39:4C:BB
    ```

!!! note
    Specify both hostname and IP address in the file if unsure which is used in
    requests.

#### Start EthVaultSigner

```bash
ethsigner --downstream-http-tls-enabled --downstream-http-tls-keystore-file=/Users/me/my_node/keystore.pfx --downstream-http-tls-keystore-password-file=/Users/me/my_node/keyPassword --downstream-http-tls-known-servers-file=/Users/me/my_node/knownServers
```

The command line:

* Enables TLS using the [`--downstream-http-tls-enabled`](../Reference/CLI/CLI-Syntax.md#downstream-http-tls-enabled)
  option.
* Specifies the keystore to present during authentication using the
  [`--downstream-http-tls-keystore-file`](../Reference/CLI/CLI-Syntax.md#downstream-http-tls-keystore-file) option.
* Specifies the file that contains the password to decrypt the keystore using
  the [`--downstream-http-tls-keystore-password-file`](../Reference/CLI/CLI-Syntax.md#downstream-http-tls-keystore-password-file)
  option.
* [Specifies the servers](#create-the-known-servers-file) to connect to using the
  [`--downstream-http-tls-known-servers-file`](../Reference/CLI/CLI-Syntax.md#downstream-http-tls-known-servers-file) option.

!!! note
    The [`--downstream-http-tls-ca-auth-enabled`](../Reference/CLI/CLI-Syntax.md#downstream-http-tls-ca-auth-enabled)
    option is `true` by default and allows connections to servers with trusted root CAs.


---
description: EthSigner command line interface reference
---

## EthSigner command line

This reference describes the syntax of the EthSigner Command Line Interface (CLI) options. EthSigner
signs transaction with a key stored in an encrypted file or an external vault (for example, Hashicorp):

* `ethsigner [Options] file-based-signer [File Options]`
* `ethsigner [Options] hashicorp-signer [Hashicorp Options]`
* `ethsigner [Options] azure-signer [Azure Options]`
* `ethsigner [Options] multikey-signer [Multikey Options]`

!!! note

    * The [`file-based-signer`](#file-options), [`hashicorp-signer`](#hashicorp-options), and [`azure-signer`](#azure-options)
    command line options are used for a [single key only](../../Tutorials/Start-EthSigner.md).
    * The [`multikey-signer`](#multikey-options) command line option is used for
    [one or more keys](../../Tutorials/Multifile.md).

!!! tip
    To view the command line help for the subcommands:

    * [`ethsigner help file-based-signer`](#file-options)
    * [`ethsigner help hashicorp-signer`](#hashicorp-options)
    * [`ethsigner help azure-signer`](#azure-options)
    * [`ethsigner help multikey-signer`](#multikey-options)

### Options

#### `chain-id`

[Chain ID](https://besu.hyperledger.org/en/stable/Concepts/NetworkID-And-ChainID/) of the network to
receive the signed transactions.

=== "Syntax"

    ```bash
    --chain-id=<chainId>
    ```

=== "Example"

    ```bash
    --chain-id=2017
    ```

#### `data-path`

Directory in which to store temporary files.

=== "Syntax"

    ```bash
    --data-path=<PATH>
    ```

=== "Example"

    ```bash
    --data-path=/Users/me/my_node/data
    ```

#### `downstream-http-host`

Host to which received requests are forwarded. Default is `localhost`.

=== "Syntax"

    ```bash
    --downstream-http-host=<downstreamHttpHost>
    ```

=== "Example"

    ```bash
    --downstream-http-host=192.168.05.14
    ```

### `downstream-http-path`

Path to which received requests are forwarded. Default is `/`.

Might be required if [connecting to a cloud-based Ethereum client] such as [Infura].

=== "Syntax"

    ```bash
    --downstream-http-path=<downstreamHttpPath>
    ```

=== "Example"

    ```bash
    --downstream-http-path=/v3/d0e63ca5bb1e4eef2284422efbc51a56
    ```

### `downstream-http-port`

Port to which received requests are forwarded.

=== "Syntax"

    ```bash
    --downstream-http-port=<downstreamHttpPort>
    ```

=== "Example"

    ```bash
    --downstream-http-port=6174
    ```

#### `downstream-http-request-timeout`

Timeout period (in milliseconds) for downstream requests. Default is 5000.

=== "Syntax"

    ```bash
    --downstream-http-request-timeout=<downstreamHttpRequestTimeout>
    ```

=== "Example"

    ```bash
    --downstream-http-request-timeout=3000
    ```

#### `downstream-http-tls-enabled`

Enable or disable [TLS for server connections](../../Concepts/TLS.md).
Defaults to `false`.

=== "Syntax"

    ```bash
    --downstream-http-tls-enabled[=<true|false>]
    ```

=== "Example"

    ```bash
    --downstream-http-tls-enabled
    ```

#### `downstream-http-tls-ca-auth-enabled`

Allow connections to servers with trusted CAs.

Defaults to `true`.

=== "Syntax"

    ```bash
    --downstream-http-tls-ca-auth-enabled[=<true|false>]
    ```

=== "Example"

    ```bash
    --downstream-http-tls-enabled=false
    ```

#### `downstream-http-tls-keystore-file`

Keystore file (in PKCS #12 format) that contains the private key and certificate
presented to the server during authentication.

=== "Syntax"

    ```bash
    --downstream-http-tls-keystore-file=<keystoreFile>
    ```

=== "Example"

    ```bash
    --downstream-http-tls-keystore-file=/Users/me/my_node/keystore.pfx
    ```

#### `downstream-http-tls-keystore-password-file`

Password file used to decrypt the keystore.

=== "Syntax"

    ```bash
    --downstream-http-tls-keystore-password-file=<passwordFile>
    ```

=== "Example"

    ```bash
    --downstream-http-tls-keystore-password-file=/Users/me/my_node/password
    ```

#### `downstream-http-tls-known-servers-file`

File containing the hostnames, ports, and SHA256 certificate fingerprints
of [trusted servers](../../HowTo/Configure-TLS.md#create-the-known-servers-file).

=== "Syntax"

    ```bash
    --downstream-http-tls-known-servers-file=<serversFile>
    ```

=== "Example"

    ```bash
    --downstream-http-tls-known-servers-file=/Users/me/my_node/knownServers
    ```

#### `http-cors-origins`

A list of domain URLs for CORS validation. You must enclose the URLs in double quotes and separate
them with commas.

Listed domains can access the node using JSON-RPC. If your client interacts with EthSigner using a
browser app (such as Remix or a block explorer), you must allow the client domains.

The default value is "none". If you do not allow any domains, browser apps cannot interact with your
EthSigner node.

!!! tip

    For testing and development purposes, use `"all"` or `"*"` to accept requests from any domain.
    We don't recommend accepting requests from any domain for production environments.

=== "Syntax"

    ```bash
    --http-cors-origins=<httpListenHost>
    ```

=== "Example"

    ```bash
    ----http-cors-origins="http://remix.ethereum.org","http://medomain.com"
    ```

#### `http-listen-host`

Host on which JSON-RPC HTTP listens. Default is `localhost`.

=== "Syntax"

    ```bash
    --http-listen-host=<httpListenHost>
    ```

=== "Example"

    ```bash
    --http-listen-host=10.100.111.1
    ```

#### `http-listen-port`

Port on which JSON-RPC HTTP listens. Default is 8545.

=== "Syntax"

    ```bash
    --http-listen-port=<httpListenPort>
    ```

=== "Example"

    ```bash
    --http-lisentport=6174
    ```

#### `logging`

Logging verbosity levels. Options are: `OFF`, `FATAL`, `WARN`, `INFO`, `DEBUG`, `TRACE`, `ALL`.
Default is `INFO`.

=== "Syntax"

    ```bash
    -l, --logging=<LOG VERBOSITY LEVEL>
    ```

=== "Example"

    ```bash
    --logging=DEBUG
    ```

#### `help`

Displays the help and exits.

=== "Syntax"

    ```bash
    -h, --help
    ```

#### `tls-allow-any-client`

Allows any client to connect.

!!! important
    Cannot be used with `--tls-allow-ca-clients` and `--tls-known-clients-file`

=== "Syntax"

    ```bash
    --tls-allow-any-client
    ```

#### `tls-allow-ca-clients`

Allows clients signed with trusted CA certificates to connect.

=== "Syntax"

    ```bash
    --tls-allow-ca-clients
    ```

#### `tls-keystore-file`

PKCS #12 formatted keystore. Used to enable TLS for [client connections](../../Concepts/TLS.md).

=== "Syntax"

    ```bash
    --tls-keystore-file=<keystoreFile>
    ```

=== "Example"

    ```bash
    --tls-keystore-file=/Users/me/my_node/certificate.pfx
    ```

#### `tls-keystore-password-file`

Password file used to decrypt the keystore.

=== "Syntax"

    ```bash
    --tls-keystore-password-file=<passwordFile>
    ```

=== "Example"

    ```bash
    --tls-keystore-password-file=/Users/me/my_node/password
    ```

#### `tls-known-clients-file`

File containing the SHA-256 fingerprints of [authorized clients](../../HowTo/Configure-TLS.md#create-the-known-clients-file).

=== "Syntax"

    ```bash
    --tls-known-clients-file=<clientsFile>
    ```

=== "Example"

    ```bash
    --tls-keystore-file=/Users/me/my_node/knownClients
    ```

#### `version`

Displays the version and exits.

=== "Syntax"

    ```bash
    -V, --version
    ```

### File options

#### `key-file`

File containing [key with which transactions are signed](../../Tutorials/Start-EthSigner.md#create-password-and-key-files).

=== "Syntax"

    ```bash
    -k, --key-file=<keyFile>
    ```

=== "Example"

    ```bash
    --key-file=/Users/me/my_node/transactionKey
    ```

#### `password-file`

File containing password for the [key with which transactions are signed](../../Tutorials/Start-EthSigner.md#create-password-and-key-files).

=== "Syntax"

    ```bash
    -p, --password-file=<passwordFile>
    ```

=== "Example"

    ```bash
    --password-file=/Users/me/my_node/password
    ```

### Hashicorp options

#### `auth-file`

File containing authentication data for Hashicorp Vault. The authentication data is the [root token displayed by
the Hashicorp Vault server](../../HowTo/Store-Keys/Use-Hashicorp.md#storing-private-key-in-hashcorp-vault).

=== "Syntax"

    ```bash
    --auth-file=<authFile>
    ```

=== "Example"

    ```bash
    --auth-file=/Users/me/my_node/auth_file
    ```

#### `host`

Host of the Hashicorp Vault server. Default is `localhost`.

=== "Syntax"

    ```bash
    --host=<serverHost>
    ```

=== "Example"

    ```bash
    --host="http://host.com"
    ```

#### `port`

Port of the Hashicorp Vault server. Default is 8200.

=== "Syntax"

    ```bash
    --port=<serverPort>
    ```

=== "Example"

    ```bash
    --port=23000
    ```

#### `signing-key-path`

Path to secret in the Hashicorp Vault containing the private key for signing transactions. Default is
` /secret/data/ethsignerSigningKey`.

=== "Syntax"

    ```bash
    --signing-key-path=<signingKeyPath>
    ```

=== "Example"

    ```bash
    --signing-key-path=/my_secret/ethsignerSigningKey
    ```

#### `timeout`

Timeout in milliseconds for requests to the Hashicorp Vault server. Default is 10000.

=== "Syntax"

    ```bash
    --timeout=<timeout>
    ```

=== "Example"

    ```bash
    --timeout=5000
    ```

#### tls-enabled

Connect to Hashicorp Vault server using TLS. Default is `true`.

=== "Syntax"

    ```bash
    --tls-enabled[=<true|false>]
    ```

=== "Example"

    ```bash
    --tls-enabled=false
    ```

#### tls-known-server-file

File containing the hostname, port, and SHA256 certificate fingerprint
of the Hashicorp Vault server.

=== "Syntax"

    ```bash
    --tls-known-server-file=<hashicorpServerFile>
    ```

=== "Example"

    ```bash
    --tls-known-server-file=/Users/me/my_node/knownHashicorpServers
    ```

### Azure options

#### `client-id`

ID used to authenticate with Azure Key Vault.

=== "Syntax"

    ```bash
    --client-id=<clientID>
    ```

=== "Example"

    ```bash
    --client-id="MyClientID"
    ```

#### `client-secret-path`

Path to file containing secret used to access the vault.

=== "Syntax"

    ```bash
    --client-secret-path=<clientSecretPath>
    ```

=== "Example"

    ```bash
    --client-secret-path=/Path/MySecret
    ```

#### `key-name`

Name of key to be used.

=== "Syntax"

    ```bash
    --key-name=<keyName>
    ```

=== "Example"

    ```bash
    --key-name="MyKey"
    ```

#### `key-version`

Version of the specified key to use.

=== "Syntax"

    ```bash
    --key-version=<keyVersion>
    ```

=== "Example"

    ```bash
    --key-version="7c01fe58d68148bba5824ce418241092"
    ```

#### `keyvault-name`

Name of the vault to access. Sub-domain of `vault.azure.net`.

=== "Syntax"

    ```bash
    --keyvault-name=<keyVaultName>
    ```

=== "Example"

    ```bash
    --keyvault-name="MyKeyVault"
    ```

### Multikey Options

#### `directory`

Path to the directory containing the [TOML files](../Multikey-Parameters.md)
required to access keys.

=== "Syntax"

    ```bash
    --directory=<directoryPath>
    ```

=== "Example"

    ```bash
    --directory=/Users/me/keys
    ```

<!-- links -->
[connecting to a cloud-based Ethereum client]: ../../Tutorials/Start-EthSigner.md#start-ethsigner
[Infura]: https://infura.io/
