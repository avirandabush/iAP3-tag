//
//  RightToolbar.swift
//  AP3Tag
//
//  Created by Aviran Dabush on 26/11/2025.
//

import SwiftUI

struct RightToolbar: View {
    @ObservedObject var viewModel: AppViewModel
    
    var body: some View {
        HStack {
            Button {
                viewModel.deleteFields()
            } label: {
                Image(systemName: "delete.backward.fill")
                    .foregroundStyle(.blue)
            }
            .padding(0)
            .padding(.trailing, 10)
            .help("Delete all fields")
            .buttonStyle(.glass)
            
            Button {
                viewModel.cancelChanges()
            } label: {
                Image(systemName: "minus.circle.fill")
                    .foregroundStyle(.blue)
            }
            .padding(0)
            .padding(.trailing, 10)
            .help("Cancel changes")
            .buttonStyle(.glass)
            
            Button {
                viewModel.undo()
            } label: {
                Image(systemName: "arrow.uturn.backward.circle.fill")
                    .foregroundStyle(.blue)
            }
            .padding(0)
            .padding(.trailing, 10)
            .help("Undo")
            .buttonStyle(.glass)
            
            Button {
                viewModel.redo()
            } label: {
                Image(systemName: "arrow.uturn.forward.circle.fill")
                    .foregroundStyle(.blue)
            }
            .padding(0)
            .padding(.trailing, 10)
            .help("Redo")
            .buttonStyle(.glass)
            
            Button {
                viewModel.saveChanges()
            } label: {
                Image(systemName: "square.and.arrow.down.fill")
                    .foregroundStyle(.blue)
            }
            .padding(0)
            .help("Save changes")
            .buttonStyle(.glass)
        }
    }
}

#Preview {
    RightToolbar(viewModel: AppViewModel())
}
