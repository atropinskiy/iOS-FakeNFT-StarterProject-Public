//
//  CartUnitTest.swift
//  FakeNFT
//
//  Created by Oleg Kozyrev on 17.05.2025.
//

@testable import FakeNFT
import XCTest

@MainActor
final class CartUnitTest: XCTestCase {
    var viewModel: CartViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = CartViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testInitialState() {
        XCTAssertTrue(viewModel.nfts.isEmpty, "Корзина должна быть пустой")
    }
}
