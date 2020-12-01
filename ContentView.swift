//
//  ContentView.swift
//  CAT 20 Timer
//
//  Created by Sagnik Sarkar on 10/07/20.
//  Copyright © 2020 Altair. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct Home : View {
    @State var start = false
    @State var to :CGFloat = 0
    @State var count = 0
    @State var time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View{
        VStack{
            ZStack{
                Color.black.opacity(0.06).edgesIgnoringSafeArea(.all)
                ZStack{
                    Circle()
                    .trim(from: 0, to: 1)
                        .stroke(Color.black.opacity(0.09), style: StrokeStyle(lineWidth: 35, lineCap: .round))
                        .frame(width: 280, height: 280)
                    
                    Circle()
                        .trim(from: 0, to: self.to)
                        .stroke(Color.red, style: StrokeStyle(lineWidth: 35, lineCap: .round))
                        .frame(width: 280, height: 280)
                        .rotationEffect(.init(degrees: -90))
                    
                    VStack{
                        Text("\(self.count)")
                            .font(.system(size: 65))
                            .fontWeight(.bold)
                        Text("Of 5 min")
                            .font(.title)
                            .padding(.top)
                    }
                    
                }
                
            }
            HStack(spacing: 20){
                Button(action: {
                    if self.count == 300 {
                        self.count = 0
                        withAnimation(.default) {
                            self.to = 0
                        }
                    }
                    self.start.toggle()
                    
                }) {
                    HStack(spacing: 15){
                        Image(systemName: self.start ? "pause.fill" : "play.fill")
                            .foregroundColor(.white)
                        Text(self.start ? "Pause": "Start")
                            .foregroundColor(.white)
                    }
                    .padding(.vertical)
                    .frame(width: (UIScreen.main.bounds.width / 2) - 55)
                    .background(Color.red)
                    .clipShape(Capsule())
                    .shadow(radius: 6)
                }
                Button(action: {
                    self.count = 0
                    withAnimation(.default){
                        self.to = 0
                    }
                    }) {
                        HStack(spacing: 15){
                            Image(systemName: "arrow.clockwise")
                                .foregroundColor(.red)
                            Text("Reset")
                                .foregroundColor(.red)
                        }
                        .padding(.vertical)
                        .frame(width: (UIScreen.main.bounds.width / 2) - 55)
                        .background(
                            Capsule()
                                .stroke(Color.red, lineWidth: 2)
                        )
                        .shadow(radius: 6)
                    }
            }
            .padding(.top, 35)
            .padding(.bottom,35)
        }
        .onReceive(self.time){
            (_) in
            if self.start {
                if self.count != 300{
                    self.count += 1
                    withAnimation(.default){
                        self.to = CGFloat(self.count) / 300
                    }
                }
                else {
                    withAnimation(.default){
                        self.to = 0
                    }
                    
                    self.start.toggle()
                }
                
            }
            
        }
    }
}
