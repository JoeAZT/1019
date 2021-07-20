//
//  TextWrapper.swift
//  selfCare
//
//  Created by Joseph Taylor on 03/05/2021.
//

import Foundation
import SwiftUI

struct TextViewWrapper: UIViewRepresentable {
    @Binding var text: String
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        
        textView.delegate = context.coordinator
        
        //Customise apperance of the textview here not in swift ui
        
        textView.font = UIFont.systemFont(ofSize: 20)
        
        return textView
    }
    func updateUIView(_ uiView: UITextView, context: Context) {
        if text != uiView.text {
            uiView.text = text
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        @Binding var text: String
        
        init(text: Binding<String>) {
            self._text = text
        }
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if(text == "\n") {
                textView.resignFirstResponder()
                return false
            }
            return true
        }
        func textViewDidChange(_ textView: UITextView) {
            text = textView.text
        }
    }
}
