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
    
    
    @State var name: String = ""
    @State var calorie: String = ""
    

    let data: [ (Label, [Entry]) ]
    @Binding var selection: [Entry]

    var body: some View {
        GeometryReader { geometry in
            HStack {
                ForEach(0..<self.data.count) { column in
                    Picker(self.data[column].0, selection: self.$selection[column]) {
                        ForEach(0..<self.data[column].1.count) { row in
                            Text(verbatim: self.data[column].1[row])
                            .tag(self.data[column].1[row])
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: geometry.size.width / CGFloat(self.data.count), height: geometry.size.height)
                    .clipped()
                }
            }
        }
        
        VStack {
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
        }
    }
    
}

struct AddRamyunView: View {
    @State var data: [(String, [String])] = [
        ("One", Array(0...59).map { "\($0) 분" }),
        ("Two", Array(0...59).map { "\($0) 초" })
    ]
    @State var selection: [String] = [0, 0].map { "\($0)" }
    
    var body: some View {
        VStack(alignment: .center) {
//            Text(verbatim: "Selection: \(selection)")
            MultiPicker(data: data, selection: $selection).frame(height: 300)
        }
    }
}

#Preview {
    AddRamyunView()
}
