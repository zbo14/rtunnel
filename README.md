# rtunnel

Like a pint of Neapolitan ice cream, `rtunnel` comes with three flavors, all packaged together: host, daemon, and client.

The host opens a reverse SSH tunnel to a publicly-accessible SSH daemon. The client SSHes into the daemon and requests port forwarding to the reverse tunnel. This establishes a (forward) tunnel to a reverse tunnel. Finally, the client SSHes into the host over the tunnel.

## Install

Make sure you have [Docker](https://docs.docker.com/install/) installed.

Then clone the repo and `[sudo] sh install.sh`.

## Usage

```
Usage: [PARAMS=] rtunnel <command> [ARGS]

Commands:
  build   Build the Docker image for the daemon
  init    Generate SSH keys and create daemon directories/files
  open    Open a reverse SSH tunnel to a daemon
  ssh     SSH into a host that opened a reverse tunnel to a daemon
  start   Start a Docker container running the daemon
  stop    Stop/remove the Docker container and its volumes
```

### Initialize

`$ rtunnel init`

Generate SSH keys for the host, daemon, and client. Also create the daemon directories and `authorized_keys` file.

The directories will be mounted as volumes inside the container once it starts.

This command only needs to run once.

### Daemon

#### Build

`$ rtunnel build`

Build the Docker image for the daemon.

#### Start

`$ rtunnel start PORT`

Start a Docker container running the daemon on the specified port.

You will be prompted to enter a password for user `rtunnel`.

**Note:** hosts/clients will still authenticate with their public keys.

#### Stop

`$ rtunnel stop`

Stop/remove the Docker container and its volumes.

### Host

#### Open a reverse tunnel to daemon

`$ ADDR= EPORT= FPORT= rtunnel open`

Open a reverse SSH tunnel to a publicly-accessible daemon listening on `<ADDR>:<EPORT>`.

Traffic on the daemon's `FPORT` is forwarded through the tunnel.

Your public key (`~/.ssh/rtunnel.pub`) should be in the daemon's `authorized_keys`.

### Client

#### SSH into host

`$ ADDR= EPORT= FPORT= LPORT= USER= rtunnel ssh`

SSH into a host that `open`ed a reverse tunnel to the daemon.

`ADDR`, `EPORT`, and `FPORT` should equal the values specified by the host.

The client SSHes into the daemon and then into the host as `USER` over a local socket on `LPORT`.

Your public key (`~/.ssh/rtunnel.pub`) should be in the daemon's `authorized_keys` (`/home/rtunnel/.ssh/authorized_keys`) *and* in the host's `authorized_keys` (`/home/$USER/.ssh/authorized_keys` or `/Users/$USER/.ssh/authorized_keys` on macOS).

## Contributing

Please do!

If you find a bug, think of an enhancement, or just have a question, feel free to [open an issue](https://github.com/zbo14/rtunnel/issues/new). You're also welcome to [create a pull request](https://github.com/zbo14/rtunnel/compare/develop...) addressing an issue. You should push your changes to a feature branch and request merge to `develop`.
