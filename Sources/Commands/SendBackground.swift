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

    @OptionGroup(title: "Target Device Options") var targetOptions: Send.TargetOptions
    @OptionGroup var payloadOptions: Send.PayloadOptions

    // MARK: Execution

    func run() async throws {

        // Create the APNS client
        let client = try await APNSClient(options: targetOptions)

        // Defer shutdown
        defer {
            try? client.syncShutdown()
        }

        // Send the notification
        try await client.sendBackgroundNotification(
            .init(
                expiration: .immediately,
                topic: targetOptions.topic,
                payload: payloadOptions.decodedPayload()
            ),
            deviceToken: targetOptions.deviceToken
        )

        // Exit the command
        throw CleanExit.message("Background push notification has been sent successfully!")
    }
}
