
import SwiftUI

struct ImagePicker {
    @Binding var isShown: Bool
    @Binding var image: Image?
    var sourceType: UIImagePickerController.SourceType
}

final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    let parent: ImagePicker

    init(parent: ImagePicker) {
        self.parent = parent
    }
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let original = info[.originalImage] as? UIImage else { return }
        parent.image = Image(uiImage: original)
        parent.isShown = false
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        parent.isShown = false
    }
}

extension ImagePicker: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIImagePickerController

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        //do noting
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
}



