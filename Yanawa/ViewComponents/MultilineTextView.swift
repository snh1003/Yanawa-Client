//
//  MultilineTextView.swift
//  Yanawa
//
//  Created by 洪錫男 on 2020/07/26.
//  Copyright © 2020 kou. All rights reserved.
//

import SwiftUI

struct MultilineTextView: UIViewRepresentable {
    @Binding var text: String
    final class Coordinator: NSObject, UITextViewDelegate {
        private var textView: MultilineTextView
        init(_ textView: MultilineTextView) {
            self.textView = textView
        }
        func textViewDidChange(_ textView: UITextView) {
            self.textView.text = textView.text
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.isScrollEnabled = true
        textView.isEditable = true
        textView.isUserInteractionEnabled = true
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
}

struct MultilineTextView_Previews: PreviewProvider {
    static var previews: some View {
        Wrapper()
    }
    struct Wrapper: View {
        @State var text: String = ""
        var body: some View {
            MultilineTextView(text: $text)
        }
    }
}
