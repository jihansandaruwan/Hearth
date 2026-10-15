# Hearth

Hearth is my SE4041 tvOS app for Assignment 2 Part B. It is a recipe board for a television in the living room. A person sits on the sofa, moves with the Apple TV remote, and cooks from large steps.

This is a different app from CraftTrail. CraftTrail is the iPhone craft guide. Hearth is only for Apple TV.

## Who it is for

People cooking at home who want the steps on the TV, not on a phone in their hand. The dishes are familiar Sri Lankan home food: pol sambol, coconut roti, vegetable kottu, hoppers, parippu, chicken curry, fish ambul thiyal, and watalappan.

The notes are simplified demonstration content. Amounts and times are illustrative. They are not tested kitchen measurements, and the recipe page says that.

## Screens

- **Recipes.** The heading is “What are we cooking?” Filters are All, Quick, Rice plate, and After dinner. All shows eight recipes. Each other filter shows only that category. Cards are in horizontal rows and show a photo of the dish, the name, a short description, and a demo time. If a category had no recipes, the screen says so.
- **Recipe.** Name, category, description, demo prep time, demo cook time, servings, and ingredients. Start cooking opens the steps. Save stores it on this Apple TV and shows “Saved on this Apple TV”. Pressing it again shows “Removed from Saved”.
- **Cooking.** One short step in large type, the step number, a progress bar, Previous, and Next. Previous is disabled on the first step. On the last step, Next becomes Done and returns to the recipe. Pol sambol, roti, kottu, parippu, and ambul thiyal have four steps. Hoppers and chicken curry have six. Watalappan has five.
- **Saved.** Recipes you saved. Remove takes one off the list. Nothing saved yet has its own message. The list is still there after you close the app.

The remote is the way you move. Arrow keys move the highlight. A focused recipe card grows slightly and gets a yellow edge. A focused button turns gold. Each recipe row is its own focus section, so left and right stay on that row and up or down leaves it. Return selects. Menu, or Escape in the simulator, goes back. After you close a recipe, the highlight returns to that card.

## What I used

Swift, SwiftUI, NavigationSplitView, NavigationStack, and UserDefaults. There is no account and no network. Focus uses SwiftUI button styles that read `isFocused`. I did not add any third-party libraries. tvOS 17 is the lowest version.

## How to run

1. Open `Hearth.xcodeproj` on a Mac with Xcode.
2. If the Apple TV simulator is missing, install the tvOS platform in Xcode Settings, under Components or Platforms.
3. Choose the Hearth scheme.
4. Choose an Apple TV simulator on tvOS 17 or later.
5. Press Run.

If Xcode asks for a Team, use your Apple ID. The simulator does not need a paid developer account.

On the simulator, the arrow keys move focus, Return selects, and Escape goes back.

## Tests

In Xcode, Product > Test.

- `RecipeFilterTests` checks All, Quick, Rice plate, After dinner, and an empty category.
- `FavouriteStoreTests` saves a recipe, reloads it, blocks a duplicate id, and removes one.
- `CookSessionTests` checks the first step, the last step, going back, and an empty step list.
- `HearthUITests` uses the Siri Remote, because tvOS has no tap. One test opens pol sambol, saves it, goes back, and checks the highlight is on the same card. The other starts cooking, presses Next to the last step, and checks Done returns to the recipe. Both launch with `-ui-testing` so they use an empty save list.

I wrote these tests with the code. I have not run them. This project was prepared on Windows, which cannot run the Apple TV simulator or `xcodebuild`. The result below is the honest status until a Mac runs Product > Test.

| Check | Result on this computer |
| --- | --- |
| Unit tests | Not run |
| UI test | Not run |
| Apple TV simulator | Not run |

## Screenshots

No screenshots yet. Take them from the Apple TV simulator after the first successful run and put them in a `screenshots` folder:

- Recipes, with a card focused
- Rice plate filter
- One recipe page
- Cooking, on a middle step
- Saved, with one recipe
- Saved, empty

## Limits

- Eight dishes, and the text is demo notes.
- Each dish has a generated demo photo. I did not take the pictures, and they are not photos from a cookbook.
- Prep and cook minutes are split from the original demo total so the recipe page can show both. They are still estimates.
- Saved recipes stay on one Apple TV only. There is no iPhone companion.
- The first build on a Mac may ask you to pick a development team.
- There is no app icon yet, so the simulator home screen shows a blank tile.

## Later

- Photos I take myself, in place of the generated demo pictures.
- An app icon and a top-shelf image for the Apple TV home screen.
- More dishes, still stored in the app.

## Where things are

- `Hearth/Views` — screens and recipe cards
- `Hearth/Design` — colours and the focus styles
- `Hearth/Data/RecipeBook.swift` — the recipe text
- `Hearth/Data/RecipeFilter.swift` — shelves and the meal filter
- `Hearth/Models/CookSession.swift` — previous, next, and the last step
- `Hearth/Persistence/FavouriteStore.swift` — saved recipe ids
- `HearthTests` and `HearthUITests`

## Help I used

I used Cursor to help me set the project up and write parts of the code. The app idea, the dishes, and the decision to keep this separate from CraftTrail are mine. I can explain the screens, how the remote focus works, and how saving works.
