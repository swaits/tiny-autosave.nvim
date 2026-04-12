# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.2] - 2026-04-12

### Fixed

- `BufWritePre` formatters (e.g. conform.nvim format-on-save) now run on
  autosave. The trigger autocmd now uses `nested = true`, so the `:write`
  invoked from inside the `InsertLeave` / `TextChanged` / `FocusLost`
  handler fires nested autocmds (see `:help autocmd-nested`).

### Changed

- Skip saves for unmodified, unnamed, or special (`buftype`) buffers instead
  of always attempting a write.
- Drop `:wall` — autosave only writes the buffer the event fired on.
- Use `silent` (not `silent!`) so write errors surface instead of being
  swallowed.

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

[0.1.2]: https://github.com/swaits/tiny-autosave.nvim/releases/tag/v0.1.2
[0.1.1]: https://github.com/swaits/tiny-autosave.nvim/releases/tag/v0.1.1
[0.1.0]: https://github.com/swaits/tiny-autosave.nvim/releases/tag/v0.1.0
