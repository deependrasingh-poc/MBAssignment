
//
//  Untitled.swift
//  iOSAssignment
//
//  Created by test on 09/04/26.
//
import SwiftUI

struct ListScreen<
    Item: Identifiable,
    VM: ListViewModel<Item>,
    RowContent: View,
    EmptyContent: View,
    Destination: View
>: View {
    
    @ObservedObject var viewModel: VM

    let title: String
    let rowContent: (Item) -> RowContent
    let emptyContent: () -> EmptyContent
    let destination: (Item) -> Destination

    var body: some View {
        NavigationStack {
            ZStack {
                List(viewModel.items) { item in
                    NavigationLink {
                        destination(item)
                    } label: {
                        rowContent(item)
                    }
                }

                if !viewModel.isLoading && viewModel.items.isEmpty {
                    emptyContent()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.white)
                }
            }
            .toolbarBackground(Color.blue, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.light, for: .navigationBar)
            .overlay { loadingView }
            .alert("Error", isPresented: $viewModel.showError) {
                Button("Retry") { Task { await viewModel.loadItems() } }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text(viewModel.errorMessage)
            }
            .task {
                await viewModel.loadItems()
            }
        }
    }

    @ViewBuilder
    private var loadingView: some View {
        if viewModel.isLoading {
            ProgressView()
        }
    }
}
