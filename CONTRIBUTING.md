# Contributing to `revolt_data`

Thank you for your interest in contributing to **`revolt_data`**! We welcome bug reports, feature requests, documentation improvements, and code contributions.

---

## 1. Code of Conduct

All contributors are expected to adhere to our [Code of Conduct](CODE_OF_CONDUCT.md). Please read it before participating.

---

## 2. Getting Started

1. **Fork & Clone**:
   ```bash
   git clone https://github.com/MannDangrechiya/revolt_data.git
   cd revolt_data
   ```

2. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run Code Generation**:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Run Analysis & Tests**:
   ```bash
   flutter analyze
   flutter test
   ```

---

## 3. Pull Request Guidelines

- Keep pull requests focused on a single feature or bug fix.
- Ensure all static analysis checks pass with zero warnings (`flutter analyze`).
- Include corresponding unit or widget tests for new functionality.
- Do not commit generated files unless necessary; verify `git status` before pushing.
- Write descriptive commit messages using Conventional Commits format (`feat: ...`, `fix: ...`, `docs: ...`, `chore: ...`).

---

## 4. Reporting Issues

- Use the official [GitHub Issue Templates](.github/issue_template/).
- Search existing issues before opening a new bug report or feature request.
- Provide detailed reproduction steps and logs when reporting bugs.
