import SwiftUI
import FirebaseStorage

struct HomePageView: View {
    @Binding var loggedIn: Bool
    @State private var showingImagePicker = false
    @State private var selectedImage: UIImage?
    let songs = [
        "MIA by Bad Bunny, Drake",
        "Redrum by 21Savage",
        "Stick Season by Noah Kahan"
    ]

    var body: some View {
        VStack {
            Spacer(minLength: 50)

            Text("This Week's Scores")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)

            imageSection
            
            songList

            NavigationLink(destination: MusicalCalendarView(loggedIn: $loggedIn)) {
                Text("Musical Calendar")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width * 0.8)
                    .background(Color.black)
                    .cornerRadius(10)
            }
            .padding(.top, 20)

            Button("Share this week") {
                // Action for sharing
            }
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: UIScreen.main.bounds.width * 0.8)
            .background(Color.black)
            .cornerRadius(10)
            .padding(.top, 10)

            Spacer()

            cameraButton
            
        }
        .background(Color.gray.opacity(0.1))
        .edgesIgnoringSafeArea(.all)
    }
    
    var imageSection: some View {
        Group {
            if let selectedImage = selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: 300)
            } else {
                Image("image21") // Placeholder image from your assets
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: 300)
            }
        }
    }
    
    var songList: some View {
        ForEach(songs, id: \.self) { song in
            Text(song)
                .font(.headline)
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.black, lineWidth: 1)
                )
                .frame(width: UIScreen.main.bounds.width * 0.8)
        }
        .padding(.vertical, 5)
    }
    
    var cameraButton: some View {
        HStack {
            Spacer()
            Button(action: {
                self.showingImagePicker = true
            }) {
                Image(systemName: "camera.fill")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(20)
                    .background(Color.black)
                    .clipShape(Circle())
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(selectedImage: $selectedImage)
            }
            Spacer()
        }
        .padding(.bottom, 20)
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView(loggedIn: .constant(true))
    }
}

