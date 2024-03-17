//
//  EmployPage.swift
//  Rotra
//
//  Created by wzy on 2024/3/14.
//

import SwiftUI

struct EmployPage: View {
    @ObservedObject var engine: DisplayEngine
    @State var selectHero: DisplayHero? = nil
    @State var dialogPresented: Bool = false
    var body: some View {
        VStack {
            LazyVGrid(columns: Array(Array(repeating: GridItem(), count: 2))) {
                ForEach(engine.resourceFactorys) { factory in
                    ResourceDisplayCell(factory: factory)
                }
            }
            .padding(.all, 4.0)
            .border(Color.gray, width: 1.0)
            .cornerRadius(4.0)
            ZStack {
                VStack {
                    GeometryReader { geometryProxy in
                        ScrollView {
                            let itemWidth = geometryProxy.size.width / 4.0 - 4.0
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: itemWidth / 2.0, maximum: itemWidth)), count: 4)) {
                                ForEach(engine.employHeros) { hero in
                                    HeroEmployCell(displayHero: hero)
                                        .background(
                                            RoundedRectangle(cornerRadius: 4.0)
                                                .stroke(Color.gray, lineWidth: 1.0)
                                        )
                                        .padding(.all, 2.0)
                                        .onTapGesture {
                                            selectHero = hero
                                            dialogPresented = true
                                        }
                                }
                            }
                            .padding([.leading, .trailing], 2.0)
                        }
                        .frame(width: geometryProxy.size.width)
                    }
                    .frame(maxWidth: .infinity)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                if let hero = selectHero, dialogPresented {
                    Rectangle()
                        .fill(Color.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    HeroEmployDialog(displayHero: hero) {
                        selectHero = nil
                        dialogPresented = false
                    }
                    .padding(.bottom, 2.0)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding([.leading, .trailing], 6.0)
    }
}

struct HeroEmployCell: View {
    @ObservedObject var displayHero: DisplayHero
    var body: some View {
        let hero = displayHero.hero ?? Hero()
        VStack {
            Spacer().frame(height: 4.0)
            Image(systemName: hero.imageName)
                .resizable()
                .frame(width: 48.0, height: 48.0)
                .padding(.all, 10.0)
                .clipShape(Circle())
                .overlay {
                    RoundedRectangle(cornerRadius: 48.0)
                        .stroke(Color.gray, lineWidth: 1.0)
                }
                .aspectRatio(1.0, contentMode: .fit)
            Spacer().frame(height: 4.0)
            Text(hero.name)
                .font(.system(size: 10.0))
            Spacer().frame(height: 4.0)
        }
        .frame(maxWidth: .infinity)
        .padding([.top, .bottom], 4.0)
        .padding([.leading, .trailing], 10.0)
    }
}

struct EmployPage_Preview: PreviewProvider {
    static var previews: some View {
        EmployPage(engine: DisplayEngine.instance)
    }
}
