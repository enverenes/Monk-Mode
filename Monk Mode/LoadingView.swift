//
//  LoadingView.swift
//  Monk Mode
//
//  Created by Enver Enes Keskin on 2023-03-18.
//

import SwiftUI

struct LoadingView: View {
    
    @State var isLoading : Bool = false
    
    var body: some View {
        ZStack{
            Color(.black).ignoresSafeArea(.all)
            Circle()
                .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .square, dash: [6,30]))
                .frame(width: 150, height: 150, alignment: .center)
                .foregroundColor(.yellow)
                .onAppear{
                    withAnimation(Animation.linear(duration: 2.0).repeatForever(autoreverses: false)){
                        isLoading.toggle()
                    }
                }
                .rotationEffect(Angle(degrees: isLoading ? 0 : 360))
            
            Text("Loading...").foregroundColor(.white)
                .font(.custom("MetalMania-Regular", size: 25))

            
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
