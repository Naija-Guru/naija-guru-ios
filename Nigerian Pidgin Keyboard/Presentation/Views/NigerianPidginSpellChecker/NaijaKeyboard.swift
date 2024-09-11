//
//  NaijaKeyboard.swift
//  Nigerian Pidgin Keyboard
//
//  Created by Emmanuel Idaresit on 13/08/2024.
//

import SwiftUI

struct NaijaKeyboard: View {
    
    @EnvironmentObject private var navigationVM : NavigationViewModel
    @EnvironmentObject private var spellCheckerVM : SpellCheckerViewModel
    
    
    var body: some View {
        VStack{
            
            Spacer()
            if(spellCheckerVM.showLoading){
                Text("Loading ...")
                    .font(.custom("Poppins-Regular", size: 16))
                    .foregroundColor(Color(hex:"8E8E93"))
            }else{
                if(!spellCheckerVM.hasInternet){
                    SpellCheckStateDescriptionView(text: "No internet connection", image: "no_internet")
                }else {
                    
                    if(spellCheckerVM.correctionMatches.isEmpty){
                        
                        SpellCheckStateDescriptionView(text: spellCheckerVM.textInput.isEmpty ? "Start writting..." : "Kudos! You’re on point", image: spellCheckerVM.textInput.isEmpty ? "start_writing" : "good_job")
                    }
                    
                    if(!spellCheckerVM.correctionMatches.isEmpty){
                        
                        GeometryReader { rect in
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(spellCheckerVM.correctionMatches, id: \.self) { match in
                                        
                                        SpellCheckMatchView(match: match, onAccept: {
                                            spellCheckerVM.replaceWithMatch(match: match)
                                        }, onIgnoreRule: {
                                            spellCheckerVM.ignoreRule(match: match)
                                        }, onIgnoreCategory: {
                                            spellCheckerVM.ignoreCategory(match: match)
                                        })
                                        .frame(width: rect.size.width - 40)
                                    }
                                }
                                .scrollTargetLayout()
                                .padding(.trailing, 20)
                            }
                            .scrollIndicators(.hidden)
                            .scrollTargetBehavior(.viewAligned)
                        }
                    }
                }
            }
            
            Spacer()
            
            
            HStack(spacing: 0){
                
                NaijaKeyboardIconButton(namedAsset: "keyboard")
                    .padding(.leading, 12)
                    .onTapGesture {
                        navigationVM.toggleNaijaKeyboard()
                        spellCheckerVM.naijakeyboardISShowing = false
                    }
                
                
                Spacer()
                
                Text("\(spellCheckerVM.correctionMatches.count) writing \(spellCheckerVM.correctionMatches.count == 1 ? "issue" : "issues") found")
                    .font(.custom("Poppins-Regular", size: 14))
                    .foregroundColor(Color(hex:"8E8E93"))
                Spacer()
                
                NaijaKeyboardIconButton(namedAsset: nil)
                    .padding(.trailing, 12)
                    .onTapGesture {
                        navigationVM.openSettings()
                    }
                
            }
            .padding(.bottom, 10)
        }
        .background(Color(hex: "F0FAF4"))
    }//view
}

#Preview {
    NaijaKeyboard()
}
