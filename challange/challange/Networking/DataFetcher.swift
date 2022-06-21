//
//  DataFetcher.swift
//  challange
//
//  Created by Inti Albuquerque on 21/06/22.
//

import Foundation

struct DataFetcherError: Error {
    let title: String
    let message: String
}

enum DataFetcherUtils {
    static let decoder = JSONDecoder()
}

protocol DataFetcherProtocol {
    func fetchData<T: Decodable>(from urlString: String, decoder: JSONDecoder) async throws -> T
}

extension DataFetcherProtocol {
    func fetchData<T: Decodable>(from urlString: String) async throws -> T {
        try await self.fetchData(from: urlString, decoder: DataFetcherUtils.decoder)
    }
}

class DataFetcher: DataFetcherProtocol {
    
    func fetchData<T>(from urlString: String, decoder: JSONDecoder) async throws -> T where T : Decodable {
        guard let url = URL(string: urlString) else {
            throw DataFetcherError(title: "Invalid.URL.Title".localized, message: "Invalid.URL.Message".localized)
        }
        do {
            let (responseData, _) = try await URLSession
                .shared
                .data(from: url)
            
            return try decoder.decode(T.self, from: responseData)
        } catch {
            throw DataFetcherError(title: "No.Data.Error.Title".localized, message: "No.Data.Error.Message".localized)
        }
    }
}

