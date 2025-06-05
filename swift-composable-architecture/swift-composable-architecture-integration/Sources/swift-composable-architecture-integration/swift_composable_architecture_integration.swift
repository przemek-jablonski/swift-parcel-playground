import ComposableArchitecture
import SwiftUI

//External macro implementation type 'ComposableArchitectureMacros.ReducerMacro' could not be found for macro 'Reducer()'; plugin for module 'ComposableArchitectureMacros' not found

@Reducer
struct Sheet {
  @ObservableState
  struct State: Equatable {}

  enum Action { case action }
}

@Reducer
struct CounterFeature {
  @ObservableState
  struct State: Equatable {
    var count: Int = 0
    var uuid: UUID?
    var optional: String?
    @Presents var sheet: Sheet.State?
  }

  enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case increment
    case decrement
    case reset
    case generateNewID
    case delegate(Delegate)
    case sheet(PresentationAction<Sheet.Action>)
  }

  enum Delegate {
    case reset
  }

  @Dependency(\.uuid) var uuid

  var body: some ReducerOf<Self> {
    BindingReducer()
    EmptyReducer()
    Reduce { state, action in
      switch action {
      case .increment:
        state.count += 1
        return .none
      case .decrement:
        state.count -= 1
        return .none
      case .reset:
        state.count = 0
        return .send(.delegate(.reset))
      case .generateNewID:
        state.uuid = uuid()
        return .none
      case .binding, .delegate, .sheet:
        return .none
      }
    }
    .ifLet(\.$sheet, action: \.sheet) {
      Sheet()
    }
  }
}


import SwiftUI
import ComposableArchitecture

struct CounterView: View {
  @Perception.Bindable var store: StoreOf<CounterFeature>

  var body: some View {
    VStack {
      if let uuid = store.uuid {
        Text("ID: \(uuid.uuidString)")
          .font(.caption2)
          .foregroundColor(.secondary)
      }

      Text("Count: \(store.count)")
        .font(.largeTitle)
      HStack {
        Button("-") { store.send(.decrement) }
        Button("+") { store.send(.increment) }
      }
      Button("Reset") { store.send(.reset) }
      Button("New ID") { store.send(.generateNewID) }
    }
    .padding()
    .sheet(item: $store.scope(state: \.sheet, action: \.sheet)) { _ in
      Text("Sheet")
    }
  }
}
