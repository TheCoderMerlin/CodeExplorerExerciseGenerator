extension String {
    
    public init(_ maybeInt: Int?) {
        if maybeInt != nil {
            self.init("\(maybeInt!)") 
        } else {
            self.init("nil")
        }
    }

    
    public func leftPadding(toLength: Int, withPad character: Character) -> String {                              
        let stringLength = self.count                                                                             
        if stringLength < toLength {                                                                              
            return String(repeatElement(character, count: toLength - stringLength)) + self                        
        } else {                                                                                                  
            return self                                                                                           
        }                                                                                                         
    }                                                                                                             
    
    // Returns a new string with chaacters in groups and separated as specified                                   
    // This should not be used for integer numbers which may be negative because it can create                    
    // strings such as -,123.  Instead, use the absolute value in such cases then add the                         
    // - sign afterwards.                                                                                         
    public func charactersInSets(of setSize:Int, separatedBy:Character, paddedBy:Character) -> String {           
        // First, determine the total number of characters required                                               
        let currentCharacterCount = self.count                                                                    
        let targetCharacterCount = ((max(currentCharacterCount, 1) + (setSize - 1)) / setSize) * setSize          
        var originalString = self                                                                                 
        var newString = ""                                                                                        
        
        var position = 0                                                                                          
        while !originalString.isEmpty {                                                                           
            newString.insert(originalString.last!, at:newString.startIndex)                                       
            originalString.removeLast()                                                                           
            
            position += 1                                                                                         
            if (position % setSize == 0 && position < targetCharacterCount) {                                     
                newString.insert(separatedBy, at:newString.startIndex)                                            
            }                                                                                                     
        }                                                                                                         
        
        while (position < targetCharacterCount) {                                                                 
            newString.insert(paddedBy, at:newString.startIndex)                                                   
            position += 1                                                                                         
        }                                                                                                         
        
        return newString                                                                                          
    }                                                                                                             
    
}
