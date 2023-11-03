import Foundation
import ArgumentParser
import APNS

struct SendAlert: AsyncParsableCommand {

    // MARK: Configuration

    static var configuration = CommandConfiguration(
        commandName: "alert",
        abstract: "Send a user visible push notification."
    )

    // MARK: Options

    @OptionGroup var sendOptions: Send.Options

    @Option(
        name: .customLong("title"),
        help: "The notification title."
    )
    var title: String?

    @Option(
        name: .customLong("subtitle"),
        help: "The notification subtitle."
    )
    var subtitle: String?

    @Option(
        name: .customLong("body"),
        help: "The notification body."
    )
    var body: String?

    @Flag(
        name: .customLong("sound"),
        help: "Enable the default alert sound."
    )
    var isSoundEnable = false

    // MARK: Execution

    func run() async throws {

        // Create the APNS client
        let client = try await APNSClient(options: sendOptions)

        // Defer shutdown
        defer {
            client.shutdown { _ in print("Failed to shutdown APNSClient") }
        }

        // Send the notification
        try await client.sendAlertNotification(
            .init(
                alert: .init(
                    title: title.map { .raw($0) },
                    subtitle: subtitle.map { .raw($0) },
                    body: body.map { .raw($0) },
                    launchImage: nil
                ),
                expiration: .immediately,
                priority: .immediately,
                topic: sendOptions.topic,
                payload: EmptyPayload(), // TODO
                sound: isSoundEnable ? .default : nil
            ),
            deviceToken: sendOptions.deviceToken
        )

        // Exit the command
        throw CleanExit.message("Sent push notification.")
    }
}
