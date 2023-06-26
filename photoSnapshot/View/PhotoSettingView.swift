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
    
    @Binding var selectedImage: UIImage
    
    var body: some View {
        VStack {
            geometryView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background {
            Rectangle()
                .fill(Color("BG"))
                .ignoresSafeArea()
        }
    }
    
    @ViewBuilder
    func geometryView() -> some View {
        GeometryReader { proxy in
            let size = proxy.size
            
            ZStack {
                Image(uiImage: selectedImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height)
                
                VStack(spacing: 10) {
                    Text(title)
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

struct PhotoSettingView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoSettingView(selectedImage: .constant(UIImage()))
    }
}
