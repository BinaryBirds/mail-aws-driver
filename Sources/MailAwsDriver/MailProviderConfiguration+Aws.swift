//
//  MailProviderConfigurationFactory.swift
//  MailAwsDriver
//
//  Created by Tibor Bodecs on 2020. 04. 28..
//

public extension MailProviderConfigurationFactory {
 
    static func ses(credentialProvider: CredentialProviderFactory = .default,
                      region: Region,
                      endpoint: String? = nil) -> MailProviderConfigurationFactory {
        .init {
            MailProviderAwsConfiguration(credentialProvider: credentialProvider,
                                         region: region,
                                         endpoint: endpoint)
        }
    }

}
