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
        ListScreen(
            viewModel: viewModel,
            title: "Indian Universities",
            rowContent: { universityRow($0) },
            emptyContent: { emptyState },
            destination: { UniversityDetailView(university: $0) }
        )
        .toolbarBackground(Color.indigo, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.light, for: .navigationBar)
    }

    private func universityRow(_ university: University) -> some View {
        VStack(alignment: .leading) {
            Text(university.name).font(.headline)
            Text(university.stateProvince ?? "India")
                .font(.subheadline).foregroundColor(.gray)
        }
    }

    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: "tray").font(.largeTitle).foregroundColor(.gray)
            Text("No data available").font(.headline)
            Text("There are no universities for this country.")
                .font(.subheadline).foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    UniversityListView(
        viewModel: UniversityViewModel(
            service: MockUniversityService()
        )
    )
}

