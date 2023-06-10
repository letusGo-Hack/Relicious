//
//  AddRamyunView.swift
//  Relicious
//
//  Created by Whales on 2023/06/10.
//

import SwiftUI

struct MultiPicker: View  {

    typealias Label = String
    typealias Entry = String
    
    let data: [ (Label, [Entry]) ]
    @Binding var selection: [Entry]

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(0..<self.data.count) { column in
                    Picker(self.data[column].0, selection: self.$selection[column]) {
                        ForEach(0..<self.data[column].1.count) { row in
                            Text(verbatim: self.data[column].1[row])
                            .tag(self.data[column].1[row])
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: geometry.size.width / CGFloat(self.data.count))
                    .clipped()
                }
            }
        }
        .padding([.leading, .trailing], 30)
        .border(.orange)
        
    }
    
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var mode
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

extension ImagePicker {
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let image = info[.originalImage] as? UIImage else { return }
            parent.image = image
            parent.mode.wrappedValue.dismiss()
        }
    }
}

struct AddRamyunView: View {
    @State var name: String = ""
    @State var calorie: String = ""
    
    @State var data: [(String, [String])] = [
        ("One", Array(0...59).map { "\($0) 분" }),
        ("Two", Array(0...59).map { "\($0) 초" })
    ]
    @State var selection: [String] = [0, 0].map { "\($0)" }
    
    @Environment(\.dismiss) var dismiss
    
    @State var showImagePicker = false
    @State var selectedUIImage: UIImage?
    @State var image: Image?
    
    func loadImage() {
        guard let selectedImage = selectedUIImage else { return }
        image = Image(uiImage: selectedImage)
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack {
                Button("취소\n버튼") {
                    dismiss()
                }
                
                Spacer()
                
                Button("저장\n버튼") {
                    
                    
                    dismiss()
                }
            }
            .border(.red)
            
            Spacer()
            
            MultiPicker(data: data, selection: $selection)
                .frame(height: 200)
            
            Spacer()
            VStack(spacing: 20) {
                
                
            }
            HStack {
                
                if let image = image {
                    image
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 120, height: 120)
                } else {
                    Image(systemName: "plus.viewfinder")
                        .resizable()
                        .foregroundColor(.blue)
                        .frame(width: 120, height: 120)
                }
                
                
                Button {
                    showImagePicker.toggle()
                } label: {
                    Text("라면이미지 \n 추가버튼")
                }
                .sheet(isPresented: $showImagePicker, onDismiss: {
                    loadImage()
                }) {
                    ImagePicker(image: $selectedUIImage)
                }.padding([.leading, .trailing], 40)
            }
            .border(.purple)
            
            Spacer()
            HStack(alignment: .center) {
                Text("라면명 :")
                    .font(.callout)
                    .bold()
                    .frame(width: 70)
                TextField("라면 이름을 입력해주세요.", text: $name)
                    .padding()
                    .background(Color(uiColor: .secondarySystemBackground))
            }
            
            HStack(alignment: .center) {
                Text("칼로리 :")
                    .font(.callout)
                    .bold()
                    .frame(width: 70)
                TextField("칼로리를 입력해주세요.", text: $calorie)
                    .padding()
                    .background(Color(uiColor: .secondarySystemBackground))
            }
            Spacer()
        }
        .padding([.leading, .trailing], 30)
    }
}

#Preview {
    AddRamyunView()
}
