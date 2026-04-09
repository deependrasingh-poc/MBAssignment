//
//  UniversityViewModel.swift
//  iOSAssignment
//
//  Created by test on 22/12/25.
//

import Foundation

@MainActor
class UniversityViewModel: ObservableObject {

    @Published var universities: [University] = []
    @Published var isLoading = false
    @Published var showErrorAlert = false
    @Published var errorMessage: String = ""

    private let service: UniversityServiceProtocol

    init(service: UniversityServiceProtocol) {
        self.service = service
    }

    func loadUniversities() async {
        isLoading = true
        defer { isLoading = false }

        do {
            universities = try await service.fetchUniversities(APIEndpoints.universitiesByCountry)
        } catch {
            errorMessage = "Something went wrong. Please try again."
            showErrorAlert = true
        }
    }
}

extension UniversityViewModel: ListViewModel {
    var items: [University] {
        get { universities }
        set { universities = newValue }
    }

    var showError: Bool {
        get { showErrorAlert }
        set { showErrorAlert = newValue }
    }

    func loadItems() async {
        await loadUniversities()
    }
}
