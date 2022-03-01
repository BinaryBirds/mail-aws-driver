//
//  MailProviderAwsSes.swift
//  MailAwsDriver
//
//  Created by Tibor Bodecs on 2020. 04. 28..
//

import Foundation

struct MailProviderAwsSes: MailProvider {

    let configuration: MailProviderAwsConfiguration
    let context: MailProviderContext
    private let ses: SES

	init(configuration: MailProviderAwsConfiguration, context: MailProviderContext, client: AWSClient) {
        self.configuration = configuration
        self.context = context
        self.ses = SES(client: client, region: configuration.region, endpoint: configuration.endpoint)
    }

    func send(_ message: MailMessage) async throws -> String {
        let msg: SES.Body
        if message.content.type == .html {
            msg = .init(html: .init(data: message.content.value))
        }
        else {
            msg = .init(text: .init(data: message.content.value))
        }
        let res = try await ses.sendEmail(.init(destination: .init(bccAddresses: message.bcc,
                                                                   ccAddresses: message.cc,
                                                                   toAddresses: message.to),
                                                message: .init(body: msg,
                                                               subject: .init(data: message.subject)),
                                                replyToAddresses: message.replyTo,
                                                source: message.from))
            .get()

        return res.messageId
    }
}


