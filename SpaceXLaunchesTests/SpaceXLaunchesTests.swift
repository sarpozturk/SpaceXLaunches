//
//  SpaceXLaunchesTests.swift
//  SpaceXLaunchesTests
//
//  Created by Sarp  on 7.02.2022.
//

import XCTest
@testable import SpaceXLaunches

class SpaceXLaunchesTests: XCTestCase {

    var mockNetwork: MockNetwork!
    var mockViewController: MockViewController!
    var sut: LaunchListViewModel!
    
    override func setUp() {
        super.setUp()
        self.mockNetwork = MockNetwork()
        self.mockViewController = MockViewController()
        self.sut = LaunchListViewModel(network: mockNetwork)
        self.sut.delegate = mockViewController
    }

    override func tearDown() {
        self.mockNetwork = nil
        self.mockViewController = nil
        self.sut = nil
        super.tearDown()
    }
    
    func testViewLoadedWithModels() {
        self.mockNetwork.isSuccess = true
        self.sut.fetchLaunches()
        XCTAssertTrue(self.mockNetwork.fetchLaunchesCalled)
        XCTAssertTrue(self.mockViewController.isFetchLaunchSuccess)
    }

    func testViewLoadedWithError() {
        self.mockNetwork.isSuccess = false
        self.sut.fetchLaunches()
        XCTAssertTrue(self.mockNetwork.fetchLaunchesCalled)
        XCTAssertTrue(self.mockViewController.isFetchLaunchFail)
    }
    
}

class MockNetwork: NetworkDelegate {
    var isSuccess: Bool = true
    var fetchLaunchesCalled: Bool = false
    
    func fetchLaunches(offset: Int, success: @escaping ([Launch]) -> Void, fail: @escaping (Error?) -> Void) {
        fetchLaunchesCalled = true
        if isSuccess {
            success([Launch(id: "", missionName: "", launchDateLocal: "", details: "", links: nil)])
        } else {
            fail(nil)
        }
    }
}

class MockViewController: LaunchListViewModelDelegate {
    var isFetchLaunchSuccess: Bool = false
    var isFetchLaunchFail: Bool = false
    
    func fetchLaunchSuccess() {
        isFetchLaunchSuccess = true
    }
    
    func fetchLaunchFail(_ error: Error?) {
        isFetchLaunchFail = true
    }
}
