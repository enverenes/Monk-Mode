//
//  SplashScreenView.swift
//  WeightLoss
//
//  Created by Enver Enes Keskin on 29.01.2023.
//

import SwiftUI

struct SplashScreenView: View {
   
    
    @State private var isActive = false
    @State private var logoSize = 0.8
    @State private var logoOp = 0.5
    var body: some View {
        
        NavigationView(){
            if(isActive){
                if(UserDefaults.standard.welcomescreenShown){
                        MainContentView()
                    
                   }else{
                       OnboardingView()
                   }
            }
            else{
                VStack{
                    VStack{
                        Image("logo")
                        Text("Monk Mode").font(.custom("MetalMania-Regular", size: 40))
                    }.scaleEffect(logoSize)
                    .opacity(logoOp).onAppear(){
                       withAnimation(.easeIn(duration: 1.2)){
                            self.logoOp = 1.0
                            self.logoSize = 1.0
                        }
                    }
                }.frame(maxWidth: .infinity, maxHeight: .infinity).background(.white).onAppear(){
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.8){
                        withAnimation(.easeInOut){
                            isActive = true
                        }
                        
                    }
            }
           
            }
               
        }
      
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}

