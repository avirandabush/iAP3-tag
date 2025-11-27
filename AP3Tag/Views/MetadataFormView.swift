//
//  MetadataFormView.swift
//  AP3Tag
//
//  Created by Aviran Dabush on 26/11/2025.
//

import SwiftUI

struct MetadataFormView: View {
    @ObservedObject var viewModel: AppViewModel
    
    var body: some View {
        Group {
            if let selectedURL = viewModel.selectedFileURL {
                Text("edit file: \(selectedURL.url.lastPathComponent)")
                    .font(.largeTitle)
                    .foregroundStyle(.red)
            } else {
                Text("Choose file to start edit it's metadata.")
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue.opacity(0.4))
    }
}

#Preview {
    MetadataFormView(viewModel: AppViewModel())
}
