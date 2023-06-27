//
//  PhotoSnapshotViewModel.swift
//  photoSnapshot
//
//  Created by 이민지 on 2023/06/26.
//

import SwiftUI
import Combine
import FirebaseStorage
import CombineFirebaseStorage
import CombineFirebaseFirestore

class PhotoSnapshotViewModel: ObservableObject {
    @Published var photos = [Photo]()
    
    var cancelBag = Set<AnyCancellable>()
    
    func uploadImageToFirebaseStorage(image: UIImage) {
        let reference = Storage.storage().reference(forURL: "\(image)/images.jpg")
        let data: Data = convertImageToData(image: image) ?? Data()
        (reference.putData(data) as AnyPublisher<StorageMetadata, Error>)
            .sink { completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print("error \(error.localizedDescription)")
                }
            } receiveValue: { metadata in
                // Success
            }
            .store(in: &cancelBag)
    }
    
    func convertImageToData(image: UIImage) -> Data? {
        return image.jpegData(compressionQuality: 1.0)
    }
}
