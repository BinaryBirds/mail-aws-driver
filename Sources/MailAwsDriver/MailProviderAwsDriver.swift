//
//  MailProviderAwsDriver.swift
//  MailAwsDriver
//
//  Created by Tibor Bodecs on 2020. 04. 28..
//

struct MailProviderAwsDriver: MailProviderDriver {

    let configuration: MailProviderAwsConfiguration
    
    private static var client: AWSClient!
    
    init(configuration: MailProviderAwsConfiguration) {
        self.configuration = configuration
        Self.client = AWSClient(credentialProvider: configuration.credentialProvider, httpClientProvider: .createNew)
    }

    func makeProvider(with context: MailProviderContext) -> MailProvider {
        MailProviderAwsSes(configuration: configuration, context: context, client: Self.client)
    }

    func shutdown() {
        try? Self.client.syncShutdown()
    }
}
