//
//  ContentView.swift
//  Relicious
//
//  Created by Milkyo on 6/10/23.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @State var ramyun: Ramyun
    @State var timer: Publishers.Autoconnect<Timer.TimerPublisher>?
    @State var isRunnging = false
    @State var counter = 0
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack(spacing: 8) {
                    Text("🍜")
                    Text(ramyun.name)
                        .font(.system(size: 28))
                        .foregroundStyle(Color(.label))
                    Text(getTimeText(ramyun.time))
                        .font(.system(size: 20))
                        .foregroundStyle(Color(.label))
                    Spacer()
                    Button {
                        let isRunnging = self.isRunnging
                        self.isRunnging.toggle()
                        
                        if !isRunnging {
                            self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                        } else {
                            self.timer = nil
                            self.counter = 0
                        }
                    } label: {
                        if self.isRunnging {
                            ZStack {
                                ProgressBar(counter: self.counter, countTo: ramyun.time)
                                Image(systemName: "stop.circle.fill")
                                    .resizable()
                                    .frame(width: 78, height: 78)
                            }
                            .optionalOnReceive(self.timer) { _ in
                                if self.counter < self.ramyun.time {
                                    self.counter += 1
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
    
    private func getTimeText(
        _ time: Int
    ) -> String {
        let minute = String(format: "%02d", Int(time / 60))
        let seconds = String(format: "%02d", time % 60)
        return "\(minute) : \(seconds)"
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

