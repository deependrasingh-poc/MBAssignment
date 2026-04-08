//
//  UniversityViewModelTests.swift
//  iOSAssignment
//
//  Created by Deependra Singh on 08/04/26.
//
import XCTest
@testable import iOSAssignment

final class UniversityViewModelTests: XCTestCase {

    @MainActor
    func testLoadUniversitiesSuccess() async {
        // GIVEN
        let mockService = MockUniversityService()
        let viewModel = UniversityViewModel(service: mockService)

        // WHEN
        await viewModel.loadUniversities()

        // THEN
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.showErrorAlert)
        XCTAssertEqual(viewModel.universities.count, 2)
        XCTAssertEqual(viewModel.universities.first?.name, "IIT Delhi")
    }

    @MainActor
    func testLoadUniversitiesFailure() async {
        // GIVEN
        let mockService = MockUniversityService()
        mockService.shouldThrowError = true
        
        let viewModel = UniversityViewModel(service: mockService)

        // WHEN
        await viewModel.loadUniversities()

        // THEN
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertTrue(viewModel.showErrorAlert)
        XCTAssertEqual(viewModel.errorMessage, "Something went wrong. Please try again.")
        XCTAssertTrue(viewModel.universities.isEmpty)
    }
}
