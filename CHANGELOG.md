# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.1] - 2026-04-09

### Fixed

- Save after normal mode changes (undo, redo, paste, delete) by adding
  `TextChanged` to default events

## [0.1.0] - 2026-04-09

### Added

- Initial release
- Auto-save on InsertLeave and FocusLost
- Configurable trigger events
- Zero-config auto-loading via `plugin/` directory

[0.1.1]: https://github.com/swaits/tiny-autosave.nvim/releases/tag/v0.1.1
[0.1.0]: https://github.com/swaits/tiny-autosave.nvim/releases/tag/v0.1.0
