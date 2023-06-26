//
//  ContentView.swift
//  photoSnapshot
//
//  Created by 이민지 on 2023/06/26.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    @State var photos = [Photo]()
    @State var selectedImage: UIImage?
    @State var isShowingImagePicker = false
    @State var isShowingPhotoView = false
    
    @State private var selectedTab = 0
    
    var body: some View {
        VStack {
            Text("SnapBook")
                .foregroundColor(.white)
                .font(.custom("TAEBAEK milkyway", size: 32))
                .padding(.top, 25)
            
            parallaxCards()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background {
            Rectangle()
                .fill(Color("BG"))
                .ignoresSafeArea()
        }
        .onChange(of: selectedImage, perform: { _ in
            isShowingPhotoView = true
        })
        .fullScreenCover(isPresented: $isShowingPhotoView, content: {
            if let image = selectedImage {
                PhotoSettingView(selectedImage: image)
            }
        })
    }
    
    @ViewBuilder
    func addPhotosView() -> some View {
        GeometryReader { proxy in
            let size = proxy.size
            
            ZStack {
                Button {
                    isShowingImagePicker = true
                } label: {
                    VStack(spacing: 10) {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .font(.system(size: 31))
                    }
                }
                .sheet(isPresented: $isShowingImagePicker) {
                    let configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
                    ImagePicker(configuration: configuration, selectedImage: $selectedImage, isShowingImagePicker: $isShowingImagePicker)
                }
            }
            .frame(width: size.width, height: size.height, alignment: .center)
            .background {
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .stroke(Color(.white).opacity(0.3))
                    
            }
        }
        .padding(.vertical, 40)
        .padding(.horizontal, 40)
    }
    
    @ViewBuilder
    func parallaxCards() -> some View {
        TabView(selection: $selectedTab) {
            ForEach(photos.indices, id: \.self) { i in
                geometryView(photo: photos[i])
                    .tag(i)
            }
            
            addPhotosView()
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
    
    @ViewBuilder
    func geometryView(photo: Photo) -> some View {
        GeometryReader { proxy in
            let size = proxy.size
            
            ZStack {
                Image(uiImage: photo.image ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height)
                
                VStack(spacing: 10) {
                    Text(photo.title)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.white.opacity(0.6))
                }
            }
            .frame(width: size.width, height: size.height, alignment: .center)
            .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        }
        .padding(.vertical, 30)
        .padding(.horizontal, 40)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
