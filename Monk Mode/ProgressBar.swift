//
//  ProgressBar.swift
//  Monk Mode
//
//  Created by Enver Enes Keskin on 2023-03-09.
//

import SwiftUI

struct ProgressBar: View {
    @Binding var progressValue: Double
    var body: some View {
      
            Progress(value: $progressValue)
                
            }
           
}



struct Progress: View {
    @Binding var value: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))
                
                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color(UIColor.systemBlue))
                    .animation(.linear)
            }.cornerRadius(45.0)
        }
    }
}

