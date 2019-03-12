import Foundation

/////// computed and observed properties have to (1) use var and (2) specify a data type explicitly
/////// observed properties are triggered when a property's value has changed

/*
Prompt: With a set size for pizza in inches, number of people, and how many slices each person can eat, 
        how many slices does each pizza create? How many pizzas do I need to buy, or, how many people 
        can be fed with leftover pizza?
*/

var pizzaInInches: Int = 10 {
    willSet {
        print("The current value for pizza in inches is \(pizzaInInches)")
        print("New value for pizza in inches is \(newValue)")   // 8
    } didSet {    // if the user changed the pizza in inches to a huge size, change it to 18"
        if pizzaInInches >= 18 {
            print("Invalid size specified, pizzaInInches set to 18\".")
            pizzaInInches = 18
        }
    }
}

pizzaInInches = 300

var numberOfPeople = 12
let slicesPerPerson = 4

var numberOfSlices: Int {
    get {    // how many slices come from a pizza based on its size?
        return pizzaInInches - 4    
    } set {  // runs when numberOfSlices is changed
        print("Number of slices now has a new value which is \(newValue)")    // newValue is a special property
    }
}

var numberOfPizza: Int {
    get {    // now that I know how many slices of pizza that I have, how many pizzas do I need to buy?
        let numberOfPeopleFedPerPizza = numberOfSlices / slicesPerPerson
        return numberOfPeople / numberOfPeopleFedPerPizza
    } set {   // for leftovers, if the number of pizza changes, how many people can we feed?
        let totalSlices = numberOfSlices * newValue
        numberOfPeople = totalSlices / slicesPerPerson
    }
}

numberOfPizza = 2250

print("With \(numberOfPizza) \(pizzaInInches)\" pizzas, you can feed \(numberOfPeople) people if everyone only eats \(slicesPerPerson) slices.")



