# COSMIC Kit

COSMIC Kit is a rootless iOS toolkit for Control Center controls, helper code, and future module APIs in the MoarTweaks ecosystem.

COSMIC expands to:

```text
COSMIC Open Source Module Interface & Controls
```

The project is intended to be a shared home for reusable Control Center pieces: module implementations, common helpers, compatibility shims, and experiments that should evolve separately from larger user-facing tweaks.

This source repository is intentionally separate from the public package feed. Pushing here does not publish a package to the live APT repo or GitHub Pages.

## Building

COSMIC Kit is a rootless Theos project.

```sh
env CLANG_MODULE_CACHE_PATH=/tmp/clang-module-cache SWIFT_MODULE_CACHE_PATH=/tmp/swift-module-cache make clean package FINALPACKAGE=1
```

The package is currently configured for iOS 16:

- package id: `com.futur3sn0w.cosmickit`
- firmware: `>= 16.0, << 17.0`
- install path: `/Library/ControlCenter/Bundles`

## Scope

COSMIC Kit is intentionally broad. It may contain:

- reusable Control Center module foundations
- module-specific helper APIs
- shared UI and state utilities
- compatibility wrappers for private Control Center classes
- experiments that need to be tested independently before becoming part of a larger tweak

Specific module lists will be documented once those modules are cleaner, better tested, and ready to be described as public-facing features.

## Working With CCAster

COSMIC Kit can work alongside [CCAster](https://github.com/MoarTweaks/CCAster), but the projects have different responsibilities.

CCAster focuses on the Control Center experience itself: layout, editing, paging, resizing, and presentation behavior. COSMIC Kit is the lower-level companion space for controls and helpers that can be shared, tested, or replaced independently.

## Future Module Model

The long-term goal is for COSMIC Kit to support richer module patterns than static one-off bundles. A future CCAster/COSMIC integration can support:

- module families
- duplicate-capable modules
- dynamically generated module instances
- per-instance settings and state
- a COSMIC-aware add sheet in CCAster

The intended model is for CCAster to present one friendly module family in the add sheet while generating unique Apple-facing module identifiers internally. That lets CCAster and COSMIC treat several controls as one family, while iOS still sees distinct module identifiers for layout, persistence, and removal.
