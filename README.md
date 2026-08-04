![Flutter CI](https://github.com/MannDangrechiya/revolt_data/workflows/Flutter%20CI/badge.svg?branch=main)

# revolt_data

> **Status**: Production Candidate (v1.0.0) — Covered by automated tests. Pending Real Hardware Validation.

A Flutter EV logbook app for the Revolt RV400 — local-only, no backend, all data in an on-device Drift/SQLite database.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Build & Release

Two GitHub Actions workflows cover CI and releases:

- **`flutter_ci.yml`** — runs on every push to `dev-mann`/`main` and every PR into `main`. Installs deps, regenerates code (`build_runner`), fails if generated `.g.dart`/`.freezed.dart` output doesn't match what's committed, runs `flutter analyze --fatal-infos --fatal-warnings`, then `flutter test --coverage` with an inline lcov summary.
- **`flutter_build.yml`** — runs on push to `main` (or manually via `workflow_dispatch`). Builds a split-per-ABI release APK and an App Bundle, uploaded as artifacts named `revolt-data-<version>+<short-sha>`.

### Release signing

Release builds are signed with the debug key until real signing secrets are added. To switch to a real upload key, add these repo secrets (Settings → Secrets and variables → Actions):

| Secret | Description |
|---|---|
| `KEYSTORE_BASE64` | `base64`-encoded upload keystore (`.jks`) |
| `KEYSTORE_PASSWORD` | Keystore password |
| `KEY_PASSWORD` | Key password |
| `KEY_ALIAS` | Key alias |

`android/app/build.gradle.kts` reads `android/key.properties` when present and falls back to debug signing otherwise — see `android/key.properties.example` for the local dev format.
