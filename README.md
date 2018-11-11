# Elixir Nerves Scenir RPi3 Sandbox

## Dev Setup

### MacOS High Sierra 10.13.6

1. Install [Homebrew](https://brew.sh/)
2. Follow [Nerves installation instructions](https://hexdocs.pm/nerves/installation.html#macos)
   1. During `asdf install erlang 21.1`
      1. If this error appears: `./otp_build: line 319: autoconf: command not found` 
         1. Follow these [instructions for setting up the asdf-erlang plugin](https://github.com/asdf-vm/asdf-erlang/blob/master/README.md#osx) 
         2. Try installing Erlang again
      2. If this message appears: `No usable OpenSSL found` 
         1. Install openssl: `brew install openssl`
         2. Uninstall Erlang: `asdf uninstall erlang 21.1`
         3. Try installing Erlang again
3. Follow [Scenic installation instructions](https://github.com/boydm/scenic_new)
4. Follow [Scenic Nerves guide](https://github.com/boydm/scenic/blob/master/guides/getting_started_nerves.md)
5. Insert SD card into Raspberry Pi3, connect HDMI display to RPi3, and power it on

