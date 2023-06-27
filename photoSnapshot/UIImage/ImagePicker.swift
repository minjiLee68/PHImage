//
//  ImagePicker.swift
//  photoSnapshot
//
//  Created by 이민지 on 2023/06/26.
//

import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
//    let configuration: PHPickerConfiguration
    @Binding var selectedImage: UIImage?
    @Binding var isShowingImagePicker: Bool

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        configuration.filter = .images
        configuration.selectionLimit = 1
        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = context.coordinator
        return controller
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: PHPickerViewControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            guard let result = results.first else {
                // 선택된 이미지가 없는 경우
                parent.selectedImage = nil
                parent.isShowingImagePicker = false
                return
            }
            
            result.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                DispatchQueue.main.async {
                    if let image = image as? UIImage {
                        self.parent.selectedImage = image
                    }
                }
            }
            
            self.parent.isShowingImagePicker = false
            
//            parent.selectedImage = results.first?.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { (image, error) in
//                DispatchQueue.main.async {
//                    if let image = image as? UIImage {
//                        self.parent.selectedImage = image
//                    }
//                }
//            }) as? UIImage
//
//            parent.isShowingImagePicker = false
        }
    }
}

