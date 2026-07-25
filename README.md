# COSMIC Kit

COSMIC Kit is a rootless iOS Control Center module package and future module API home for the MoarTweaks Control Center ecosystem.

COSMIC expands to:

```text
COSMIC Open Source Module Interface & Controls
```

For now, COSMIC Kit owns the standalone module bundles that used to be aggregated into CCAster itself. The first split keeps the existing module bundle identifiers intact so current CCAster runtime handling and saved user layouts continue to recognize them.

This source repository is intentionally separate from the public package feed. Pushing here does not publish a package to the live APT repo or GitHub Pages.

## Building

COSMIC Kit is a rootless Theos project.

```sh
env CLANG_MODULE_CACHE_PATH=/tmp/clang-module-cache SWIFT_MODULE_CACHE_PATH=/tmp/swift-module-cache make clean package FINALPACKAGE=1
```

The package is configured for iOS 16:

- package id: `com.futur3sn0w.cosmickit`
- firmware: `>= 16.0, << 17.0`
- install path: `/Library/ControlCenter/Bundles`

## Current Modules

The first module group is `Modules/Connectivity`, which builds:

- Airplane Mode
- Wi-Fi
- AirDrop
- Cellular Data
- Bluetooth
- Personal Hotspot
- VPN

Each module is currently a separate Control Center bundle that shares the same implementation file, `CCAConnectivityModules.xm`.

## CCAster

COSMIC Kit is designed to work with [CCAster](https://github.com/MoarTweaks/CCAster), but it is packaged separately so optional modules can evolve without bloating or destabilizing the CCAster core.

The split is:

- CCAster owns the Control Center experience: layout, editing, add sheet, paging, resize behavior, and runtime integration.
- COSMIC Kit owns optional module bundles and, eventually, reusable module APIs.

CCAster currently recommends COSMIC Kit but does not require it. This lets the core tweak remain usable without the optional module pack.

## Future Module Model

The long-term goal is for COSMIC Kit modules to be richer than static one-off bundles. A future CCAster/COSMIC integration can support:

- module families
- duplicate-capable modules
- dynamically generated module instances
- per-instance settings and state
- a COSMIC-aware add sheet in CCAster

The intended model is for CCAster to present one friendly module family in the add sheet while generating unique Apple-facing module identifiers internally. That lets CCAster and COSMIC treat several controls as one family, while iOS still sees distinct module identifiers for layout, persistence, and removal.
