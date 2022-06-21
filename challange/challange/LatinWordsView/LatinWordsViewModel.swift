//
//  LatinWordsViewModel.swift
//  challange
//
//  Created by Inti Albuquerque on 21/06/22.
//

import Foundation
import SwiftUI
struct LatinWordsModel: Identifiable, Decodable, Equatable {
    let id: Int
    let title: String
    let subtitle: String
    let content: String
}

class LatinWordsViewModel: ObservableObject {
    @Published var offset: CGFloat = 0
    @Published var listOfWords: [LatinWordsModel] = []
    @Published var showAlert = false
    let dataUrl = "https://raw.githubusercontent.com/catchnz/ios-test/master/data/data.json"
    let dataFetcher: DataFetcherProtocol
    var error: DataFetcherError?
    init(dataFetcher: DataFetcherProtocol = DataFetcher()) {
        self.dataFetcher = dataFetcher
    }
    
    func fetchData() async {
        do {
            let data: [LatinWordsModel] = try await self.dataFetcher.fetchData(from: self.dataUrl)
            await MainActor.run {
                withAnimation {
                    self.listOfWords = data
                    self.offset = 0
                }
            }
        } catch {
            if let error = error as? DataFetcherError {
                self.error = error
                await MainActor.run(body: {
                    self.showAlert = true
                })
            }
        }
    }
    
    @MainActor
    func setOffset(_ offset: CGFloat) {
        self.offset = offset
    }
}
