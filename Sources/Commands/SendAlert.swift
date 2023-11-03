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

    struct AlertOptions: ParsableArguments {

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
    }

    @OptionGroup(title: "Target Device Options") var targetOptions: Send.TargetOptions
    @OptionGroup(title: "Alert Notification Options") var alertOptions: AlertOptions
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
        try await client.sendAlertNotification(
            .init(
                alert: .init(
                    title: alertOptions.title.map { .raw($0) },
                    subtitle: alertOptions.subtitle.map { .raw($0) },
                    body: alertOptions.body.map { .raw($0) },
                    launchImage: nil
                ),
                expiration: .immediately,
                priority: .immediately,
                topic: targetOptions.topic,
                payload: payloadOptions.decodedPayload(),
                sound: alertOptions.isSoundEnable ? .default : nil
            ),
            deviceToken: targetOptions.deviceToken
        )

        // Exit the command
        throw CleanExit.message("Alert push notification has been sent successfully!")
    }
}
