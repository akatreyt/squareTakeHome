//
//  NetworkError.swift
//  SquareTakeHome
//
//  Created by Trey Tartt on 4/20/21.
//

import Foundation

public enum NetworkError : Error{
    case NoData(URL)
    case InvalidResponse(URL)
    case InvalidHTTPCode(URL, Int)
    case ErrorDecoding(Error)
    case ErrorDecodingImage(URL)
    case InvalidURL(String)
    case SessionError(URL, Error)
    case Unkown(URL, Error)
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .NoData(let url):
            return "No data returned for url \(url)"
        case .InvalidResponse(let url):
            return "\(url) gave an invalid reponse"
        case .InvalidHTTPCode(let url, let code):
            return "\(url) returned invalid http code \(code)"
        case .ErrorDecoding(let error):
            return "Error decoding data: \(error)"
        case .ErrorDecodingImage(let url):
            return "There was an error decoding image at \(url)"
        case .InvalidURL(let url):
            return "\(url) seems to be invalid"
        case .SessionError(let url, let error):
            return "\(url) had the following error \(error)"
        case .Unkown(let url, let error):
            return "Unkown error for \(url) - \(error)"
        }
    }
}
