//
//  LatinWordsViewModelTests.swift
//  LatinWordsViewModelTests
//
//  Created by Inti Albuquerque on 21/06/22.
//

import XCTest
@testable import challange

class LatinWordsViewModelTests: XCTestCase {

    func testFetchData() {
        Task {
            let dataFetcher = MockDataFetcher()
            let vm = LatinWordsViewModel(dataFetcher: dataFetcher)
            await vm.fetchData()
            
            XCTAssertEqual([LatinWordsModel(id: 3, title: "title", subtitle: "subtitle", content: "content")], vm.listOfWords)
        }
    }
    
    func testError() {
        Task {
            let dataFetcher = MockDataFetcher()
            dataFetcher.showError = true
            let vm = LatinWordsViewModel(dataFetcher: dataFetcher)
            await vm.fetchData()
            
            XCTAssertEqual([], vm.listOfWords)
            XCTAssertEqual(vm.error?.title, "Error")
            XCTAssertEqual(vm.error?.message, "Message")
            XCTAssertTrue(vm.showAlert)
        }
    }
}

class MockDataFetcher: DataFetcherProtocol {
    var showError = false
    func fetchData<T>(from urlString: String, decoder: JSONDecoder) async throws -> T where T : Decodable {
        if showError {
            throw DataFetcherError(title: "Error", message: "Message")
        }
        return [LatinWordsModel(id: 3, title: "title", subtitle: "subtitle", content: "content")] as! T
    }
}
