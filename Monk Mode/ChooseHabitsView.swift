//
//  ChooseHabitsView.swift
//  MonkMode
//
//  Created by Enver Enes Keskin on 19.02.2023.
//

import SwiftUI

struct ChooseHabitsView: View {
    
    @AppStorage("nosocial") var nosocial : Bool = false
    @AppStorage("noalcohol") var noalcohol : Bool = false
    @AppStorage("nosmoke") var nosmoke : Bool = false
    @AppStorage("nodrugs") var nodrugs : Bool = false
    @AppStorage("nofap") var nofap : Bool = false
    @AppStorage("exercise") var exercise : Bool = false
    @AppStorage("meditation") var meditation : Bool = false
    @AppStorage("read") var read : Bool = false
    @AppStorage("work") var work : Bool = false
    @AppStorage("diet") var diet : Bool = false
  
    @AppStorage("userPoints") var userPoints : Int = 0
    
    @State var notEnoughLevel : Bool = false
    
    func countTrueValues(in boolArray: [Bool]) -> Bool{
        var count = 0
        for value in boolArray {
            if value {
                count += 1
            }
        }
        var level = getLevel(points: userPoints)
        
        if (count - 2) > level {
            withAnimation{
                notEnoughLevel = true
            }
          
            return false
        }else{
            return true
        }
        
    }
    
    
    func getLevel(points: Int) -> Int {
        let levels = [12, 36, 72, 120, 180, 252, 336, 432, 540, 660]
        for i in 0..<levels.count {
            if points < levels[i] {
                
                return i + 1
            }
        }
        return levels.count
    }
   
    
    
    var body: some View {
      
        ZStack{
            
            Color(hex: 0x2e55dd, opacity: 1)
            
            
                
                VStack{
                    
                    Spacer().frame(height: 80)
                    
                    Text("Choose Your Habits To Become A Monk!").padding(.horizontal,60).font(.custom("Staatliches-Regular", size: 35)).gradientForeground(colors: [Color(white: 1.0, opacity: 1.0), Color(white: 1.0, opacity: 1)])
                    Spacer().frame(height: 40)
                    
                    VStack{
                        HStack{
                            
                            Button {
                                noalcohol.toggle()
                                if  !countTrueValues(in: [noalcohol, nosmoke, nodrugs, nofap, exercise, meditation, read, work, diet, nosocial]){
                                    noalcohol.toggle()
                                }
                            } label: {
                                Text("No Alcohol")
                                    .padding()
                                    .foregroundColor((noalcohol) ? .white : .black)
                                    .background((noalcohol) ? .blue : .white)
                                    
                                    .cornerRadius(5)
                                
                                    .shadow(color: .black, radius: 1, x: -4, y: 4)
                            }
                            .disabled(notEnoughLevel)
    Spacer()
                            Button {
                                nosmoke.toggle()
                                if  !countTrueValues(in: [noalcohol, nosmoke, nodrugs, nofap, exercise, meditation, read, work, diet, nosocial]){
                                    nosmoke.toggle()
                                }
                            } label: {
                                Text("No Smoking")
                                
                                   
                                    .padding()
                                    .foregroundColor((nosmoke) ? .white : .black)
                                    .background((nosmoke) ? .blue : .white)
                                    
                                    .cornerRadius(5)
                                
                                    .shadow(color: .black, radius: 1, x: -4, y: 4)
                            }
                            .disabled(notEnoughLevel)

                            Spacer()
                        }.padding(.horizontal).padding(.vertical,3)
                        
                        HStack{
                            Spacer()
                            Button {
                                nodrugs.toggle()
                                if  !countTrueValues(in: [noalcohol, nosmoke, nodrugs, nofap, exercise, meditation, read, work, diet, nosocial]){
                                    nodrugs.toggle()
                                }
                            } label: {
                                Text("No Drugs")
                                    .padding()
                                    .frame(width: 110)
                                    .foregroundColor((nodrugs) ? .white : .black)
                                    .background((nodrugs) ? .blue : .white)
                                    
                                    .cornerRadius(5)
                                
                                    .shadow(color: .black, radius: 1, x: -4, y: 4)
                                
                            }
                            .disabled(notEnoughLevel)
                            Spacer()
                            Button {
                                nofap.toggle()
                                if  !countTrueValues(in: [noalcohol, nosmoke, nodrugs, nofap, exercise, meditation, read, work, diet, nosocial]){
                                    nofap.toggle()
                                }
                            } label: {
                                Text("No Fap")
                                  .padding()
                                  .frame(width: 100)
                                  .foregroundColor((nofap) ? .white : .black)
                                  .background((nofap) ? .blue : .white)
                                    
                                    .cornerRadius(5)
                                
                                    .shadow(color: .black, radius: 1, x: -4, y: 4)
                            }
                            .disabled(notEnoughLevel)
                           
                        }.padding(.horizontal).padding(.vertical,3)
                        
                        HStack{
                            Button {
                                exercise.toggle()
                                if  !countTrueValues(in: [noalcohol, nosmoke, nodrugs, nofap, exercise, meditation, read, work, diet, nosocial]){
                                    exercise.toggle()
                                }
                            } label: {
                                Text("Exercise")
                                    .padding()
                                    .foregroundColor((exercise) ? .white : .black)
                                    .background((exercise) ? .blue : .white)
                                    
                                    .cornerRadius(5)
                                
                                    .shadow(color: .black, radius: 1, x: -4, y: 4)
                            }
                            .disabled(notEnoughLevel)
    Spacer()
                            Button {
                                meditation.toggle()
                                if  !countTrueValues(in: [noalcohol, nosmoke, nodrugs, nofap, exercise, meditation, read, work, diet, nosocial]){
                                    meditation.toggle()
                                }
                            } label: {
                                Text("Meditation")
                                    .frame(width: 100)
                                 .padding()
                                 .foregroundColor((meditation) ? .white : .black)
                                 .background((meditation) ? .blue : .white)
                                    
                                    .cornerRadius(5)
                                
                                    .shadow(color: .black, radius: 1, x: -4, y: 4)
                            }
                            .disabled(notEnoughLevel)
                            Spacer()
                        }.padding(.horizontal).padding(.vertical,3)
                        
                        HStack{
                            Spacer()
                            Button {
                                read.toggle()
                                if  !countTrueValues(in: [noalcohol, nosmoke, nodrugs, nofap, exercise, meditation, read, work, diet, nosocial]){
                                    read.toggle()
                                }
                            } label: {
                                Text("Read")
                                    .padding()
                                    .frame(width: 100)
                                    .foregroundColor((read) ? .white : .black)
                                    .background((read) ? .blue : .white)
                                    
                                    .cornerRadius(5)
                                
                                    .shadow(color: .black, radius: 1, x: -4, y: 4)
                            } .disabled(notEnoughLevel)
                            Spacer()
                            Button {
                                work.toggle()
                                if  !countTrueValues(in: [noalcohol, nosmoke, nodrugs, nofap, exercise, meditation, read, work, diet, nosocial]){
                                    work.toggle()
                                }
                            } label: {
                                Text("Work")
                                .padding()
                                .frame(width: 100)
                                .foregroundColor((work) ? .white : .black)
                                .background((work) ? .blue : .white)
                                    
                                    .cornerRadius(5)
                                
                                    .shadow(color: .black, radius: 1, x: -4, y: 4)
                            } .disabled(notEnoughLevel)

                           
                        }.padding(.horizontal).padding(.vertical,3)
                        HStack{
                            Button {
                                diet.toggle()
                                if  !countTrueValues(in: [noalcohol, nosmoke, nodrugs, nofap, exercise, meditation, read, work, diet, nosocial]){
                                    diet.toggle()
                                }
                            } label: {
                                Text("Healthy Diet")
                                    .padding()
                                    .foregroundColor((diet) ? .white : .black)
                                    .background((diet) ? .blue : .white)
                                    
                                    .cornerRadius(5)
                                
                                    .shadow(color: .black, radius: 1, x: -4, y: 4)
                            } .disabled(notEnoughLevel)
    Spacer()
                            Button {
                                nosocial.toggle()
                                if  !countTrueValues(in: [noalcohol, nosmoke, nodrugs, nofap, exercise, meditation, read, work, diet, nosocial]){
                                    nosocial.toggle()
                                }
                            } label: {
                                Text("No Social Media")
                                    .padding()
                                    .foregroundColor((nosocial) ? .white : .black)
                                    .background((nosocial) ? .blue : .white)
                                    
                                    .cornerRadius(5)
                                
                                    .shadow(color: .black, radius: 1, x: -4, y: 4)
                            } .disabled(notEnoughLevel)

                            Spacer()
                        }.padding(.horizontal).padding(.vertical,3)
                        
                    }
                    
                    
                    Spacer()
                    NavigationLink {
                        if UserDefaults.standard.addingHabit{
                            MainContentView()
                        }else{
                            ChooseTimeView()
                            
                        }
                    } label: {
                        Text("Proceed")
                        
                            .frame(width: 200)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color(.systemRed).opacity(0.9))
                            .cornerRadius(5)
                            .shadow(color: .black, radius: 1, x: -4, y: 4)
                        
                        
                    }
                    .disabled(notEnoughLevel)
                    .simultaneousGesture(TapGesture().onEnded{
                        
                        
                    })
                    Spacer()
                    
                    
                    
                }.blur(radius: notEnoughLevel ? 10 : 0)
                
            
            
            if notEnoughLevel {
                CountAlert(presentAlert: $notEnoughLevel)
            }
            
        }.font(.custom("Staatliches-Regular", size: 20))
        .background()
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
            
          
            
        
        
        
    }
}

struct ChooseHabitsView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseHabitsView()
    }
}

struct CountAlert: View {
    
    /// Flag used to dismiss the alert on the presenting view
    @Binding var presentAlert: Bool
    
    /// The alert type being shown
    @State var alertType: String = "Are You Sure ?"
    
    /// based on this value alert buttons will show vertically
    var isShowVerticalButtons = false
    
   
    
    let verticalButtonsHeight: CGFloat = 80
    
    
    
    var body: some View {
        
        ZStack {
            
            // faded background
            Color.black.opacity(0.75)
                .edgesIgnoringSafeArea(.all)
          
            VStack{
                Spacer().frame(height: 100)
                Text("Your level is not enough to take more habits!")
                    .foregroundColor(.white)
                    .font(.custom("Staatliches-Regular", size: 40))
                    .padding()
                
                Spacer().frame(height: 100)
                Image("monkart3")
                    .resizable()
                    .scaledToFit()
                    .simultaneousGesture(TapGesture().onEnded{
                        withAnimation{
                            presentAlert = false
                        }
                        
                    })
                    
                
            }
              
                    
            
        }.font(.custom("Staatliches-Regular", size: 20))
        .zIndex(2)
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                withAnimation{
                    presentAlert = false
                }
               
            }
        }
    }
}
