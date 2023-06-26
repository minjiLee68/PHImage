//
//  PhotoSnapshotViewModel.swift
//  photoSnapshot
//
//  Created by 이민지 on 2023/06/26.
//

import SwiftUI
import PhotosUI

class PhotoSnapshotViewModel: ObservableObject {
    @Published var photos = [Photo]()
}
