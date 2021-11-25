//
//  AppCoordinatorTests.swift
//  LocationWikiTests
//
//  Created by Kostiantyn Gorbunov on 22/11/2021.
//

import XCTest
@testable import LocationWiki

class AppCoordinatorTests: XCTestCase {

    var dependency: MockDependency?
    var coordinator: AppCoordinator<MockDependency>?

    override func setUp() {
        super.setUp()
        let localDependency = MockDependency()
        dependency = localDependency
        coordinator = AppCoordinator(dependency: localDependency)
    }

    override func tearDown() {
        coordinator = nil
        dependency = nil
        super.tearDown()
    }

    func testInit() {
        XCTAssertNotNil(dependency)
        XCTAssertNotNil(coordinator)
    }

    func testStart() {
        coordinator?.start()

        // Check total count
        XCTAssertEqual(coordinator?.childCoordinators.count, 1)

        // Home is created
        XCTAssertNotNil(
            coordinator?.childCoordinators.first(where: { $0 is HomeCoordinator })
        )
    }

    func testStop() {
        coordinator?.start()
        XCTAssertFalse(coordinator?.childCoordinators.isEmpty ?? true)
        coordinator?.stop()
        XCTAssertTrue(coordinator?.childCoordinators.isEmpty ?? false)
    }
}
