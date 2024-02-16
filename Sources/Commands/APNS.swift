import Foundation
import ArgumentParser

// App version constant
private let APP_VERSION = "1.0.0"

@main
struct APNS: AsyncParsableCommand {

    // MARK: Configuration

    static var configuration = CommandConfiguration(
        commandName: "apns",
        abstract: "A command line tool to send push notifications using the Apple Push Notification Service.",
        subcommands: [
            Send.self
        ]
    )

    // MARK: Options

    @Flag(
        name: [.customShort("v"), .customLong("version")],
        help: "Show the version number."
    )
    var showVersion = false

    @Flag(
        name: [.customLong("about")],
        help: "Show more information about the command."
    )
    var showAbout = false

    // MARK: Execution

    func run() throws {
        if showAbout {
            throw CleanExit.message("""
                APNS version \(APP_VERSION)

                For more information about the APNS command, go to:
                https://github.com/tdimeco/apns
                """)
        } else if showVersion {
            throw CleanExit.message(APP_VERSION)
        } else {
            throw CleanExit.helpRequest()
        }
    }
}
