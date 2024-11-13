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

## Install, Update and Uninstall

The easiest way is to download a precompiled executable from the [Releases][releases] page.
The installer package is signed and notarised by Apple, it just installs the `apns` executable into `/usr/local/bin`.

Alternatively, you can build the project yourself (see below).

To uninstall, just remove `/usr/local/bin/apns`.

## Build

### Requirements

- Xcode 15.4+ with Swift 5.10

### Build for local deployment

Build the executable using:

```shell
swift build -c release
```

Then move the `.build/release/apns` executable to one of your $PATH directory, for example:

```shell
sudo cp .build/release/apns /usr/local/bin
```

### Build for public distribution

For distribution, build the universal fat-executable using:

```shell
swift build -c release --arch arm64 --arch x86_64
```

This allows the executable to run on both Intel and Apple Silicon Macs.

[releases]: https://github.com/tdimeco/apns/releases
