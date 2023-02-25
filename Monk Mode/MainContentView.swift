//
//  MainContentView.swift
//  MonkMode
//
//  Created by Enver Enes Keskin on 19.02.2023.
//

import SwiftUI

struct MainContentView: View {
    
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
    
    @State var selectedTab : Int = 1
    @State var habits : [String] = []

    func addToHabitArray(habitArray : [Bool]){
        
        if(exercise){
            habits.append("Exercise")
        }
        
        if(meditation){
            habits.append("Meditation")
        }
        if(work){
            habits.append("Work")
        }
        
        if(read){
            habits.append("Reading")
        }
        if(diet){
            habits.append("Healthy Diet")
        }
        if(nosocial){
            habits.append("No Social Media")
        }
        if(nosmoke){
            habits.append("No Smoking")
        }
        if(nodrugs){
            habits.append("No Drugs")
        }
        if(noalcohol){
            habits.append("No Alcohol")
        }
        if(nofap){
            habits.append("No Fap")
        }
        
    }
    
    var body: some View {
        ZStack{
            
            if selectedTab == 1 {
                ScrollView{
                    
                        
                    VStack{
                        HStack{
                            Text("Routine")
                        }.frame(maxWidth: .infinity)
                            .background(.yellow).padding(.vertical)
                            .font(.custom("MetalMania-Regular", size: 40))
                        ForEach(habits, id: \.self) { habit in

                        
                        HStack{
                            VStack{
                                HStack{
                                    
                                    Text(habit).padding(.leading,30).font(.custom("MetalMania-Regular", size: 40))
                                    Spacer()
                                    Image(systemName: "book").padding(.trailing,30).padding(.top,10)
                                    
                                }
                                
                                HStack{
                                    Text("Streak").padding(7).background(.blue)
                                        .cornerRadius(25)
                                    Spacer()
                                    Text("3X Streak").padding(7)
                                }.background(.white)
                                    .cornerRadius(25)
                                
                            }.background(.gray)
                                .cornerRadius(25)
                                .padding()
                            
                            
                            Button {
                                
                            } label: {
                                
                            Image(systemName: "circle")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .padding(.trailing,40)
                                    .foregroundColor(.black)
                            }

                            
                        }
                        
                        
                        
                        
                        
                        
                        
                        
                    }
                }
                    Spacer()
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                    .font(.custom("MetalMania-Regular", size: 25))
                    .background(.blue)
            }
            else if selectedTab == 0
            {
                HistoryView()
            }
            else if selectedTab == 2
            {
                SettingsView()
            }
            
            TabBar(selectedTab:  $selectedTab)
           
        }.onAppear{
            addToHabitArray(habitArray: [noalcohol, nosmoke, nodrugs, nofap, exercise, meditation, read, work, diet, nosocial])
        }
            .navigationBarBackButtonHidden(true)
    }
}

struct TabBar: View{
    @Binding var selectedTab : Int
    var body: some View{
        
            VStack{
                Spacer()
                HStack(spacing: 80){
                    Button {
                        selectedTab = 0
                    } label: {
                        Image(systemName: "clock.arrow.circlepath").resizable().frame(width: 40,height: 40)
                    }
                    
                        Button {
                            selectedTab = 1
                        } label: {
                            Image(systemName: "house").resizable().frame(width: 40,height: 40)
                        }
                    
                    Button {
                        selectedTab = 2
                    } label: {
                        Image(systemName: "gearshape").resizable().frame(width: 40,height: 40)
                    }
                    
                }
                .padding(.vertical, 10)
                .padding(.horizontal,15)
                .background()
                .cornerRadius(20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity).foregroundColor(.black).padding(.horizontal, 8).padding(.vertical,0)
            
                
        
       
        
        
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
