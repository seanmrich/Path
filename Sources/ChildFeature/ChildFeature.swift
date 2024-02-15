import ComposableArchitecture
import FeatureStates
import SwiftUI

@Reducer
public struct ChildFeature {
  public typealias State = ChildState
  public init() {}
}

public struct ChildFeatureView: View {
  let store: StoreOf<ChildFeature>
  
  public init(store: StoreOf<ChildFeature>) {
    self.store = store
  }
  
  public var body: some View {
    EmptyView()
  }
}
