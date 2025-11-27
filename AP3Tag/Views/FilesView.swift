//
//  FilesView.swift
//  AP3Tag
//
//  Created by Aviran Dabush on 26/11/2025.
//

import SwiftUI

struct FilesView: View {
    @ObservedObject var viewModel: AppViewModel
    @State var selectedFile: AudioFile?
    
    var body: some View {
        ZStack {
            if viewModel.selectedFiles.isEmpty {
                Text("Please select files")
            } else {
                List(selection: $selectedFile) {
                    ForEach(viewModel.selectedFiles) { file in
                        FileRowView(url: file.url)
                            .tag(file)
                    }
                }
                .listStyle(.sidebar)
                .background(.clear)
                .onChange(of: selectedFile) { oldValue, newValue in
                    DispatchQueue.main.async {
                        self.viewModel.selectedFileURL = newValue
                    }
                }
            }
        }
        .padding(0)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue.opacity(0.2))
    }
}

#Preview {
    FilesView(viewModel: AppViewModel())
}
