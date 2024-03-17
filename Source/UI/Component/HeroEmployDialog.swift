//
//  HeroEmployDialog.swift
//  Rotra
//
//  Created by wzy on 2024/3/14.
//

import SwiftUI

private struct HeroEmployInfoView: View {
    var displayHero: DisplayHero
    var body: some View {
        let hero = displayHero.hero ?? Hero()
        HStack {
            Image(systemName: hero.imageName)
                .resizable()
                .frame(width: 40.0, height: 40.0)
                .padding(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4))
                .border(.gray, width: 0.5)
            VStack(spacing: 2.0) {
                HStack {
                    Text("职业")
                        .font(Font.system(size: 12.0))
                    Spacer()
                    Text(hero.name)
                        .font(Font.system(size: 12.0))
                }
                
                HStack {
                    Text("基础攻击")
                        .font(Font.system(size: 12.0))
                    Spacer()
                    Text("\(hero.basicAttack)")
                        .font(Font.system(size: 12.0))
                }
                
                HStack {
                    Text("基础间隔")
                        .font(Font.system(size: 12.0))
                    Spacer()
                    Text("\(String(format: "%.3f", (Double(hero.basicSpeed) / 1000000)))s")
                        .font(Font.system(size: 12.0))
                }
                
                HStack {
                    Text(hero.skills.map({ skill in
                        "[\(skill.name)]"
                    }).joined(separator: " "))
                        .font(Font.system(size: 12.0))
                    Spacer()
                    Text(" ")
                        .font(Font.system(size: 12.0))
                }
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
    }
}

struct HeroEmployDialog: View {
    var displayHero: DisplayHero
    var tapGesture: () -> Void
    var body: some View {
        let hero = displayHero.hero ?? Hero()
        VStack {
            HeroEmployInfoView(displayHero: displayHero)
                .frame(maxWidth: .infinity)
            .padding(EdgeInsets(top: 2.0, leading: 10.0, bottom: 2.0, trailing: 10.0))
            .border(Color.gray, width: 1.0)
            .cornerRadius(2.0)
            .background(Color.white)
            .onTapGesture {
                tapGesture()
            }
            Spacer().frame(height: 2.0)
            ScrollView {
                Text(hero.description)
                    .font(Font.system(size: 12.0))
                Spacer().frame(height: 4.0)
                
                HStack {
                    VStack(spacing: 2.0) {
                        HStack {
                            Text("雇佣花费")
                                .font(Font.system(size: 12.0))
                            Spacer()
                        }
                        Spacer().frame(height: 2.0)
                        ForEach(hero.employExpend, id: \.self) { expend in
                            HStack {
                                Image(systemName: expend.origin.imageName)
                                    .resizable()
                                    .frame(width: 16.0, height: 16.0)
                                Text(expend.origin.name)
                                    .font(Font.system(size: 12.0))
                                Spacer().frame(width: 4.0)
                                Text("\(expend.value)")
                                    .font(Font.system(size: 12.0))
                                Spacer()
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 4.0, leading: 2.0, bottom: 4.0, trailing: 2.0))
                    
                    Spacer()
                    
                    Button(hero.employed ? "已雇佣" : "雇佣") {
                        guard !hero.employed else {
                            return
                        }
                        hero.tryEmploy()
                        tapGesture()
                    }
                    .font(.system(size: 12.0))
                    .disabled(hero.employed)
                    .foregroundColor(hero.employed ? Color.gray : Color.blue)
                    .frame(width: 40.0, height: 40.0)
                    .padding(EdgeInsets(top: 4.0, leading: 2.0, bottom: 4.0, trailing: 6.0))
                    .border(Color.gray, width: 1.0)
                    .cornerRadius(4.0)
                }
                .frame(maxWidth: .infinity)
                .padding(EdgeInsets(top: 4.0, leading: 2.0, bottom: 4.0, trailing: 2.0))
                .border(Color.gray, width: 1.0)
                
                Spacer().frame(height: 16.0)
                
                ForEach(hero.skills) { skill in
                    VStack(spacing: 2.0) {
                        HStack {
                            Text(skill.name)
                                .font(Font.system(size: 12.0))
                            Spacer()
                            Text("解锁等级: \(skill.requiredLevel)")
                                .font(Font.system(size: 12.0))
                        }
                        HStack {
                            Text(skill.description)
                                .font(Font.system(size: 12.0))
                            Spacer()
                        }
                    }
                    Spacer().frame(height: 6.0)
                }
                
                Spacer().frame(height: 16.0)
                
                Button("学习额外技能") {
                    
                }
                .font(Font.system(size: 12.0))
                .frame(maxWidth: .infinity)
                .padding(EdgeInsets(top: 3.0, leading: 0, bottom: 3.0, trailing: 0))
                .border(Color.gray, width: 1.0)
                .cornerRadius(2.0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(EdgeInsets(top: 2.0, leading: 2.0, bottom: 2.0, trailing: 2.0))
            .border(Color.gray, width: 1.0)
            .cornerRadius(2.0)
            Spacer()
        }
    }
}
