//
//  AppViewModel.swift
//  AP3Tag
//
//  Created by Aviran Dabush on 26/11/2025.
//

import Foundation
import Combine
import UniformTypeIdentifiers

class AppViewModel: ObservableObject {
    @Published var selectedFiles: [AudioFile] = []
    @Published var selectedFileURL: AudioFile?
    
    let pickerService = FilePickerService()
    
    func clearFiles() {
        selectedFiles.removeAll()
    }
    
    func openFilePicker() {
        selectedFiles.append(contentsOf: pickerService.openFilePicker().map { AudioFile(url: $0) })
        print(selectedFiles)
    }
    
    func openFolderPicker() {
        let folderURLs = pickerService.openFolderPicker()
        var newFiles: [URL] = []
        
        for folderURL in folderURLs {
            newFiles.append(contentsOf: pickerService.getFilesFromDirectory(url: folderURL))
        }
        
        self.selectedFiles.append(contentsOf: newFiles.map { AudioFile(url: $0) })
        print(selectedFiles)
    }
}
