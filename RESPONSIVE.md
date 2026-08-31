# MindSparQ OS — Responsive & Cross-Platform Architecture

> **Visual Source of Truth**: [Google Stitch Project `13746084714856879502`](https://stitch.withgoogle.com/projects/13746084714856879502)  
> MindSparQ OS spans desktop central administrative consoles (2560px baseline) down to handheld field companion apps (390px - 780px).

---

## 1. Breakpoint System & Viewport Adaptations

| Device Class | Breakpoint Range | Shell Pattern | Primary Use Case |
|---|---|---|---|
| **Mobile Compact** | `< 640px` (390px - 480px) | Single column, bottom dock / bottom sheet | Security Gate, QR scanning, Teacher attendance |
| **Mobile Standard / Phablet** | `640px - 767px` (780px canvas) | Single/double hybrid column, slide drawers | Field audits, Parent/Stakeholder portal |
| **Tablet Portrait** | `768px - 1023px` | Collapsible sidebar / Off-canvas drawer | Classroom teacher workstation, iPad audits |
| **Desktop Standard** | `1024px - 1439px` | Persistent 260px sidebar + scroll stage | Administrative office workstation |
| **Desktop Ultra / HD** | `1440px - 2560px` | Persistent sidebar + multi-column card grid | Central Executive Command Center, Finance Dash |

---

## 2. Layout Adaptations by Form Factor

### 2.1 Desktop (1440px - 2560px HD)
* **Sidebar**: Permanently docked at `260px` fixed width (`fixed left-0 top-0 bottom-0`).
* **Stage Margin**: Content offset by `ml-[260px]` with `p-lg` (32px - 48px padding).
* **Card Grids**: 4-column KPI metric blocks (`grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-md`).
* **Data Tables**: Full widescreen view with direct inline action buttons (`Edit`, `Export`, `Audit`).
* **Form Layouts**: Two-column to three-column grouped fieldsets with explicit side preview cards.

### 2.2 Tablet (768px - 1023px)
* **Sidebar**: Collapsed into an icon rail (`w-[72px]`) or an off-canvas drawer triggered by a hamburger menu.
* **Card Grids**: 2-column layout (`grid-cols-2 gap-sm`).
* **Data Tables**: Horizontally scrollable container with frozen first column (`sticky left-0 bg-surface`).
* **Modals**: Centered overlays with `max-w-md` constraints.

### 2.3 Mobile Handheld (390px - 780px)
* **Sidebar**: Hidden. Replaced by:
  1. **Top Minimal Bar**: School title + Notification bell + Avatar.
  2. **Bottom Persistent Dock**: 4 core icons (`Home`, `Attendance`, `Finance`, `Menu`).
* **Touch Targets**: Minimum hit region of `48px × 48px` on all interactive buttons.
* **Modals**: Transform into **Bottom Sheets** sliding up from bottom with drag handle.
* **Form Inputs**: 100% full width (`w-full`), minimum height `48px`, font size `16px` to prevent iOS zoom.

---

## 3. Platform-Specific Implementations

### 3.1 Windows Desktop
* **Window Frame**: Support Windows 11 rounded window frames with native caption buttons (minimize, maximize, close).
* **Typography Fallback**: `Inter`, Segoe UI, sans-serif.
* **Scrollbars**: Thin overlay scrollbars conforming to Windows Fluent design guidelines:
  ```css
  ::-webkit-scrollbar { width: 6px; height: 6px; }
  ::-webkit-scrollbar-thumb { background: #C1C6D5; border-radius: 9999px; }
  ::-webkit-scrollbar-thumb:hover { background: #727784; }
  ```
* **Keyboard Navigation**: Full `Tab` order, `Alt` mnemonic shortcuts, `Ctrl+F` global search focus.

### 3.2 Linux Desktop (Debian / Ubuntu / Fedora)
* **Window Frame**: Client-Side Decoration (CSD) compliant with GNOME / Adwaita guidelines.
* **Typography Fallback**: `Inter`, Ubuntu, Cantarell, FreeSans, sans-serif.
* **Dark Mode Sync**: Support `org.freedesktop.appearance.color-scheme` DBus signal for automatic theme switching.
* **High-DPI**: Fractional scaling support (125%, 150%, 175%) without layout breakage.

### 3.3 Android (Tablets & Phones)
* **Navigation Inset**: Respect Android gesture bar safe-area insets (`padding-bottom: env(safe-area-inset-bottom)`).
* **Hardware Back Button**: Android back button must close active bottom sheets and dialogs before navigating back.
* **Biometrics / Camera**: Fast native bridge for camera QR scanning (Entry Guard module) and fingerprint biometrics.
* **Material Haptics**: Light haptic feedback on button presses and attendance confirmations.

### 3.4 iOS & iPadOS
* **Safe Area Insets**:
  ```css
  padding-top: env(safe-area-inset-top);
  padding-bottom: env(safe-area-inset-bottom);
  ```
* **Typography Fallback**: `Inter`, -apple-system, BlinkMacSystemFont, "SF Pro Text", sans-serif.
* **Scroll Dynamics**: Native momentum scrolling with `-webkit-overflow-scrolling: touch`.
* **Keyboard Insets**: Prevent viewport shifting when virtual keyboard activates on form inputs.
* **Swipe-to-Go-Back**: Support horizontal edge swipe gestures on navigation stacks.

---

## 4. Responsive Data Table Strategy

For complex institutional data tables (e.g. 50+ schools with 8 data columns):

```
┌────────────────────────────────────────────────────────┐
│ Desktop: Full Widescreen Table                         │
│ [School Name] [District] [Students] [Status] [Action]  │
├────────────────────────────────────────────────────────┤
│ Mobile: Transformed Card Stack                         │
│ ┌────────────────────────────────────────────────────┐ │
│ │ 🏫 Shree Sharda Secondary School                   │ │
│ │ District: Kathmandu | Status: Active               │ │
│ │ Students: 1,420                                    │ │
│ │ [View Details]                                     │ │
│ └────────────────────────────────────────────────────┘ │
└────────────────────────────────────────────────────────┘
```

* **Breakpoint Transition**: At `< 768px`, dense tabular rows automatically reflow into stacked entity cards, preserving complete data accessibility without horizontal clipping.
