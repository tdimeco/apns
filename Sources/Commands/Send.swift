import Foundation
import ArgumentParser
import AnyCodable

struct Send: ParsableCommand {

    // MARK: Configuration

    static var configuration = CommandConfiguration(
        commandName: "send",
        abstract: "Send a push notification to a device.",
        subcommands: [
            SendAlert.self,
            SendBackground.self
        ],
        defaultSubcommand: SendAlert.self
    )

    // MARK: Options

    struct TargetOptions: ParsableArguments {

        @Flag(
            name: [.customShort("p"), .customLong("production")],
            help: "Use the production APNS server (default is sandbox)."
        )
        var isProduction = false

        @Option(
            name: [.customShort("k"), .customLong("key-file")],
            help: .init("The private key file.", valueName: "file"),
            transform: URL.init(fileURLWithPath:)
        )
        var keyURL: URL

        @Option(
            name: .customLong("key-id"),
            help: .init("The private key identifier.", valueName: "id")
        )
        var keyId: String

        @Option(
            name: .customLong("team-id"),
            help: .init("The app team identifier.", valueName: "id")
        )
        var teamId: String

        @Option(
            name: [.customShort("t"), .customLong("topic")],
            help: "The app bundle identifier."
        )
        var topic: String

        @Option(
            name: [.customShort("d"), .customLong("device-token")],
            help: .init("The device token.", valueName: "token")
        )
        var deviceToken: String
    }

    struct PayloadOptions: ParsableArguments {

        @Argument(help: "The notification payload (JSON formatted).")
        var payload: String?

        func decodedPayload() throws -> [String: AnyCodable] {
            guard let payload else { return [:] }
            let data = payload.data(using: .utf8) ?? Data()
            return try JSONDecoder().decode([String: AnyCodable].self, from: data)
        }
    }
}
