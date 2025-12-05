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
            if viewModel.filesList.isEmpty {
                Text("Please select files")
            } else {
                List(selection: $selectedFile) {
                    ForEach(viewModel.filesList) { file in
                        fileRowView(url: file.url)
                            .contentShape(Rectangle())
                            .background {
                                viewModel.selectedFile == file
                                ? Color.blue.opacity(0.1)
                                : Color.clear
                            }
                            .onTapGesture {
                                viewModel.selectedFile = viewModel.selectedFile == file
                                ? nil
                                : file
                            }
                    }
                }
                .listStyle(.sidebar)
                .background(.clear)
                .onChange(of: selectedFile) { _, newValue in
                    DispatchQueue.main.async {
                        self.viewModel.selectedFile = newValue
                    }
                }
            }
        }
        .padding(0)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue.opacity(0.2))
    }
    
    private func fileRowView(url: URL) -> some View {
        VStack {
            HStack {
                Image(systemName: "music.note")
                    .foregroundStyle(.blue)
                
                Text(url.lastPathComponent)
                    .lineLimit(1)
                
                Spacer()
            }
            .padding(.vertical, 4)
            
            Divider()
        }
    }
}

#Preview {
    FilesView(viewModel: AppViewModel())
}
