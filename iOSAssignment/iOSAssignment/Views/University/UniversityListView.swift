//
//  UniversityListView.swift
//  iOSAssignment
//
//  Created by test on 22/12/25.
//
import SwiftUI

struct UniversityListView: View {

    @StateObject var viewModel: UniversityViewModel

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Indian Universities")
                .navigationDestination(for: University.self) { university in
                    UniversityDetailView(university: university)
                }
                .overlay {
                    loadingOverlay
                }
                .alert("Error", isPresented: $viewModel.showErrorAlert) {
                    Button("Retry") {
                        Task {
                            await viewModel.loadUniversities()
                        }
                    }
                    Button("Cancel", role: .cancel) { }
                } message: {
                    Text(viewModel.errorMessage)
                }
                .task {
                    await viewModel.loadUniversities()
                }
        }
    }

    // MARK: - Main Content
    @ViewBuilder
    private var content: some View {
        ZStack {
            List(viewModel.universities) { university in
                universityRow(university)
            }

            if viewModel.isLoading {
                Color.clear
            } else if viewModel.universities.isEmpty {
                emptyState
            }
        }
    }
    
    // MARK: - Empty view
    @ViewBuilder
    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: "tray")
                .font(.largeTitle)
                .foregroundColor(.gray)

            Text("No data available")
                .font(.headline)

            Text("There are no universities for this country.")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // MARK: - Row
    @ViewBuilder
    private func universityRow(_ university: University) -> some View {
        NavigationLink(value: university) {
            VStack(alignment: .leading) {
                Text(university.name)
                    .font(.headline)

                Text(university.stateProvince ?? "India")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }

    // MARK: - Loading Overlay
    @ViewBuilder
    private var loadingOverlay: some View {
        if viewModel.isLoading {
            ProgressView()
        }
    }
}

#Preview {
    UniversityListView(
        viewModel: UniversityViewModel(
            service: MockUniversityService()
        )
    )
}

