//
//  ResourceDisplayCell.swift
//  Rotra
//
//  Created by wzy on 2024/3/14.
//

import SwiftUI

struct ResourceDisplayCell: View {
    @ObservedObject var factory: DisplayFactory
    var body: some View {
        HStack {
            Spacer().frame(width: 2.0)
            Image(systemName: factory.factory?.resourceImage ?? "")
                .resizable()
                .frame(width: 16, height: 16)
            Text(factory.factory?.resourceName ?? "")
                .font(.system(size: 12.0))
            Text(factory.resource)
                .font(.system(size: 12.0))
            Spacer()
        }
    }
}
