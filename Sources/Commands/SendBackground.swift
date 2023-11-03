import Foundation
import ArgumentParser
import APNS

struct SendBackground: AsyncParsableCommand {

    // MARK: Configuration

    static var configuration = CommandConfiguration(
        commandName: "background",
        abstract: "Send a background push notification."
    )

    // MARK: Options

    @OptionGroup var sendOptions: Send.Options

    // MARK: Execution

    func run() async throws {

        // Create the APNS client
        let client = try await APNSClient(options: sendOptions)

        // Defer shutdown
        defer {
            client.shutdown { _ in print("Failed to shutdown APNSClient") }
        }

        // Send the notification
        try await client.sendBackgroundNotification(
            .init(
                expiration: .immediately,
                topic: sendOptions.topic,
                payload: EmptyPayload() // TODO
            ),
            deviceToken: sendOptions.deviceToken
        )

        // Exit the command
        throw CleanExit.message("Sent push notification.")
    }
}
