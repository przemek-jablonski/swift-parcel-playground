import Testing
import Dependencies
import Foundation
import swift_dependencies_integration

@MainActor
@Suite
struct ExampleTestSuite {
  @Test
  func example() async {
    withDependencies {
      $0.featureService.test = { _ in false }
      $0.uuid = .constant(.init(1))
    } operation: {
      let model = FeatureModel()
      model.addItem()
      #expect(model.items == ["Item 00000000-0000-0000-0000-000000000001"])
    }
  }
}
