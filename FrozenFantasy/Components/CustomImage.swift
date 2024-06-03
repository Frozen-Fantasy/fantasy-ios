//
//  CustomImage.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 27.05.2024.
//

import CachedAsyncImage
import SDWebImageSwiftUI
import SwiftUI

extension URLCache {
    static let imageCache = URLCache(
        memoryCapacity: 256*1000*1000,
        diskCapacity: 1000*1000*1000)
}

struct CustomImage<Content>: View where Content: View {
    let url: URL?
    let content: (Image) -> Content

    init(url: URL?, content: @escaping (Image) -> Content) {
        self.url = url
        self.content = content
    }

    var body: some View {
        if let url, url.absoluteString.hasSuffix(".svg") {
            WebImage(url: url) { image in
                content(image)
            } placeholder: {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.black.opacity(0.05))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        } else {
            CachedAsyncImage(url: url) { image in
                content(image)
            } placeholder: {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.black.opacity(0.05))
            }
        }
    }
}

#Preview {
    CustomImage(url: Player.dummy.photo) { image in
        image
            .resizable()
            .scaledToFit()
    }
    .background(.white)
    .clipShape(Circle())
    .shadow(radius: 8)
    .padding()
}
