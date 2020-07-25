//
//  TextInputView.swift
//  Yanawa
//
//  Created by 洪錫男 on 2020/07/25.
//  Copyright © 2020 kou. All rights reserved.
//

import SwiftUI

struct TextInputView: View {
    var name = ""
    var secure = false
    @State private var value = ""
//    @Binding var value: String = "park"
    var body: some View {
        VStack{
            TextField(name, text: $value)
                .padding(.horizontal)
            Divider()

                .background(Color.gray)
                .padding(.horizontal)
        }
        .padding(.vertical)
    }
   
}

struct TextInputView_Previews: PreviewProvider {
    static var previews: some View {
        TextInputView(name: "kim", secure: false)
    }
}
