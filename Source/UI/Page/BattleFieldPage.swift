//
//  ContentView.swift
//  Rotra
//
//  Created by wzy on 2023/7/22.
//

import SwiftUI

struct BattleFieldPage: View {
    @ObservedObject var engine: DisplayEngine
    @State var modifyHero: DisplayHero?
    @State var dialogPresented: Bool = false
    var body: some View {
        ZStack {
            VStack {
                List {
                    ForEach(engine.heros) { hero in
                        HeroDisplayCell(displayHero: hero) {
                            modifyHero = hero
                            dialogPresented = true
                        }
                    }
                    .listRowInsets(EdgeInsets(top: 0.0, leading: 0.0, bottom: 4.0, trailing: 0.0))
                }
                .listStyle(.plain)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            if let hero = modifyHero, dialogPresented {
                Rectangle()
                    .fill(Color.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                HeroLevelUpView(displayHero: hero) {
                    modifyHero = nil
                    dialogPresented = false
                }
                .padding(.bottom, 2.0)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .padding(EdgeInsets(top: 0, leading: 6.0, bottom: 0, trailing: 6.0))
    }
}

struct BattleFieldPage_Previews: PreviewProvider {
    static var previews: some View {
        BattleFieldPage(engine: DisplayEngine.instance)
    }
}
