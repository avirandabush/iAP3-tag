//
//  FilePickerService.swift
//  AP3Tag
//
//  Created by Aviran Dabush on 26/11/2025.
//

import AppKit
import UniformTypeIdentifiers

class FilePickerService {
    
    let supportedContentTypes: [UTType] = [.mp3, .wav, .mpeg2Video, .mpeg4Audio, .mpeg4Movie]
    
    func openFolderPicker() -> [URL] {
        return showPanel(canChooseFiles: false, canChooseDirectories: true)
    }
    
    func openFilePicker() -> [URL] {
        return showPanel(canChooseFiles: true, canChooseDirectories: false)
    }
    
    func getFilesFromDirectory(url: URL) -> [URL] {
        return scanDirectory(url: url)
    }
    
    private func showPanel(canChooseFiles: Bool, canChooseDirectories: Bool) -> [URL] {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = true
        panel.canChooseFiles = canChooseFiles
        panel.canChooseDirectories = canChooseDirectories
        
        panel.allowedContentTypes = supportedContentTypes
        
        if panel.runModal() == .OK {
            return panel.urls
        }
        return []
    }
    
    private func scanDirectory(url: URL) -> [URL] {
        let fm = FileManager.default
        var audioFiles: [URL] = []
        
        guard let enumerator = fm.enumerator(
            at: url,
            includingPropertiesForKeys: [.contentTypeKey],
            options: [.skipsHiddenFiles]
        ) else {
            print("Error: couldn't enumerate for \(url.lastPathComponent)")
            return []
        }
        
        for case let fileURL as URL in enumerator {
            do {
                guard let fileUTType = try fileURL.resourceValues(forKeys: [.contentTypeKey]).contentType else {
                    continue
                }
                
                let isSupported = supportedContentTypes.contains { supportedType in
                    fileUTType.conforms(to: supportedType)
                }
                
                if isSupported {
                    audioFiles.append(fileURL)
                }
            } catch {
                print("Error enumerating files \(fileURL.lastPathComponent): \(error.localizedDescription)")
                continue
            }
        }
        
        return audioFiles
    }
}
