# Distribution: a signed DMG and the PDF association

**Status:** open — nothing below has been started. Written 2026-09-17 so the
findings are not lost; the decisions at the end are the owner's to make.

This is a plan, not a record of what the app does. What the app does today is
in `REQUIREMENTS.md`.

---

## 1. What is true today

Measured against the 1.5.3 release build, not assumed.

### The PDF association already exists

`macos/Runner/Info.plist` declares:

```
CFBundleDocumentTypes: PDF Document
  LSItemContentTypes = com.adobe.pdf
  CFBundleTypeRole   = Viewer
  LSHandlerRank      = Alternate
```

That is why PDFSign appears in Finder's **Open With** and why double-clicking
a PDF can be routed to it. Two things are worth changing:

- **The role says `Viewer`, and the app is an editor.** It signs, turns pages,
  sets passwords and permissions, and writes the file. `Editor` is the honest
  value, and macOS uses it when it offers an app for a document that is to be
  changed.
- **`Alternate` is correct and should stay.** The owner of `com.adobe.pdf` is
  the system's own Preview. An app cannot make itself the default handler
  silently; the reader does it in Finder (Get Info → Open With → Change All).
  A button could ask on their behalf — see §4, stage 5.

### The build is signed for development, not for distribution

```
Authority        = Apple Development: Ivan Vaganov (PXQF7S7VHL)
TeamIdentifier   = 8QE7DS47T6
entitlements     = …com.apple.security.get-task-allow = true
ENABLE_HARDENED_RUNTIME (Release) = not set
```

It runs here and will not run on anyone else's Mac: Gatekeeper refuses a
download signed this way, with "damaged or cannot be verified".

| Needed to hand the app to someone | State |
|-----------------------------------|-------|
| **Developer ID Application** certificate | **missing** — the keychain holds only "Apple Development" and "Apple Distribution"; the latter is for the App Store and cannot sign a DMG |
| Hardened runtime on the Release build | off; notarization refuses without it |
| No `get-task-allow` in the shipped binary | present today — automatic signing with a development profile adds it |
| Notarization | never run |

The certificate is created at developer.apple.com (Certificates → Developer ID
Application). It needs a paid Apple Developer Program membership and the
Account Holder or Admin role. **It is the one step nobody but the owner can
take**, and everything else waits on it.

### Tools on this machine

`xcrun notarytool` 1.1.2 and `hdiutil` are present. `create-dmg` is not
installed (`brew install create-dmg`); a plain `hdiutil` script needs no
dependency at all.

### The sandbox is off, deliberately

`REQUIREMENTS §2.2`: the app reopens recent files by path, which the sandbox
forbids without security-scoped bookmarks. That rules out the Mac App Store
until bookmarks are implemented, and points at Developer ID as the channel.

---

## 2. The work, in stages

Each stage is committable on its own and the order is the order of dependency.

### Stage 1 — a signature that travels

- Release configuration: `CODE_SIGN_IDENTITY = "Developer ID Application"`,
  `CODE_SIGN_STYLE = Manual`, `ENABLE_HARDENED_RUNTIME = YES`.
- Keep `Release.entitlements` as it is: the sandbox stays off on purpose, and
  the two entitlements there (user-selected files, network client) are what the
  app actually uses.
- Sign the embedded frameworks too, with `--options runtime`.
- Verify: `codesign --verify --deep --strict --verbose=2`, then
  `spctl -a -vvv` on the app, and confirm `get-task-allow` is gone.

### Stage 2 — the disk image

`scripts/make_dmg.sh`, taking the version from `pubspec.yaml`:

- a staging folder holding `PDFSign.app` and a symlink to `/Applications`;
- `hdiutil create -volname "PDFSign <version>" -format UDZO`, producing
  `build/PDFSign-<version>.dmg`;
- optionally a background image with the app and the arrow placed on it — that
  is where `create-dmg` earns its keep, or an AppleScript pass over the
  window's `.DS_Store`;
- `codesign` the image with the same Developer ID.

### Stage 3 — notarization

- once: `xcrun notarytool store-credentials` with an App Store Connect API key
  (preferred) or an app-specific password;
- `xcrun notarytool submit build/PDFSign-<version>.dmg --keychain-profile … --wait`;
- `xcrun stapler staple` the image, so a first launch works offline;
- verify with `spctl -a -vvv -t install` on the stapled image.

### Stage 4 — one command per release

`scripts/release.sh`: read the version, build, sign, package, notarize, staple,
verify, and leave `PDFSign-<version>.dmg` beside the app. Documented in
`README.md`, and the steps recorded here rather than in anyone's memory.

### Stage 5 — the association, finished

- `CFBundleTypeRole` → `Editor`.
- A **"Make PDFSign the default PDF app"** button in Settings:
  `NSWorkspace.setDefaultApplication(at:toOpen:)` on macOS 14+, which asks the
  reader for confirmation; `LSSetDefaultRoleHandlerForContentType` on older
  systems, which does not ask. Both behind availability checks, since the
  deployment target is 10.15.
- The button's label and its result message go into all 66 `.arb` files, like
  every other string.

---

## 3. What this does not cover

- **Updating.** A DMG is a one-time handoff; Sparkle or a "new version"
  check is a separate question, and this plan does not open it.
- **The Mac App Store.** It needs the sandbox, and the sandbox needs
  security-scoped bookmarks (§2.2, §13). A different piece of work entirely.
- **CI.** Signing and notarizing from GitHub Actions means putting the
  certificate and the notary credentials into repository secrets. Worth doing
  only once the local script works.

---

## 4. Decisions waiting on the owner

1. **Channel.** Developer ID with a notarized DMG, or the Mac App Store? The
   recommendation is Developer ID: the store would cost the sandbox work first.
2. **Can a Developer ID Application certificate be issued?** Everything from
   stage 1 onwards depends on it. Without it a DMG can still be built, but it
   will be refused on every machine but this one — which is close to pointless.
3. **How the image should look.** The app and an arrow to `/Applications` is
   ready-made; a background picture needs the picture.
4. **The default-app button, and the role change.** The role change to `Editor`
   is worth making regardless — it is simply true. The button is a nicety and
   can wait.
