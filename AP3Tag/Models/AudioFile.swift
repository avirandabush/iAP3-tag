//
//  AudioFile.swift
//  AP3Tag
//
//  Created by Aviran Dabush on 27/11/2025.
//

import Foundation

struct AudioFile: Identifiable, Hashable {
    let id = UUID()
    let url: URL
}
