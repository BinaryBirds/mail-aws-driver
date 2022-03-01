import XCTest
@testable import MailAwsDriver

final class MailAwsDriverTests: XCTestCase {
    
    static var storages: MailProviders!

    static var dotenv: [String: String] = {
        let projectRoot = "/" + #file.split(separator: "/").dropLast(3).joined(separator: "/")
        let filePath = projectRoot + "/.env.testing"
        guard let file = try? String(contentsOf: URL(fileURLWithPath: filePath)) else {
            fatalError("Missing `.env.testing` file")
        }
        var dotenv: [String: String] = [:]
        for line in file.components(separatedBy: "\n") {
            let parts = line.components(separatedBy: "=")
            guard
                let key = parts.first?.replacingOccurrences(of: "\"", with: ""),
                let value = parts.last?.replacingOccurrences(of: "\"", with: "")
            else {
                continue
            }
            dotenv[key] = value
        }
        return dotenv
    }()
    
    override class func setUp() {
        super.setUp()

        guard let regionValue = dotenv["REGION"] else {
            fatalError("Missing REGION env variable")
        }
        let endpoint = dotenv["ENDPOINT"]
        let region = Region(rawValue: regionValue)

        storages = MailProviders()
        storages.use(.ses(region: region, endpoint: endpoint), as: .ses)
        storages.default(to: .ses)
    }

    override class func tearDown() {
        super.tearDown()
        
        storages.shutdown()
    }
    
    // MARK: - private
    
    private var provider: MailProvider {
        let elg = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        return Self.storages.provider(.ses, logger: .init(label: "[test-logger]"), on: elg.next())!
    }

    func testSendMail() async throws {
        _ = try await provider.send(.init(from: "noreply@feathercms.com",
                                    to: [
                                        "mail.tib@gmail.com"
                                    ],
                                    subject: "test",
                                    content: .init(value: "test", type: .text)))
    }

}
