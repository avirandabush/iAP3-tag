//
//  AppViewModel.swift
//  AP3Tag
//
//  Created by Aviran Dabush on 26/11/2025.
//

import Foundation
import Combine
import UniformTypeIdentifiers
import ID3TagEditor

class AppViewModel: ObservableObject {
    @Published var filesList: [AudioFile] = []
    @Published var selectedFile: AudioFile?
    @Published var selectedFileMetadata: FileMetadata?
    @Published var editableFile: FileMetadata = FileMetadata()
    @Published var toastMessage: String = ""
    @Published var showToast: Bool = false
    
    private let pickerService = FilePickerService()
    private let metadataService = MetadataService()
    
    func showToast(message: String) {
        toastMessage = message
        showToast = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.showToast = false
            self?.toastMessage = ""
        }
    }
    
    // MARK: - Left toolbar methods
    
    func clearFiles() {
        filesList.removeAll()
        selectedFile = nil
    }
    
    func openFilePicker() {
        filesList.append(contentsOf: pickerService.openFilePicker().map { AudioFile(url: $0) })
    }
    
    func openFolderPicker() {
        let folderURLs = pickerService.openFolderPicker()
        var newFiles: [URL] = []
        
        for folderURL in folderURLs {
            newFiles.append(contentsOf: pickerService.getFilesFromDirectory(url: folderURL))
        }
        
        self.filesList.append(contentsOf: newFiles.map { AudioFile(url: $0) })
    }
    
    // MARK: - Right toolbar methods
    
    func deleteFields() {
        print("deleteFields")
    }
    
    func cancelChanges() {
        print("cancelChanges")
    }
    
    func undo() {
        print("undo")
    }
    
    func redo() {
        print("redo")
    }
    
    func saveChanges() {
        let result = metadataService.writeMetadata(editableFile, at: selectedFile?.url)
        showToast(message: result.message)
    }
    
    // MARK: - List methods
    
    func changeName() {
        print("changeName")
    }
    
    // MARK: - Metadata mothods
    
    func readMetadata(from url: URL) {
        DispatchQueue.main.async {
            let result = self.metadataService.readMetadata(from: self.selectedFile?.url)
            self.selectedFileMetadata = result?.value
            self.editableFile = result?.value ?? FileMetadata()
        }
    }

    func clearSelectedFile() {
        DispatchQueue.main.async {
            self.selectedFileMetadata = nil
        }
    }
}
