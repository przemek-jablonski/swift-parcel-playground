//
//  SwiftUIView.swift
//  test1package
//
//  Created by Przemyslaw Jablonski on 08/05/2025.
//

import ComposableArchitecture
import SwiftUI

@Reducer
public struct NavigationItemReducer {
  @ObservableState
  public struct State: Equatable {
    public init() {}
  }
  public enum Action {}
  public init() {}
  public var body: some Reducer<State, Action> {
    EmptyReducer()
  }
}

public struct NavigationItemView: View {
  let store: StoreOf<NavigationItemReducer>
  var text: String

  public var body: some View {
    HStack {
      Image(systemName: "globe")
      Text(text)
    }
    .padding()
    .background(
      Color.blue
        .cornerRadius(8)
    )
  }

  public init(text: String, store: StoreOf<NavigationItemReducer>) {
    self.text = text
    self.store = store
  }
}

#Preview {
  List {
    NavigationItemView(
      text: "Lorem Ipsum",
      store: .init(
        initialState: NavigationItemReducer.State(),
        reducer: NavigationItemReducer.init
      )
    )
  }
}
