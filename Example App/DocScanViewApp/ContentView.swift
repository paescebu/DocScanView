//
//  ContentView.swift
//
//  Created by Pascal Burlet on 14.08.20.
//

import SwiftUI
import VisionKit

struct ContentView: View {
    var body: some View {
        DocScanView() { result in
            //do somthing with the scanresult
        }
        cancelled: {
            //do something when user cancelled
        }
        failedWith: { error in
            //handle Error
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
