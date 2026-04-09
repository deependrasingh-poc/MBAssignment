//
//  UniversityViewModelTests.swift
//  iOSAssignment
//
//  Created by test on 08/04/26.
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
    
    @MainActor
    func testListViewModelProtocolConformance() async {

        // GIVEN
        let mock = MockUniversityService()
        let viewModel: any ListViewModel<University> =
            UniversityViewModel(service: mock)

        // WHEN
        await viewModel.loadItems()

        // THEN
        XCTAssertEqual(viewModel.items.count, 2)
        XCTAssertFalse(viewModel.showError)
    }
    
    @MainActor
    func testItemsSetter() {
        let mock = MockUniversityService()
        let vm = UniversityViewModel(service: mock)

        vm.items = [
            University(name: "Test", country: "India", stateProvince: "Delhi", webPages: [])
        ]

        XCTAssertEqual(vm.universities.count, 1)
    }
    
    @MainActor
    func testShowErrorSetter() {
        let vm = UniversityViewModel(service: MockUniversityService())
        vm.showError = true
        XCTAssertTrue(vm.showErrorAlert)
    }
}
