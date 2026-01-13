# GitHub Copilot instructions for this repository

## Quick context ✅
- Flutter app (single-page catalogue + product detail + cart). Minimal dependencies (only `cupertino_icons`).
- UI-first layout: `lib/screens/*` (pages), `lib/widgets/*` (reusable UI), `lib/models/*` (data shapes), `lib/data/dummy_data.dart` (seed data).

## Big picture / architecture 🔧
- Single-app UI with explicit routes using `Navigator.of(context).push(MaterialPageRoute(...))` (keep this pattern for small features).
- Product model: `lib/models/product.dart`.
- Seed data: `lib/data/dummy_data.dart` — used across components, modify here for local feature data.
- Cart state: a provider skeleton exists at `lib/providers/cart.dart` but it is incomplete and currently unused. Preferred approach: implement `ChangeNotifier` in that file and provide in `main.dart`.

## Project-specific conventions & patterns 📐
- Theme is centralized in `lib/main.dart` (Material3, dark mode enforced). Respect `ColorScheme.fromSeed` and existing colors when adding UI.
- Hero animations use `product.id` as tag (see `lib/widgets/product_item.dart` and `lib/screens/product_detail_screen.dart`) — keep tags unique and stable.
- Price formatting: code uses `toStringAsFixed(2).replaceAll('.', ',')` for BR-style decimals; follow this when showing prices.
- Navigation: use `MaterialPageRoute(...)` not named routes in this small app.

## Known quirks / TODOs ⚠️
- `lib/providers/cart.dart` is incomplete and not wired into `main.dart`. Typical fix: make `Cart` extend `ChangeNotifier` and wrap app with `ChangeNotifierProvider`.
- The code uses a non-standard helper method `withValues(alpha: ...)` (e.g., `Colors.white.withValues(alpha: 0.05)`). This helper is not found in the repo—either implement a small extension `extension ColorExtensions on Color { Color withValues({double alpha}) => withOpacity(alpha); }` in `lib/utils/` or replace invocations with `withOpacity(...)`.
- Some shorthand tokens like `.cover`, `.bold` appear throughout; if these compile in CI they must be from a local extension—otherwise replace them with `BoxFit.cover` / `FontWeight.bold`.
- 'Add to cart' action on `ProductDetailScreen` currently shows a SnackBar but doesn't persist to cart (implement via `Cart` provider).

## Tests & developer workflows 🧪
- Common commands:
  - Install deps: `flutter pub get`
  - Static analysis: `flutter analyze`
  - Format: `dart format .` (or `flutter format .`)
  - Tests: `flutter test` (there's a basic `test/widget_test.dart`)
  - Run locally: `flutter run -d <device>`; use hot reload (r) and hot restart (R) during development.
- Add widget tests for `ProductItem` and `ProductDetailScreen` to assert layout and price formatting. For state, add tests for `Cart` once implemented.

## Integration points & external deps 🌐
- Images are loaded from the network (`https://picsum.photos/...`) — ensure tests mock network images (`NetworkImage`) or use `cached_network_image` if adding caching.
- No backend or platform channels present; adding persistence (shared_preferences/hive) would be isolated to a `services/` or `repositories/` folder.

## Example tasks for an AI agent (concrete, actionable) ✅
- Implement `Cart` provider:
  - Update `lib/providers/cart.dart` to implement `ChangeNotifier` with add/remove/total logic.
  - Wrap `MyApp` in `main.dart` with `ChangeNotifierProvider(create: (_) => Cart())`.
  - Replace hard-coded counts/totals in `HomeScreen`/`CartScreen` with provider consumers.
- Fix `withValues` usage: search and replace with `withOpacity` or add a small `Color` extension inside `lib/utils/color_extensions.dart` and export it.
- Add tests: create `test/product_item_test.dart` that pumps `ProductItem` with test product and verifies title/price are shown.

---

If any of these points are incomplete or you want me to implement a specific fix (e.g., author a `Cart` provider and wire it up, or replace `withValues` usages), tell me which task to start and I will open a PR with focused changes and tests. 🔧
