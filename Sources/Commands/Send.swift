import Foundation
import ArgumentParser
import AnyCodable

struct Send: ParsableCommand {

    // MARK: Configuration

    static var configuration = CommandConfiguration(
        commandName: "send",
        abstract: "Send a push notification.",
        subcommands: [
            SendAlert.self,
            SendBackground.self
        ],
        defaultSubcommand: SendAlert.self
    )

    // MARK: Options

    struct Options: ParsableArguments {

        @Flag(
            name: [.customShort("p"), .customLong("production")],
            help: "Use the production APNS server (default is sandbox)."
        )
        var isProduction = false

        @Option(
            name: [.customShort("k"), .customLong("key-file")],
            help: "The private key file.",
            transform: URL.init(fileURLWithPath:)
        )
        var keyURL: URL

        @Option(
            name: .customLong("key-id"),
            help: "The private key identifier."
        )
        var keyId: String

        @Option(
            name: .customLong("team-id"),
            help: "The app team identifier."
        )
        var teamId: String

        @Option(
            name: [.customShort("t"), .customLong("topic")],
            help: "The app bundle identifier."
        )
        var topic: String

        @Option(
            name: [.customShort("d"), .customLong("device-token")],
            help: "The device token."
        )
        var deviceToken: String

        @Argument(
            help: "The notification payload (JSON formatted)."
        )
        var payload: String?

        func decodedPayload() throws -> [String: AnyCodable] {
            guard let payload else { return [:] }
            let data = payload.data(using: .utf8) ?? Data()
            return try JSONDecoder().decode([String: AnyCodable].self, from: data)
        }
    }
}
