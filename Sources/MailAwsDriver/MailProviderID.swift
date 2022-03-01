//
//  MailProviderID.swift
//  MailAwsDriver
//
//  Created by Tibor Bodecs on 2020. 05. 02..
//

public extension MailProviderID {
    
    /// identifier for the AWS SES
    static var ses: MailProviderID { .init(string: "aws-ses") }
}

