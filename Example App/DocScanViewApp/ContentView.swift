//
//  ContentView.swift
//
//  Created by Pascal Burlet on 14.08.20.
//

import SwiftUI
import VisionKit

struct ContentView: View {
    @State var debugInfo: String = ""
    @State var images: [Image] = []
    @State var showsImage: Bool = false
    @State var currentImageId: Int = 0
    @State var showsScanner: Bool = false
    @Namespace var navigation
    
    var body: some View {
        VStack(spacing: 20) {
            if !showsImage {
                DebugView(debugInfo: $debugInfo)
                Spacer()
                ResultImagesGrid(showsImage: $showsImage, images: $images, currentImageId: $currentImageId, namespace: navigation)
                Button(images.count > 0 ? "Scan more documents" : "Scan documents") {
                    debugInfo.removeAll()
                    showsScanner = true
                }
            }
            else {
                FullScreenImage(showsImage: $showsImage, images: $images, currentImageId: $currentImageId, namespace: navigation)
            }
        }
        .padding()
        .sheet(isPresented: $showsScanner) {
            DocScanView(results: $images) {
                showsScanner = false
                debugInfo = "Scan cancelled"
            } failedWith: { error in
                debugInfo = "\(error.localizedDescription)"
            }
            .edgesIgnoringSafeArea(.all)
        }
        .animation(.interactiveSpring())
    }
}


struct DebugView: View {
    @Binding var debugInfo: String
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Debug:")
                    .font(.title)
                Text(debugInfo)
                    .font(.body)
                
            }
            Spacer()
        }
    }
}

struct FullScreenImage: View {
    @Binding var showsImage: Bool
    @Binding var images: [Image]
    @Binding var currentImageId: Int
    let namespace: Namespace.ID
    var body: some View {
        Group {
            if images.count > 0 {
                images[currentImageId]
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                        showsImage.toggle()
                    })
                    .matchedGeometryEffect(id: "image\(currentImageId)", in: namespace)
            }
        }
    }
}

struct ResultImagesGrid: View {
    @Binding var showsImage: Bool
    @Binding var images: [Image]
    @Binding var currentImageId: Int
    var rows: [GridItem] = [ GridItem(.fixed(100), spacing: 15, alignment: .center) ]
    let namespace: Namespace.ID
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, pinnedViews: /*@START_MENU_TOKEN@*/[]/*@END_MENU_TOKEN@*/) {
                ForEach(0..<images.count, id: \.self) { index in
                    images[index]
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                            currentImageId = index
                            showsImage.toggle()
                        })
                        .matchedGeometryEffect(id: "image\(index)", in: namespace)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
