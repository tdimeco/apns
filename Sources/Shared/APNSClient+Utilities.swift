import Foundation
import APNS

extension APNSClient<JSONDecoder, JSONEncoder> {

    /// Init a client using the given target options.
    ///
    /// - Parameter options: The target options.
    convenience init(options: Send.TargetOptions) async throws {

        // Read the private key
        let privateKey = try await options.keyURL.readContent()

        // Create the client
        self.init(
            configuration: .init(
                authenticationMethod: .jwt(
                    privateKey: try .loadFrom(string: privateKey),
                    keyIdentifier: options.keyId,
                    teamIdentifier: options.teamId
                ),
                environment: options.isProduction ? .production : .development
            ),
            eventLoopGroupProvider: .createNew,
            responseDecoder: JSONDecoder(),
            requestEncoder: JSONEncoder()
        )
    }
}
