import Foundation

/// Home-style notes written for this demo. They are not a published cookbook.
enum RecipeBook {
    static let all: [Recipe] = [
        Recipe(
            id: "pol",
            name: "Pol sambol",
            summary: "Scraped coconut with onion, chili, and lime. No cooking.",
            meal: .quick,
            prepMinutes: 15,
            cookMinutes: 0,
            serves: 4,
            plate: .coconut,
            ingredients: [
                "2 cups scraped coconut",
                "1 small red onion",
                "2 green chilies",
                "Salt",
                "Half a lime",
                "A pinch of Maldives fish, if you have it"
            ],
            steps: [
                "Slice the onion thinly and chop the chilies.",
                "Pound the chili with a little salt so it breaks down.",
                "Mix that through the coconut and onion with your hand.",
                "Add lime at the end and taste. It should be sharp, not wet."
            ]
        ),
        Recipe(
            id: "roti",
            name: "Coconut roti",
            summary: "A griddle roti with scraped coconut in the dough.",
            meal: .quick,
            prepMinutes: 10,
            cookMinutes: 15,
            serves: 4,
            plate: .roti,
            ingredients: [
                "2 cups flour",
                "1 cup scraped coconut",
                "Salt",
                "A spoon of oil",
                "Warm water"
            ],
            steps: [
                "Mix flour, coconut, and salt. Rub in the oil.",
                "Add warm water until you have a soft dough. Rest it for 10 minutes.",
                "Divide into balls and pat each one flat.",
                "Cook on a hot griddle until both sides have brown spots."
            ]
        ),
        Recipe(
            id: "kottu",
            name: "Vegetable kottu",
            summary: "Chopped roti tossed on a high flame with cabbage and egg.",
            meal: .quick,
            prepMinutes: 8,
            cookMinutes: 12,
            serves: 3,
            plate: .kottu,
            ingredients: [
                "4 leftover roti or godamba",
                "1 cup chopped cabbage",
                "1 carrot",
                "1 onion",
                "2 eggs",
                "Chili flakes and salt",
                "A splash of oil"
            ],
            steps: [
                "Cut the roti into strips. Slice the onion and carrot.",
                "Heat the pan until it is properly hot, then add the oil and onion.",
                "Add the vegetables. When they soften, push them aside and scramble the eggs.",
                "Toss in the roti and salt. Keep moving it so the edges crisp."
            ]
        ),
        Recipe(
            id: "hopper",
            name: "Hoppers",
            summary: "Coconut-milk batter cooked in a small curved pan.",
            meal: .quick,
            prepMinutes: 15,
            cookMinutes: 15,
            serves: 4,
            plate: .hopper,
            ingredients: [
                "2 cups rice flour",
                "1 cup coconut milk",
                "A pinch of sugar",
                "Salt",
                "Warm water"
            ],
            steps: [
                "Stir the flour, coconut milk, sugar, and salt. Add warm water until the batter pours.",
                "Cover the bowl and rest it. An hour is enough for this demo batch.",
                "Stir once more. It should pour, not sit in a lump.",
                "Heat the hopper pan. Wipe it with a little oil if the first one sticks.",
                "Ladle in a little batter and swirl it up the sides.",
                "Cover the pan. Lift it when the middle is set and the edge is lacy."
            ]
        ),
        Recipe(
            id: "dhal",
            name: "Parippu",
            summary: "Red lentils finished with a curry-leaf temper.",
            meal: .rice,
            prepMinutes: 5,
            cookMinutes: 20,
            serves: 4,
            plate: .dhal,
            ingredients: [
                "1 cup red lentils",
                "Half an onion",
                "Turmeric",
                "1 cup thin coconut milk",
                "Curry leaves",
                "Mustard seed",
                "A dried chili"
            ],
            steps: [
                "Rinse the lentils and simmer them with turmeric and onion until soft.",
                "Stir in the coconut milk and a little salt. Do not boil it hard.",
                "In a small pan, heat oil, mustard seed, dried chili, and curry leaves.",
                "Pour that temper over the lentils and cover for a minute."
            ]
        ),
        Recipe(
            id: "chicken",
            name: "Chicken curry",
            summary: "A coconut-milk chicken curry for a rice plate.",
            meal: .rice,
            prepMinutes: 10,
            cookMinutes: 30,
            serves: 4,
            plate: .curry,
            ingredients: [
                "500 g chicken, in pieces",
                "1 onion",
                "2 cloves garlic",
                "A thumb of ginger",
                "1 spoon roasted curry powder",
                "1 cup coconut milk",
                "Curry leaves and salt"
            ],
            steps: [
                "Slice the onion. Pound the garlic and ginger together.",
                "Heat a little oil and brown the chicken pieces.",
                "Add the onion and cook until it softens.",
                "Add ginger, garlic, curry powder, and curry leaves. Stir so the powder does not burn.",
                "Pour in the coconut milk and salt.",
                "Simmer until the chicken is cooked through and the gravy has thickened a little."
            ]
        ),
        Recipe(
            id: "ambul",
            name: "Fish ambul thiyal",
            summary: "A dry, sour fish curry with goraka and black pepper.",
            meal: .rice,
            prepMinutes: 10,
            cookMinutes: 25,
            serves: 4,
            plate: .fish,
            ingredients: [
                "500 g firm fish, cubed",
                "4 pieces goraka",
                "1 spoon black pepper",
                "Half an onion",
                "Curry leaves",
                "Salt",
                "A little water"
            ],
            steps: [
                "Soak the goraka in a splash of warm water and mash it.",
                "Rub the fish with salt and pepper.",
                "Put the fish, goraka, onion, and curry leaves in a pan with just enough water to cover the base.",
                "Cook uncovered until the liquid is almost gone and the fish looks glossy, not swimming."
            ]
        ),
        Recipe(
            id: "watalappan",
            name: "Watalappan",
            summary: "Steamed coconut custard with jaggery and cardamom.",
            meal: .sweet,
            prepMinutes: 15,
            cookMinutes: 35,
            serves: 6,
            plate: .custard,
            ingredients: [
                "1 cup thick coconut milk",
                "150 g jaggery",
                "3 eggs",
                "4 cardamom pods",
                "A pinch of salt"
            ],
            steps: [
                "Melt the jaggery in a spoon of water and let it cool a little.",
                "Beat the eggs, then stir in the coconut milk, jaggery, crushed cardamom, and salt.",
                "Strain the mix into a bowl that fits inside a steamer.",
                "Steam gently until the centre is just set.",
                "Cool it before serving. It firms up as it cools."
            ]
        )
    ]

    static func recipe(id: String) -> Recipe? {
        all.first { $0.id == id }
    }
}
