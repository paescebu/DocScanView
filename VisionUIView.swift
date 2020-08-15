//
//  VisionUI.swift
//  VisionUI
//
//  Created by Pascal Burlet on 14.08.20.
//

import Foundation
import SwiftUI
import VisionKit

final class VisionUIView: UIViewControllerRepresentable {
    
    let completion: ((VNDocumentCameraScan) -> ())?

    init(completion: ((VNDocumentCameraScan) -> ())?) {
        self.completion = completion
    }
    
    //Handles updates from the Delegate to SwiftUI
    class ScannerViewCoordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        let visionView: VisionUIView
        init(withVisionView visionView: VisionUIView) {
            self.visionView = visionView
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            visionView.completion?(scan)
        }
    }
    
    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let scannerViewController = VNDocumentCameraViewController()
        scannerViewController.delegate = context.coordinator
        return scannerViewController
    }
    
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {
        //nothing to do here
    }
    
    func makeCoordinator() -> ScannerViewCoordinator {
        return ScannerViewCoordinator(withVisionView: self)
    }
}
