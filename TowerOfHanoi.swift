//Author: Eduardo Tolmasquim
//Iterative implementation Tower of Hanoi

enum Position {
    case p1,p2,p3
    
    static func other(then firstPos:Position, and secondPos:Position)->Position {
        let position : Set<Position> = [.p1,.p2,.p3]
        let positionLeft = position.subtracting([firstPos,secondPos])
        return positionLeft.first!
    }
}

struct State {
    var diskCount : Int
    var origin    : Position
    var destiny   : Position
    
    func tuple()->(diskCount:Int,origin:Position,destiny:Position) {
        return (self.diskCount,self.origin,self.destiny)
    }
}

var stack = [State]()
var pile:[Position:[Int]] = [.p1:[],.p2:[],.p3:[]]

func moveDisk(from origin: Position, to destiny:Position) {
    let disk = pile[origin]?.removeLast()
    pile[destiny]?.append(disk!)
}

var steps = 0
pile[.p1] = [8,7,6,5,4,3,2,1]
let initialState = State(diskCount: pile[.p1]!.count, origin: .p1, destiny: .p3)
stack.append(initialState)

while !stack.isEmpty {
    let currentState = stack.removeLast()
    let (diskCount,origin,destiny) = currentState.tuple()
    if (diskCount == 1) {
        moveDisk(from: origin, to: destiny)
        steps += 1
    } else {
        let work = Position.other(then: origin, and: destiny)
        let step3 = State(diskCount: diskCount-1, origin: work, destiny: destiny)
        stack.append(step3)
        let step2 = State(diskCount: 1, origin: origin, destiny: destiny)
        stack.append(step2)
        let step1 = State(diskCount: diskCount-1, origin: origin, destiny: work)
        stack.append(step1)
        
    }
}
print("pile 1:\(pile[.p1]!), pile 2:\(pile[.p2]!), pile 3: \(pile[.p3]!)")
print("steps: \(steps)")
