//
//  HomeView.swift
//  AP3Tag
//
//  Created by Aviran Dabush on 26/11/2025.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: AppViewModel

    var body: some View {
        HSplitView {
            FilesView(viewModel: viewModel)
                .frame(minWidth: 400, idealWidth: 600, maxWidth: .infinity)
            
            MetadataFormView(viewModel: viewModel)
                .frame(width: 500)
        }
        .frame(minWidth: 600, minHeight: 400)
        
        .navigationTitle("")
        
        .toolbar {
            ToolbarItemGroup(placement: .navigation) {
                LeftToolbar(viewModel: viewModel)
            }
            
            ToolbarItem(placement: .principal) {
                Text("AP3Tag - Files Metadata Editor")
                    .padding()
            }
            
            ToolbarItem(placement: .automatic) {
                RightToolbar(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    HomeView(viewModel: AppViewModel())
}
