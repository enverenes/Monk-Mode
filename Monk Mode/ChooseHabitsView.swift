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
  
    
    
    func countTrueValues(in boolArray: [Bool]) -> Int {
        var count = 0
        for value in boolArray {
            if value {
                count += 1
            }
        }
        return count
    }
    var body: some View {
      
        ZStack{
            
            Color(hex: 0x2e55dd, opacity: 1)
            
            
            
            VStack{
                
                Spacer().frame(height: 100)
                
                Text("Choose Four Habits To Become A monk!").padding(.horizontal,60).font(.custom("Staatliches-Regular", size: 35)).gradientForeground(colors: [Color(white: 1.0, opacity: 1.0), Color(white: 1.0, opacity: 1)])
                Spacer().frame(height: 40)
                
                VStack{
                    HStack{
                        
                        Button {
                            noalcohol.toggle()
                        } label: {
                            Text("No Alcohol")
                                .padding()
                                .foregroundColor((noalcohol) ? .white : .black)
                                .background((noalcohol) ? .blue : .white)
                                
                                .cornerRadius(5)
                            
                                .shadow(color: .black, radius: 1, x: -4, y: 4)
                        }
Spacer()
                        Button {
                            nosmoke.toggle()
                        } label: {
                            Text("No Smoking")
                            
                               
                                .padding()
                                .foregroundColor((nosmoke) ? .white : .black)
                                .background((nosmoke) ? .blue : .white)
                                
                                .cornerRadius(5)
                            
                                .shadow(color: .black, radius: 1, x: -4, y: 4)
                        }

                        Spacer()
                    }.padding(.horizontal).padding(.vertical,3)
                    
                    HStack{
                        Spacer()
                        Button {
                            
                            nodrugs.toggle()
                        } label: {
                            Text("No Drugs")
                                .padding()
                                .frame(width: 110)
                                .foregroundColor((nodrugs) ? .white : .black)
                                .background((nodrugs) ? .blue : .white)
                                
                                .cornerRadius(5)
                            
                                .shadow(color: .black, radius: 1, x: -4, y: 4)
                            
                        }
                        Spacer()
                        Button {
                            nofap.toggle()
                        } label: {
                            Text("No Fap")
                              .padding()
                              .frame(width: 100)
                              .foregroundColor((nofap) ? .white : .black)
                              .background((nofap) ? .blue : .white)
                                
                                .cornerRadius(5)
                            
                                .shadow(color: .black, radius: 1, x: -4, y: 4)
                        }

                       
                    }.padding(.horizontal).padding(.vertical,3)
                    
                    HStack{
                        Button {
                            exercise.toggle()
                        } label: {
                            Text("Exercise")
                                .padding()
                                .foregroundColor((exercise) ? .white : .black)
                                .background((exercise) ? .blue : .white)
                                
                                .cornerRadius(5)
                            
                                .shadow(color: .black, radius: 1, x: -4, y: 4)
                        }
Spacer()
                        Button {
                            meditation.toggle()
                        } label: {
                            Text("Meditation")
                                .frame(width: 100)
                             .padding()
                             .foregroundColor((meditation) ? .white : .black)
                             .background((meditation) ? .blue : .white)
                                
                                .cornerRadius(5)
                            
                                .shadow(color: .black, radius: 1, x: -4, y: 4)
                        }

                        Spacer()
                    }.padding(.horizontal).padding(.vertical,3)
                    
                    HStack{
                        Spacer()
                        Button {
                            read.toggle()
                        } label: {
                            Text("Read")
                                .padding()
                                .frame(width: 100)
                                .foregroundColor((read) ? .white : .black)
                                .background((read) ? .blue : .white)
                                
                                .cornerRadius(5)
                            
                                .shadow(color: .black, radius: 1, x: -4, y: 4)
                        }
                        Spacer()
                        Button {
                            work.toggle()
                        } label: {
                            Text("Work")
                            .padding()
                            .frame(width: 100)
                            .foregroundColor((work) ? .white : .black)
                            .background((work) ? .blue : .white)
                                
                                .cornerRadius(5)
                            
                                .shadow(color: .black, radius: 1, x: -4, y: 4)
                        }

                       
                    }.padding(.horizontal).padding(.vertical,3)
                    HStack{
                        Button {
                            diet.toggle()
                        } label: {
                            Text("Healthy Diet")
                                .padding()
                                .foregroundColor((diet) ? .white : .black)
                                .background((diet) ? .blue : .white)
                                
                                .cornerRadius(5)
                            
                                .shadow(color: .black, radius: 1, x: -4, y: 4)
                        }
Spacer()
                        Button {
                            nosocial.toggle()
                        } label: {
                            Text("No Social Media")
                                .padding()
                                .foregroundColor((nosocial) ? .white : .black)
                                .background((nosocial) ? .blue : .white)
                                
                                .cornerRadius(5)
                            
                                .shadow(color: .black, radius: 1, x: -4, y: 4)
                        }

                        Spacer()
                    }.padding(.horizontal).padding(.vertical,3)
                    
                }
                
                
                Spacer()
                NavigationLink {
                    SpecifyhabitsView()
                } label: {
                    Text("Proceed")
                    
                        .frame(width: 200)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color(.systemRed).opacity(0.9))
                        .cornerRadius(5)
                        .shadow(color: .black, radius: 1, x: -4, y: 4)
                    
                    
                }
                .simultaneousGesture(TapGesture().onEnded{
                    let trueCount = countTrueValues(in: [noalcohol, nosmoke, nodrugs, nofap, exercise, meditation, read, work, diet, nosocial])
                    print(trueCount)
                })
                Spacer()
                
                
                
            }
            
        }.font(.custom("Staatliches-Regular", size: 20))
        .background().ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
        
        
        
    }
}

struct ChooseHabitsView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseHabitsView()
    }
}
