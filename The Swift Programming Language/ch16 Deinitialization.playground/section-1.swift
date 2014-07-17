/*
 * 16.1 Preview
 */

//A deinitializer is called immediately before a class instance is deallocated. You write deinitializers with the deinit keyword, similar to how intializers are written with the init keyword. Deinitializers are only available on class types.

// Swift automatically deallocates your instances when they are no longer needed, to free up resources. Swift handles the memory management of instances through automatic reference counting (ARC).

// Deinitializers are called automatically, just before instance deallocation takes place. You are not allowed to call a deinitializer yourself. Superclass deinitializers are inherited by their subclasses, and the superclass deinitializer is called automatically at the end of a subclass deinitializer implementation. Superclass deinitializers are always called, even if a subclass does not provide its own deinitializer.
// Because an instance is not deallocated until after its deinitializer is called, a deinitializer can access all properties of the instance it is called on and can modify its behavior based on those properties (such as looking up the name of a file that needs to be closed).


/*
 * 16.2 Example
 */

struct Bank {
    static var coinsInBank = 10_000
    static func vendCoins(var numberOfCoinsToVend: Int) -> Int { // 分发硬币
        numberOfCoinsToVend = min(numberOfCoinsToVend, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    static func receiveCoins(coins: Int) { // 回收硬币
        coinsInBank += coins
    }
}

class Player {
    var coinsInPurse: Int
    init(coins: Int) {
        coinsInPurse = Bank.vendCoins(coins)
    }
    func winCoins(coins: Int) {
        coinsInPurse += Bank.vendCoins(coins)
    }
    deinit { // 析构
        Bank.receiveCoins(coinsInPurse)
    }
}

var playerOne: Player? = Player(coins: 100)
playerOne!.coinsInPurse
Bank.coinsInBank

playerOne!.winCoins(2_000)
playerOne!.coinsInPurse
Bank.coinsInBank

// setting the optional playerOne variable to nil, meaning “no Player instance.” At the point that this happens, the playerOne variable’s reference to the Player instance is broken. No other properties or variables are still referring to the Player instance, and so it is deallocated in order to free up its memory. Just before this happens, its deinitializer is called automatically, and its coins are returned to the bank.
playerOne = nil
println("PlayerOne has left the game")
Bank.coinsInBank // 这里有点问题，playerOne的析构方法可能被延迟调用了

