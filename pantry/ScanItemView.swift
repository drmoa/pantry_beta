//
//  ScanItemView.swift
//  pantry
//
//  Created by Marcelino Nicasio on 8/3/25.
//

import SwiftUI
import CodeScanner

struct ScanItemView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var scannedCode: String?
    
    var body: some View {
        CodeScannerView(codeTypes: [.ean8, .ean13, .upce], completion: handleScan)
            .edgesIgnoringSafeArea(.all)
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        dismiss()
        
        switch result {
        case .success(let scan):
            scannedCode = scan.string
            print("Scanned barcode: \(scan.string)")
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
}

