//
//  MailProviderAwsConfiguration.swift
//  MailAwsDriver
//
//  Created by Tibor Bodecs on 2020. 04. 28..
//

struct MailProviderAwsConfiguration: MailProviderConfiguration {

    /// AWSClient credential provider object
    let credentialProvider: CredentialProviderFactory
    
    /// AWS Region
    let region: Region
        
    /// custom endpoint
    let endpoint: String?
	
    func makeDriver(for _: MailProviders) -> MailProviderDriver {
        MailProviderAwsDriver(configuration: self)
    }
}

