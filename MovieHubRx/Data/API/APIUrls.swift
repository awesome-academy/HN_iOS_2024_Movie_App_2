//
//  APIUrls.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 14/05/2024.
//

import Foundation

struct APIUrls {
    static let shared = APIUrls()
    
    let key: String
    let baseUrl: String
    let imageUrl: String
    let termUrl: String
    let policyUrl: String
    
    private init() {
        guard let key = Bundle.main.infoDictionary?["API_KEY"] as? String else {
            fatalError("API_KEY is missing in Info.plist")
        }
        
        guard let baseUrl = Bundle.main.infoDictionary?["BASE_URL"] as? String else {
            fatalError("URL is missing in Info.plist")
        }
        
        guard let imageUrl = Bundle.main.infoDictionary?["IMAGE_URL"] as? String else {
            fatalError("URL is missing in Info.plist")
        }
        
        guard let termUrl = Bundle.main.infoDictionary?["TERM_URL"] as? String else {
            fatalError("URL is missing in Info.plist")
        }
        
        guard let policyUrl = Bundle.main.infoDictionary?["POLICY_URL"] as? String else {
            fatalError("URL is missing in Info.plist")
        }
        
        self.key = key
        self.baseUrl = baseUrl.replacingOccurrences(of: "\\", with: "")
        self.imageUrl = imageUrl.replacingOccurrences(of: "\\", with: "")
        self.termUrl = termUrl.replacingOccurrences(of: "\\", with: "")
        self.policyUrl = policyUrl.replacingOccurrences(of: "\\", with: "")
    }
    
    enum Endpoint {
        case image(urlString: String)
        
        var url: String {
            switch self {
            case .image(let urlString):
                return "\(APIUrls.shared.imageUrl)\(urlString)"
            }
        }
    }
}
