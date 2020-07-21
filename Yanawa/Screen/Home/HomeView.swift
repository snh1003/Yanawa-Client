
import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State private var text = ""
    var body: some View {
        NavigationView {
            if self.viewModel.isLoading {
                Text("Loading...")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .offset(x: 0, y: -200)
                    .navigationBarTitle("", displayMode: .inline)
            } else {
                ScrollView(showsIndicators: false) {
                    ForEach(viewModel.cardViewInputs) { input in
                        Button(action: {
                            self.viewModel.apply(inputs: .tapCardView(urlString: input.url))
                        }) {
                            CardView(input: input)
                        }
                    }
                }
                .padding()
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarItems(leading: HStack {
                    TextField("search", text: $text, onCommit: {
                        self.viewModel.apply(inputs: .submit(text: self.text))
                    })
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.asciiCapable)
                        .frame(width: UIScreen.main.bounds.width - 40)
                })
                    .sheet(isPresented: $viewModel.isSheet) {
                        SafariView(url: URL(string: self.viewModel.repositoryUrl)!)
                }
                .alert(isPresented: $viewModel.isError) {
                    Alert(title: Text("error"))
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: .init(apiService: APIService()))
    }
}
