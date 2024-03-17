//
//  RATabView.swift
//  Rotra
//
//  Created by wzy on 2023/7/22.
//

import SwiftUI

struct MonsterDisplayView: View {
    @ObservedObject var monster: DisplayMonster
    @ObservedObject var goldFactory: DisplayFactory
    var body: some View {
        ZStack {
            VStack {
                Image("top_bg")
                    .resizable()
            }
            .overlay(alignment: .center, content: {
                Image(systemName: monster.monster?.imageName ?? "")
                    .resizable()
                    .aspectRatio(1.0, contentMode: .fit)
                    .frame(width: 120.0, height: 120.0)
            })
            .overlay(alignment: .topLeading, content: {
                HStack {
                    Image(systemName: "bitcoinsign.circle.fill")
                    Spacer().frame(width: 2.0)
                    Text(goldFactory.resource)
                }
                .padding(.leading, 16.0)
                .padding(.top, 4.0)
            })
            .overlay(alignment: .bottom, content: {
                HStack {
                    Image(systemName: "heart")
                    Spacer().frame(width: 2.0)
                    Text(monster.hp)
                }
                .padding(.bottom, 16.0)
            })
            .overlay {
                FallsDisplayView(fallsSender: monster)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .aspectRatio(16.0 / 9.0, contentMode: .fit)
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
    }
}

struct MainTabView: View {
    
    @ObservedObject var engine: DisplayEngine
    
    var body: some View {
        VStack {
            MonsterDisplayView(monster: engine.monster, goldFactory: engine.goldFactory)
            TabView {
                BattleFieldPage(engine: engine).tabItem {
                    Label("战场", systemImage: "figure.archery")
                }.animation(.easeInOut, value: true)
                ResourcePage(engine: engine).tabItem {
                    Label("资源", systemImage: "figure.mind.and.body")
                }.animation(.easeInOut, value: true)
                EmployPage(engine: engine).tabItem {
                    Label("市场", systemImage: "figure.seated.seatbelt")
                }.animation(.easeInOut, value: true)
                BattleFieldPage(engine: engine).tabItem {
                    Label("神殿", systemImage: "eye.circle.fill")
                }.animation(.easeInOut, value: true)
                BattleFieldPage(engine: engine).tabItem {
                    Label("其他", systemImage: "hand.raised.fingers.spread.fill")
                }.animation(.easeInOut, value: true)
            }
        }
    }
}

struct RATabView_Preview: PreviewProvider {
    static var previews: some View {
        MainTabView(engine: DisplayEngine.instance)
    }
}
