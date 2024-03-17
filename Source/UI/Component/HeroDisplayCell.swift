//
//  HeroDisplayCell.swift
//  Rotra
//
//  Created by wzy on 2024/3/13.
//

import Foundation
import SwiftUI

struct HeroDisplayCell: View {
    let displayHero: DisplayHero
    let tapAction: (() -> Void)?
    var body: some View {
        let hero = displayHero.hero ?? Hero()
        HStack {
            ZStack {
                Image(systemName: hero.imageName)
                    .resizable()
                    .frame(width: 40.0, height: 40.0)
                    .padding(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4))
            }
            .background(
                RoundedRectangle(cornerRadius: 4.0)
                    .stroke(Color.gray, lineWidth: 1.0)
            )
            VStack(alignment: .leading, spacing: 2.0) {
                HStack {
                    Text(hero.name)
                        .font(Font.system(size: 12.0))
                    Spacer()
                    Text("等级: \(hero.level)")
                        .font(Font.system(size: 12.0))
                }
                
                HStack {
                    Text("攻击力")
                        .font(Font.system(size: 12.0))
                    Spacer()
                    Text("\(hero.attack)")
                        .font(Font.system(size: 12.0))
                }
                
                HStack {
                    Text("攻击间隔")
                        .font(Font.system(size: 12.0))
                    Spacer()
                    Text("\(String(format: "%.3f", (Double(hero.speed) / 1000000)))s")
                        .font(Font.system(size: 12.0))
                }
                
                HStack {
                    Text(hero.activeSkills.map({ skill in
                        "[\(skill.name)]"
                    }).joined(separator: " "))
                        .font(Font.system(size: 12.0))
                    Spacer()
                    Text(" ")
                        .font(Font.system(size: 12.0))
                }
            }
            .frame(maxWidth: .infinity)
            .padding([.top, .bottom], 2.0)
        }
        .frame(maxWidth: .infinity)
        .background(Color.white.onTapGesture {
            tapAction?()
        })
        .padding(EdgeInsets(top: 2.0, leading: 10.0, bottom: 2.0, trailing: 10.0))
        .border(Color.gray, width: 1.0)
        .cornerRadius(2.0)
    }
}

struct HeroDisplayCell_Preview: PreviewProvider {
    static var previews: some View {
        VStack {
            HeroDisplayCell(displayHero: DisplayHero(hero: YouAreHero())) {
                
            }
        }.frame(maxWidth: .infinity)
    }
}
