extension String {
  public init(_ maybeInt: Int?) {
    if maybeInt != nil {
       self.init("\(maybeInt!)") 
    } else {
       self.init("nil")
    }
  }
}
