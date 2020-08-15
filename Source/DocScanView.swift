//
//  DocScanView.swift
//
//  Created by Pascal Burlet on 14.08.20.
//

import Foundation
import SwiftUI
import VisionKit

struct DocScanView: UIViewControllerRepresentable {
    
    @Binding var results: [UIImage]
    let cancelled: (() -> ())?
    let failed: ((Error) -> ())?
    
    init(results: Binding<[UIImage]>, cancelled: (()->())?, failedWith failed: ((Error) -> ())?) {
        self.cancelled = cancelled
        self.failed = failed
        self._results = results
    }
    
    //Handles updates from the Delegate to SwiftUI
    class ScannerViewCoordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        let visionView: DocScanView
        init(withVisionView visionView: DocScanView) {
            self.visionView = visionView
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            for pageIndex in 0..<scan.pageCount {
                let image = scan.imageOfPage(at: pageIndex)
                visionView.results.append(image)
            }
            controller.dismiss(animated: true)
        }
        
        func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
            visionView.cancelled?()
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
            visionView.failed?(error)
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
