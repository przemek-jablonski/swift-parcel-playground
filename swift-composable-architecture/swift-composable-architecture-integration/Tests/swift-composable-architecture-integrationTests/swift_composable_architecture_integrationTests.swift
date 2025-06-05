import Testing
import ComposableArchitecture
import Foundation
@testable import swift_composable_architecture_integration

@MainActor
@Suite
struct CounterFeatureTests {
  @Test
  func testIncrement() async {
    let store = TestStore(
      initialState: CounterFeature.State(count: 0),
      reducer: { CounterFeature() }
    )

    await store.send(.increment) {
      $0.count = 1
    }
  }

  @Test
  func testDecrement() async {
    let store = TestStore(
      initialState: CounterFeature.State(count: 2),
      reducer: { CounterFeature() }
    )

    await store.send(.decrement) {
      $0.count = 1
    }
  }

  @Test
  func testResetSendsDelegate() async {
    let store = TestStore(
      initialState: CounterFeature.State(count: 10),
      reducer: { CounterFeature() }
    )

    await store.send(.reset) {
      $0.count = 0
    }
    // If your reducer actually emits .delegate(.reset), otherwise remove this:
    await store.receive(.delegate(.reset))
  }

  @Test
  func testGenerateNewID() async {
    let store = TestStore(
      initialState: CounterFeature.State(),
      reducer: { CounterFeature() }
    ) {
      $0.uuid = .incrementing
    }

    await store.send(.generateNewID) {
      $0.uuid = UUID(0)
    }
  }

  @Test
  func testBindingDoesNothing() async {
    let store = TestStore(
      initialState: CounterFeature.State(optional: "before"),
      reducer: { CounterFeature() }
    )

    await store.send(.binding(.set(\.optional, "changed"))) {
      $0.optional = "changed"
    }
  }

  @Test
  func testSheetPresentation() async {
    let store = TestStore(
      initialState: CounterFeature.State(),
      reducer: { CounterFeature() }
    )

    await store.send(.binding(.set(\.sheet, Sheet.State()))) {
      $0.sheet = Sheet.State()
    }

    await store.send(.sheet(.dismiss)) {
      $0.sheet = nil
    }
  }
}
