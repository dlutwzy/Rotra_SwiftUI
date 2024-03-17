//
//  HeroLevelUpView.swift
//  Rotra
//
//  Created by wzy on 2024/3/13.
//

import Foundation

import SwiftUI

struct HeroLevelUpView: View {
    var displayHero: DisplayHero
    var tapGesture: () -> Void
    var body: some View {
        let hero = displayHero.hero ?? Hero()
        VStack {
            HeroDisplayCell(displayHero: displayHero) {
                tapGesture()
            }
            Spacer().frame(height: 2.0)
            
            ScrollView {
                VStack(spacing: 2.0) {
                    HStack {
                        Text("攻击力升级")
                            .font(Font.system(size: 12.0))
                        Spacer()
                        Text("当前等级: \(hero.attackLevel + 1)")
                            .font(Font.system(size: 12.0))
                    }
                    HStack {
                        Text("升级攻击力增加:")
                            .font(Font.system(size: 12.0))
                        Spacer()
                        Text("+\(Int64(Double(hero.basicAttack) * pow(1.15, Double(hero.level))))")
                            .font(Font.system(size: 12.0))
                    }
                    HStack {
                        Text("消耗:")
                            .font(Font.system(size: 12.0))
                        Spacer()
                        Text("888888")
                            .font(Font.system(size: 12.0))
                    }
                }
                .padding(EdgeInsets(top: 2.0, leading: 2.0, bottom: 2.0, trailing: 2.0))
                .border(Color.gray, width: 1.0)
                Spacer().frame(height: 2.0)
                
                VStack(spacing: 2.0) {
                    HStack {
                        Text("攻击间隔升级")
                            .font(Font.system(size: 12.0))
                        Spacer()
                        Text("当前等级: \(hero.speedLevel + 1)")
                            .font(Font.system(size: 12.0))
                    }
                    HStack {
                        Text("升级攻击间隔减少:")
                            .font(Font.system(size: 12.0))
                        Spacer()
                        Text("-\(String(format: "%.3f", Double(hero.basicSpeed) / 1000000.0 * 0.01))s")
                            .font(Font.system(size: 12.0))
                    }
                    HStack {
                        Text("消耗:")
                            .font(Font.system(size: 12.0))
                        Spacer()
                        Text("888888")
                            .font(Font.system(size: 12.0))
                    }
                }
                .padding(EdgeInsets(top: 2.0, leading: 2.0, bottom: 2.0, trailing: 2.0))
                .border(Color.gray, width: 1.0)
                Spacer().frame(height: 4.0)
                
                Text(hero.description)
                    .font(Font.system(size: 12.0))
                Spacer().frame(height: 10.0)
                
                ForEach(hero.skills) { skill in
                    VStack(spacing: 2.0) {
                        HStack {
                            Text(skill.name)
                                .font(Font.system(size: 12.0))
                            Spacer()
                            Text("\(skill.prepared ? "已解锁" : "解锁等级: \(skill.requiredLevel)")")
                                .font(Font.system(size: 12.0))
                                .italic()
                        }
                        HStack {
                            Text(skill.description)
                                .font(Font.system(size: 12.0))
                                .foregroundColor(.gray)
                                .italic()
                            Spacer()
                        }
                    }
                    Spacer().frame(height: 10.0)
                }
                .padding([.leading, .trailing], 2.0)
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
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct HeroLevelUpView_Preview: PreviewProvider {
    static var previews: some View {
        VStack {
            HeroLevelUpView(displayHero: DisplayHero(hero: YouAreHero())) {
                
            }
        }.frame(maxWidth: .infinity)
    }
}
