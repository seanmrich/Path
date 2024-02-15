import ComposableArchitecture

@ObservableState
@CasePathable
public enum RootPathState {
  case child(ChildState)
}
