import Foundation
import SwiftUI
import Dependencies

public struct FeatureService: Sendable {
  public var test: @Sendable (Int) throws -> Bool
}

extension FeatureService: DependencyKey {
  public static var liveValue = Self(test: { _ in true })
}

public extension DependencyValues {
  var featureService: FeatureService {
    get { self[FeatureService.self] }
    set { self[FeatureService.self] = newValue }
  }
}

@Observable
public final class FeatureModel {
  public var items: [String] = []

  @ObservationIgnored
  @Dependency(\.continuousClock) var clock
  @ObservationIgnored
  @Dependency(\.date.now) var now
  @ObservationIgnored
  @Dependency(\.mainQueue) var mainQueue
  @ObservationIgnored
  @Dependency(\.uuid) var uuid
  @ObservationIgnored
  @Dependency(\.featureService) var featureService

  public init(
    items: [String] = []
  ) {
    self.items = items
  }

  public func addItem() {
    _ = try? featureService.test(1)
    let newItem = "Item \(uuid().uuidString)"
    items.append(newItem)
  }
}

struct FeatureView: View {
  var viewModel = FeatureModel()

  var body: some View {
    VStack {
      if viewModel.items.isEmpty {
        Text("No items yet")
          .foregroundStyle(.secondary)
      } else {
        List(viewModel.items, id: \.self) { item in
          Text(item)
        }
      }
      Button("Add Item") {
        viewModel.addItem()
      }
      .buttonStyle(.borderedProminent)
      .padding(.top)
    }
    .padding()
  }
}

struct FeatureView_Previews: PreviewProvider {
  static var previews: some View {
    FeatureView()
  }
}
