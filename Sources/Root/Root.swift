import ChildFeature
import ComposableArchitecture
import FeatureStates
import SwiftUI

@Reducer
public struct Root {
//  @Reducer
//  public enum Path {
//    public typealias State = RootPathState
//    case child
//  }
  @Reducer
  public struct Path {
    public typealias State = RootPathState
    public enum Action {
      case child(ChildFeature.Action)
    }
    public var body: some ReducerOf<Self> {
      Scope(state: \.child, action: \.child) {
        ChildFeature()
      }
    }
  }
  
  @ObservableState
  public struct State {
    public var path: StackState<Path.State>
  }
  public enum Action {
    case path(StackAction<Path.State, Path.Action>)
  }
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .path:
        return .none
      }
    }
    .forEach(\.path, action: \.path) {
      Root.Path()
    }
  }
}

public struct RootView: View {
  @Bindable var store: StoreOf<Root>
  
  public init(store: StoreOf<Root>) {
    self.store = store
  }
  
  public var body: some View {
    NavStack(store: store.scope(state: \.path, action: \.path))
//    NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
//      EmptyView()
//    } destination: { pathStore in
//      switch pathStore.case {
//      case .child(let childStore):
//        ChildFeatureView(store: childStore)
//      }
//    }
  }
}

struct NavStack: View {
  @Bindable var store: Store<StackState<Root.Path.State>, StackAction<Root.Path.State, Root.Path.Action>>
  
  var body: some View {
    NavigationStack(path: $store) {
      EmptyView()
    } destination: { pathStore in
      switch pathStore.case {
      case .child(let childStore):
        ChildFeatureView(store: childStore)
      }
    }
  }
}
