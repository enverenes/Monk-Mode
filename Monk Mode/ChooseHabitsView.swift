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
            
            LinearGradient(gradient: Gradient(colors: [.black, .black]), startPoint: .top, endPoint: .bottom)
            
            VStack{
                
                Spacer().frame(height: 50)
                
                Text("Choose at least four habits to become a monk!").padding().font(.custom("Futura", size: 35)).foregroundColor(.white)
                Spacer()
                
                VStack{
                    HStack{
                        
                        Button {
                            noalcohol.toggle()
                        } label: {
                            Text("No Alcohol")
                                .padding()
                                .foregroundColor((noalcohol) ? .white : Color(.systemBlue))
                                .background((noalcohol) ? .blue : .white)
                                .overlay( /// apply a rounded border
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.blue, lineWidth: 5))
                                .cornerRadius(5)
                            
                                .shadow(color: Color(.systemBlue), radius: 1, x: -4, y: 4)
                        }
Spacer()
                        Button {
                            nosmoke.toggle()
                        } label: {
                            Text("No Smoking")
                            
                               
                                .padding()
                                .foregroundColor((nosmoke) ? .white : Color(.systemBlue))
                                .background((nosmoke) ? .blue : .white)
                                .overlay( /// apply a rounded border
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.blue, lineWidth: 5))
                                .cornerRadius(5)
                            
                                .shadow(color: Color(.systemBlue), radius: 1, x: -4, y: 4)
                        }

                        Spacer()
                    }.padding()
                    
                    HStack{
                        Spacer()
                        Button {
                            
                            nodrugs.toggle()
                        } label: {
                            Text("No Drugs")
                                .padding()
                                .foregroundColor((nodrugs) ? .white : Color(.systemBlue))
                                .background((nodrugs) ? .blue : .white)
                                .overlay( /// apply a rounded border
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.blue, lineWidth: 5))
                                .cornerRadius(5)
                            
                                .shadow(color: Color(.systemBlue), radius: 1, x: -4, y: 4)
                        }
                        Spacer()
                        Button {
                            nofap.toggle()
                        } label: {
                            Text("No Fap")
                              .padding()
                              .foregroundColor((nofap) ? .white : Color(.systemBlue))
                              .background((nofap) ? .blue : .white)
                                .overlay( /// apply a rounded border
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.blue, lineWidth: 5))
                                .cornerRadius(5)
                            
                                .shadow(color: Color(.systemBlue), radius: 1, x: -4, y: 4)
                        }

                       
                    }.padding()
                    
                    HStack{
                        Button {
                            exercise.toggle()
                        } label: {
                            Text("Exercise")
                                .padding()
                                .foregroundColor((exercise) ? .white : Color(.systemBlue))
                                .background((exercise) ? .blue : .white)
                                .overlay( /// apply a rounded border
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.blue, lineWidth: 5))
                                .cornerRadius(5)
                            
                                .shadow(color: Color(.systemBlue), radius: 1, x: -4, y: 4)
                        }
Spacer()
                        Button {
                            meditation.toggle()
                        } label: {
                            Text("Meditation")
                             .padding()
                             .foregroundColor((meditation) ? .white : Color(.systemBlue))
                             .background((meditation) ? .blue : .white)
                                .overlay( /// apply a rounded border
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.blue, lineWidth: 5))
                                .cornerRadius(5)
                            
                                .shadow(color: Color(.systemBlue), radius: 1, x: -4, y: 4)
                        }

                        Spacer()
                    }.padding()
                    
                    HStack{
                        Spacer()
                        Button {
                            read.toggle()
                        } label: {
                            Text("Read")
                                .padding()
                                .foregroundColor((read) ? .white : Color(.systemBlue))
                                .background((read) ? .blue : .white)
                                .overlay( /// apply a rounded border
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.blue, lineWidth: 5))
                                .cornerRadius(5)
                            
                                .shadow(color: Color(.systemBlue), radius: 1, x: -4, y: 4)
                        }
                        Spacer()
                        Button {
                            work.toggle()
                        } label: {
                            Text("Work")
                            .padding()
                            .foregroundColor((work) ? .white : Color(.systemBlue))
                            .background((work) ? .blue : .white)
                                .overlay( /// apply a rounded border
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.blue, lineWidth: 5))
                                .cornerRadius(5)
                            
                                .shadow(color: Color(.systemBlue), radius: 1, x: -4, y: 4)
                        }

                       
                    }.padding()
                    HStack{
                        Button {
                            diet.toggle()
                        } label: {
                            Text("Healthy Diet")
                                .padding()
                                .foregroundColor((diet) ? .white : Color(.systemBlue))
                                .background((diet) ? .blue : .white)
                                .overlay( /// apply a rounded border
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.blue, lineWidth: 5))
                                .cornerRadius(5)
                            
                                .shadow(color: Color(.systemBlue), radius: 1, x: -4, y: 4)
                        }
Spacer()
                        Button {
                            nosocial.toggle()
                        } label: {
                            Text("No Social Media")
                                .padding()
                                .foregroundColor((nosocial) ? .white : Color(.systemBlue))
                                .background((nosocial) ? .blue : .white)
                                .overlay( /// apply a rounded border
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.blue, lineWidth: 5))
                                .cornerRadius(5)
                            
                                .shadow(color: Color(.systemBlue), radius: 1, x: -4, y: 4)
                        }

                        Spacer()
                    }.padding()
                    
                }
                
                
                Spacer()
                NavigationLink {
                    SpecifyhabitsView()
                } label: {
                    Text("Proceed")
                    
                        .frame(width: 200)
                        .padding()
                        .foregroundColor(Color(.systemGray))
                        .background(.white)
                        .overlay( /// apply a rounded border
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color(.systemYellow), lineWidth: 5))
                        .cornerRadius(5)
                    
                        .shadow(color: Color(.systemYellow), radius: 1, x: -4, y: 4)
                    
                    
                }
                .simultaneousGesture(TapGesture().onEnded{
                    let trueCount = countTrueValues(in: [noalcohol, nosmoke, nodrugs, nofap, exercise, meditation, read, work, diet, nosocial])
                    print(trueCount)
                })
                Spacer()
                
                
                
            }
            
        }.background().ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
        
        
        
    }
}

struct ChooseHabitsView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseHabitsView()
    }
}
