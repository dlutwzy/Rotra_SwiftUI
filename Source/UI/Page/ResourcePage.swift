//
//  ResourcePage.swift
//  Rotra
//
//  Created by wzy on 2024/3/13.
//

import SwiftUI

struct ResourcePage: View {
    @ObservedObject var engine: DisplayEngine
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
            Spacer().frame(width: 2.0)
            LazyVGrid(columns: Array(Array(repeating: GridItem(), count: 3))) {
                ForEach(engine.resourceFactorys) { factory in
                    FactoryDispayCell(factory: factory)
                }
            }
            .frame(maxHeight: .infinity)
            Spacer().frame(width: 2.0)
            ZStack {
                LazyVGrid(columns: Array(Array(repeating: GridItem(), count: 2)), spacing: 6.0) {
                    ForEach(engine.resourceFactorys) { factory in
                        FactoryDurationDisplayCell(factory: factory)
                    }
                }
                .padding(.all, 4.0)
                .border(Color.gray, width: 1.0)
                .cornerRadius(4.0)
            }
        }
        .padding([.leading, .trailing], 6.0)
    }
}

struct FactoryDispayCell: View {
    @ObservedObject var factory: DisplayFactory
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                Text(factory.level)
                Spacer().frame(height: 2.0)
                Image(systemName: (factory.factory?.resourceImage ?? ""))
                    .resizable()
                    .frame(width: 40, height: 40)
                Spacer().frame(height: 4.0)
                Text(factory.factory?.name ?? "")
                    .font(.system(size: 12.0))
                Spacer()
            }
            Spacer()
        }
        .onTapGesture {
            factory.factory?.tryLevelUp(deltaLevel: 1)
        }
        .padding(.all, 4.0)
        .border(Color.gray, width: 1.0)
        .cornerRadius(4.0)
    }
}

struct FactoryDurationDisplayCell: View {
    @ObservedObject var factory: DisplayFactory
    var body: some View {
        HStack {
            Spacer().frame(width: 2.0)
            Text("\(factory.factory?.name ?? "") 生产间隔")
                .font(.system(size: 12.0))
                
            Spacer()
            Text("\(String(format: "%.1f", factory.factory?.duration ?? 0.0))s")
                .font(.system(size: 12.0))
        }
    }
}

struct ResourcePage_Preview: PreviewProvider {
    static var previews: some View {
        ResourcePage(engine: DisplayEngine.instance)
    }
}
