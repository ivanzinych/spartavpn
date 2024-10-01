//
//  URLRequest.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 25.09.2024.
//

import Moya

extension URLRequest {

    /// An enumeration of default haeders
    /// and a custom header.
    enum Header {

        /// Informs the server about the types of data that can be sent back.
        case accept

        /// Which character encodings the client understands.
        case acceptCharset

        /// The encoding algorithm, usually a compression algorithm, that can be used on the resource sent back.
        case acceptEncoding

        /// Contains the credentials to authenticate a user-agent with a server.
        case authorization

        /// Directives for caching mechanisms in both requests and responses.
        case cacheControl

        /// Controls whether the network connection stays open after the current transaction finishes.
        case connection

        /// Used to specify the compression algorithm.
        case contentEncoding

        /// The size of the resource, in decimal number of bytes.
        case contentLength

        /// Indicates the media type of the resource.
        case contentType
        
        /// Controls how long a persistent connection should stay open.
        case keepAlive

        /// Contains a characteristic string that allows the network protocol peers to identify the application type, operating system, software vendor or software version of the requesting software user agent.
        case userAgent
        
        /// Operating system.
        case platform
        
        case method
        
        /// App version in store.
        case appMarketVersion

        /// A custom header with the specified name.
        case custom(name: String)
    }

}

// MARK: - Hashable

extension URLRequest.Header: Hashable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.rawValue)
    }

}

// MARK: - Transformation

extension URLRequest.Header {

    /// Transforms the header into a dictionary
    /// with a single key-value pair using
    /// the specified value as the pair value
    /// and using the header's name as a key
    /// in that key-value pair.
    ///
    /// - Parameter value: A value to be put into
    ///                    the key-value pair.
    func ditionary(value: String) -> [ String: String ] {
        return [ self.rawValue: value ]
    }

    /// Inserts a new key-value pair into the specified
    /// dictionary.
    ///
    /// The pair's key is the header's name and the pair's
    /// value is the specified value.
    ///
    /// - Parameter into: A dictionary to insert
    ///                   a new key-value pairt into.
    func insert(value: String,
                into dictionary: inout [String: String]) {
        dictionary[self.rawValue] = value
    }

}

// MARK: - RawRepresentable

extension URLRequest.Header: RawRepresentable {

    fileprivate enum DefaultNames {
        static let accept = "Accept"
        static let acceptCharset = "Accept-Charset"
        static let acceptEncoding = "Accept-Encoding"
        static let authorization = "Authorization"
        static let cacheControl = "Cache-Control"
        static let connection = "Connection"
        static let contentEncoding = "Content-Encoding"
        static let contentLength = "Content-Length"
        static let contentType = "Content-Type"
        static let keepAlive = "Keep-Alive"
        static let userAgent = "User-Agent"
        static let platform = "X-Device-OS"
        static let appMarketVersion = "X-App-Version"
        static let method = "method"
    }

    typealias RawValue = String

    var rawValue: String {
        switch self {
        case .accept:
            return DefaultNames.accept
        case .acceptCharset:
            return DefaultNames.acceptCharset
        case .acceptEncoding:
            return DefaultNames.acceptEncoding
        case .authorization:
            return DefaultNames.authorization
        case .cacheControl:
            return DefaultNames.cacheControl
        case .connection:
            return DefaultNames.connection
        case .contentEncoding:
            return DefaultNames.contentEncoding
        case .contentLength:
            return DefaultNames.contentLength
        case .contentType:
            return DefaultNames.contentType
        case .keepAlive:
            return DefaultNames.keepAlive
        case .userAgent:
            return DefaultNames.userAgent
        case .platform:
            return DefaultNames.platform
        case .appMarketVersion:
            return DefaultNames.appMarketVersion
        case .method:
            return DefaultNames.method
        case .custom(let name):
            return name
        }
    }

    // swiftlint:disable:next cyclomatic_complexity
    init?(rawValue: Self.RawValue) {
        switch rawValue {
        case DefaultNames.accept:
            self = .accept
        case DefaultNames.acceptCharset:
            self = .acceptCharset
        case DefaultNames.acceptEncoding:
            self = .acceptEncoding
        case DefaultNames.authorization:
            self = .authorization
        case DefaultNames.cacheControl:
            self = .cacheControl
        case DefaultNames.connection:
            self = .connection
        case DefaultNames.contentEncoding:
            self = .contentEncoding
        case DefaultNames.contentLength:
            self = .contentLength
        case DefaultNames.contentType:
            self = .contentType
        case DefaultNames.keepAlive:
            self = .keepAlive
        case DefaultNames.userAgent:
            self = .userAgent
        case DefaultNames.platform:
            self = .platform
        case DefaultNames.appMarketVersion:
            self = .appMarketVersion
        default:
            self = .custom(name: rawValue)
        }
    }
}
