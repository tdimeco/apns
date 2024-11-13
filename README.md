# APNS

A command line tool to send push notifications using the Apple Push Notification Service.

Compatible with macOS 13+

## Documentation

### Send alert notifications

This command sends a user visible push notification to the device, with the given title and body:

```shell
apns send alert \
    -k private-key.p8 \
    --key-id ABCD123456 \
    --team-id ABCD123456 \
    -t com.example.app \
    -d <device-identifier> \
    --title "Hello world!" \
    --body "How are you?" \
    --sound
```

By default, it uses the sandbox APNS server. Add the `-p` flag to switch to production.

You can add a custom JSON payload to your notification:

```shell
apns send alert \
    -k private-key.p8 \
    --key-id ABCD123456 \
    --team-id ABCD123456 \
    -t com.example.app \
    -d <device-identifier> \
    --title "Hello world!" \
    --body "How are you?" \
    --sound \
    '{"hello":42}'
```

For more information:

```shell
apns send alert --help
```

### Send background notifications

This command sends a background push notification to the device, with the given custom payload:

```shell
apns send background \
    -k private-key.p8 \
    --key-id ABCD123456 \
    --team-id ABCD123456 \
    -t com.example.app \
    -d <device-identifier> \
    '{"hello":42}'
```

For more information:

```shell
apns send background --help
```

## Installation

### Homebrew

You can install the CLI using [Homebrew](https://brew.sh/):

```bash
brew install tdimeco/apps/apns
```

This is the recommended way to install the CLI.
The CLI auto updates with Homebrew.

### Manual

You can download a precompiled executable from the [Releases][releases] page.
The installer package is signed and notarised by Apple, it just installs the `apns` executable into `/usr/local/bin`.
To uninstall, just remove `/usr/local/bin/apns`.

The CLI does not auto update in this case.

## Build

### Requirements

- Xcode 15.4+ with Swift 5.10

### Build for local deployment

Build the executable using:

```shell
make
```

Then move the `.build/release/apns` executable to one of your $PATH directory. You can run `make install` to do it for you in the `/usr/local/bin/` directory:

```shell
sudo make install
```

To uninstall, just run:

```shell
sudo make uninstall
```

### Build for public distribution

For distribution, build the universal fat-executable using:

```shell
make build-universal
```

The universal executable is located at `.build/apple/Products/Release/apns`.

This allows the executable to run on both Intel and Apple Silicon Macs.

[releases]: https://github.com/tdimeco/apns/releases
