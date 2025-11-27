//
//  LeftToolbar.swift
//  AP3Tag
//
//  Created by Aviran Dabush on 26/11/2025.
//

import SwiftUI

struct LeftToolbar: View {
    @ObservedObject var viewModel: AppViewModel
    
    var body: some View {
        HStack {
            Button {
                viewModel.openFolderPicker()
            } label: {
                Image(systemName: "folder.badge.plus")
                    .foregroundStyle(.blue)
            }
            .padding(0)
            .padding(.trailing, 10)
            .help("Choose Folders")
            .buttonStyle(.glass)
            
            Button {
                viewModel.openFilePicker()
            } label: {
                Image(systemName: "document.badge.plus")
                    .foregroundStyle(.blue)
            }
            .padding(0)
            .padding(.trailing, 10)
            .help("Choose Files")
            .buttonStyle(.glass)
            
            Button {
                viewModel.clearFiles()
            } label: {
                Image(systemName: "clear")
                    .foregroundStyle(.blue)
            }
            .padding(0)
            .help("Clear All Files")
            .buttonStyle(.glass)
        }
    }
}

#Preview {
    LeftToolbar(viewModel: AppViewModel())
}
