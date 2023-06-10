//
//  ContentView.swift
//  Relicious
//
//  Created by Milkyo on 6/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var ramyun: [Ramyun] = []
    @State var isRunnging = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Array(ramyun.enumerated()), id: \.offset) { ramyun in
                    VStack(alignment: .leading) {
                        HStack(spacing: 8) {
                            Text("🍜")
                            Text(ramyun.element.name)
                                .font(.system(size: 28))
                                .foregroundStyle(Color(.label))
                            Text(getTimeText(ramyun.element.time))
                                .font(.system(size: 20))
                                .foregroundStyle(Color(.label))
                            Spacer()
                            Button {
                                if self.ramyun[safe: ramyun.offset] != nil {
                                    let isRunnging = self.ramyun[ramyun.offset].isRunnging
                                    self.ramyun[ramyun.offset].isRunnging = !isRunnging
                                    if !isRunnging {
                                        self.ramyun[ramyun.offset].timer = Timer
                                            .publish(every: 1, on: .main, in: .common).autoconnect()
                                    } else {
                                        self.ramyun[ramyun.offset].timer = nil
                                        self.ramyun[ramyun.offset].counter = 0
                                    }
                                }
                            } label: {
                                if ramyun.element.isRunnging {
                                    ZStack {
                                        ProgressBar(counter: ramyun.element.counter, countTo: Int(ramyun.element.time))
                                        Image(systemName: "stop.circle.fill")
                                            .resizable()
                                            .frame(width: 78, height: 78)
                                    }
                                    .optionalOnReceive(ramyun.element.timer) { _ in
                                        if (ramyun.element.counter < Int(ramyun.element.time)) {
                                            self.ramyun[ramyun.offset].counter += 1
                                        }
                                    }
                                } else {
                                    Image(systemName:  "play.circle.fill")
                                        .resizable()
                                        .frame(width: 78, height: 78)
                                }
                                
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding([.top, .bottom], 20)
                }
            }
            .listStyle(.plain)
            .navigationBarTitle("🍜Relicious")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Edit") {
                        print("Help tapped!")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {}, label: {
                        Image(systemName: "plus")
                    })
                }
            }
        }
        .onAppear {
            self.ramyun = [
                .init(name: "신라면", time: 60),
                .init(name: "진라면", time: 60)
            ]
        }
    }
    
    private func getTimeText(
        _ time: Double
    ) -> String {
        let minute = String(format: "%02d", Int(time / 60))
        let seconds  = String(format: "%02d", Int(time.truncatingRemainder(dividingBy: 60)))
        return "\(minute) : \(seconds)"
    }
}

#Preview {
    ContentView(ramyun: [
        .init(name: "신라면", time: 300)
    ])
}

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}

struct ProgressTrack: View {
    var body: some View {
        Circle()
            .fill(Color.clear)
            .frame(width: 78, height: 78)
            .overlay(
                Circle().stroke(Color.black, lineWidth: 15)
            )
    }
}

struct ProgressBar: View {
    var counter: Int
    var countTo: Int
    
    var body: some View {
        Circle()
            .trim(from: 0.0, to: progress())
            .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
            .foregroundColor(completed() ? Color.green : Color.red)
            .frame(width: 78, height: 78)
            .rotationEffect(.degrees(-90))
            .animation(.easeInOut(duration: 0.3), value: counter)
    }
    
    func completed() -> Bool {
        return progress() == 1
    }
    
    func progress() -> CGFloat {
        return (CGFloat(counter) / CGFloat(countTo))
    }
}

import Combine

extension View {
    @ViewBuilder
    func optionalOnReceive<P>(_ publisher: P?, perform action: @escaping (P.Output) -> Void) -> some View where P : Publisher, P.Failure == Never {
        if let publisher {
            self.onReceive(publisher, perform: action)
        } else {
            self
        }
    }
}

