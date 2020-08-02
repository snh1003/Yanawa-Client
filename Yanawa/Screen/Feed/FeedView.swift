//
//  FeedView.swift
//  Yanawa
//
//  Created by 洪錫男 on 2020/07/25.
//  Copyright © 2020 kou. All rights reserved.
//

import SwiftUI

struct FeedView: View {
//    @ObservedObject var viewModel: FeedViewModel
    @State private var date = Date()
    @State var text = ""
    var body: some View {
        VStack {
            HStack{
            Text("미정타이틀폰트")
            .font(.system(.largeTitle, design: .rounded)).bold()
            }
            .padding(.top)
            ScrollView {
                HStack {
                    TextInputView(name: "title", secure: false)
                }
                HStack {
                    VStack (){
                        TextInputView(name: "location", secure: false)
                        TextInputView(name: "People", secure: false)
                        Spacer()
                    }
                    VStack {
                        TextInputView(name: "date", secure: false)
                        TextInputView(name: "time", secure: false)
                        Spacer()
                    }
                }
                .padding(.bottom)
                HStack{
                    MultilineTextView(text: $text)
                        .padding()
                        .frame(width: 320, height: 230, alignment: .center)
                        .border(Color.gray)
                }
                HStack{
                    Image(systemName: "camera")
                }
                .padding(.top)
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
