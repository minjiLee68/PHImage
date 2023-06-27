//
//  PhotoSettingView.swift
//  photoSnapshot
//
//  Created by 이민지 on 2023/06/26.
//

import SwiftUI
import PhotosUI

struct PhotoSettingView: View {
    @State var title = ""
    @State var selectedImage: UIImage
    @Binding var isShowingPhotoView: Bool
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                naviButtonView()
                
                photoView()
                
                titleView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background {
            Rectangle()
                .fill(Color("BG"))
                .ignoresSafeArea()
        }
    }
    
    @ViewBuilder
    func naviButtonView() -> some View {
        HStack(spacing: 0) {
            Button {
                isShowingPhotoView = false
            } label: {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.white.opacity(0.4))
                    .font(.system(size: 21))
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "square.and.arrow.down")
                    .foregroundColor(.white.opacity(0.4))
                    .font(.system(size: 21))
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }
    
    @ViewBuilder
    func photoView() -> some View {
        GeometryReader { proxy in
            let size = proxy.size
            
            ZStack {
                Image(uiImage: selectedImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height)
                
//                Text(title)
//                    .font(.custom(Font.fontName, size: 18))
//                    .foregroundColor(.white.opacity(0.8))
            }
            .frame(width: size.width, height: size.height, alignment: .center)
            .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        }
        .padding(.vertical, 40)
        .padding(.horizontal, 40)
    }
    
    @ViewBuilder
    func titleView() -> some View {
        TextField("사진의 제목을 지어주세요", text: $title)
            .padding()
            .foregroundColor(.white.opacity(0.6))
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.white.opacity(0.4), lineWidth: 1)
            }
            .padding(.vertical, 40)
            .padding(.horizontal, 40)
    }
}

struct PhotoSettingView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoSettingView(selectedImage: UIImage(), isShowingPhotoView: .constant(false))
    }
}
