import Foundation
import ArgumentParser

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
}
