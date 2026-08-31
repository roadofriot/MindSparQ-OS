# MindSparQ OS — Design System & Visual Specification

> **Visual Source of Truth**: [Google Stitch Project `13746084714856879502`](https://stitch.withgoogle.com/projects/13746084714856879502)  
> **Platform**: Desktop Institutional Management Suite with Mobile Field Companions  
> **Locale Support**: Bilingual (English / Nepali - `नेपाली`)

---

## 1. Design Philosophy & Brand Personality

MindSparQ OS is an institutional operating system designed for schools, campuses, and educational networks. It bridges executive oversight with operational field execution.

* **Clarity & Authority**: Clean, distraction-free surfaces that prioritize tabular information, attendance feeds, and financial figures.
* **Warm Enterprise (Modern Institutional)**: Moves away from sterile corporate grayscale by employing a warm off-white canvas (`#FCF8FB`) anchored by an authoritative Academic Blue (`#004E9F`).
* **Bilingual Native**: Designed from the ground up for dual English and Nepali (`नेपाली`) scripts, ensuring appropriate font metrics and visual balance.
* **High Information Density with Generous Breathing Room**: Uses consistent 4px/8px modular units with defined card containers to segment complex workflows.

---

## 2. Color System (Material & Stitch Tokens)

### 2.1 Primary & Functional Palette

| Token | Hex Value | Role & Usage |
|---|---|---|
| `primary` | `#004E9F` | Primary buttons, active navigation, focus rings, key brand markers |
| `primary-container` | `#0066CC` | Hover states on primary buttons, highlighted active chips |
| `on-primary` | `#FFFFFF` | Text and icons placed on primary surfaces |
| `on-primary-container`| `#DFE8FF` | High-contrast secondary text inside primary containers |
| `primary-fixed` | `#D7E3FF` | Accent badge fills, soft active backgrounds |
| `primary-fixed-dim` | `#AAC7FF` | Borders and subdued primary highlights |
| `surface-tint` | `#005CBA` | Focus highlights, link text on hover |

### 2.2 Neutral & Surface Hierarchy (Light Theme Canvas)

| Token | Hex Value | Role & Usage |
|---|---|---|
| `background` / `surface` | `#FCF8FB` | Application background canvas (soft warm off-white) |
| `surface-bright` | `#FCF8FB` | High-emphasis canvas regions |
| `surface-dim` | `#DCD9DC` | Disabled component backgrounds, inactive tracks |
| `surface-container-lowest` | `#FFFFFF` | Primary card background, dialog surfaces, modal panels |
| `surface-container-low` | `#F6F3F5` | Secondary card fills, search bar inputs, table headers |
| `surface-container` | `#F0EDEF` | Filter bars, inactive toggle backgrounds |
| `surface-container-high` | `#EAE7EA` | Hover state on neutral rows, subtle separators |
| `surface-container-highest`| `#E4E2E4` | Border lines, divider rules, subtle card outlines |
| `on-surface` | `#1B1B1D` | High-contrast primary text and icons |
| `on-surface-variant` | `#414753` | Secondary text, field labels, placeholder hints |
| `outline` | `#727784` | Form input borders, active toggles |
| `outline-variant` | `#C1C6D5` | Card borders, table grid lines, sidebar right divider |

### 2.3 Secondary, Tertiary & Status Semantics

| Token | Hex Value | Role & Usage |
|---|---|---|
| `secondary` | `#5E5E63` | Subdued metadata, secondary icon buttons |
| `secondary-container` | `#E0DFE4` | Secondary badge backgrounds |
| `on-secondary-container` | `#626267` | Text within secondary badges |
| `tertiary` (Warning) | `#883700` | Warning badges, pending attendance, approaching deadlines |
| `tertiary-container` | `#AF4900` | High-alert warning backgrounds |
| `on-tertiary` | `#FFFFFF` | Text on warning states |
| `error` | `#BA1A1A` | Destructive buttons, emergency lockdown, failed reconciliation |
| `error-container` | `#FFDAD6` | Error alert banners, low stock alert pill background |
| `on-error` | `#FFFFFF` | Text on error buttons |
| `on-error-container` | `#93000A` | Text inside error alert banners |
| `success` (Semantic) | `#008855` | Verified attendance, balanced accounts, approved contracts |

---

## 3. Typography System

The primary typeface across all Stitch screens is **Inter**, coupled with **Material Symbols Outlined** for iconography.

```css
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap');
```

### 3.1 Type Scale & Roles

| Style | Font Family | Size | Line Height | Weight | Letter Spacing | Purpose |
|---|---|---|---|---|---|---|
| `display-lg` | Inter | 48px | 56px | 600 (Semi-Bold) | -0.02em | Primary page hero titles |
| `headline-lg` | Inter | 32px | 40px | 600 (Semi-Bold) | -0.01em | Section headers, modal titles |
| `headline-md` | Inter | 24px | 32px | 600 (Semi-Bold) | -0.01em | Card titles, drawer headers |
| `body-lg` | Inter | 17px | 26px | 400 (Regular) | -0.01em | Longform text, intro paragraphs |
| `body-md` | Inter | 15px | 22px | 400 (Regular) | 0em | Table cell text, input fields |
| `label-md` | Inter | 13px | 18px | 500 (Medium) | +0.01em | Buttons, tab titles, table headers |
| `label-sm` | Inter | 11px | 16px | 600 (Semi-Bold) | +0.03em | Status badges, timestamps, tags |

### 3.2 Bilingual Considerations (Nepali / `नेपाली`)
* The Devanagari script renders naturally in modern Inter / Noto Sans Devanagari fallbacks.
* Devanagari line-heights are given +2px extra clearance to prevent matra clipping.
* Common bilingual labels:
  * Dashboard: `ड्यासबोर्ड`
  * Schools: `विद्यालयहरू`
  * Teachers: `शिक्षकहरू`
  * Programs / Courses: `कार्यक्रमहरू`
  * Finance: `वित्त`
  * Attendance / Gatekeeper: `प्रवेश रक्षक`
  * Reports: `रिपोर्टहरू`
  * Settings: `सेटिङहरू`

---

## 4. Spacing, Grid & Layout Metrics

The spatial system is based on an **8px grid** with 4px micro-increments.

```json
{
  "unit": "4px",
  "xs": "8px",
  "sm": "16px",
  "md": "24px",
  "lg": "32px",
  "xl": "48px",
  "gutter": "24px",
  "margin": "40px"
}
```

* **Sidebar Width**: Fixed `260px` on desktop layouts.
* **Content Stage Max Width**: Fluid up to `2560px` canvas with `max-w-7xl` or `max-w-[1920px]` inner container restraints.
* **Grid Gutter**: `24px` between cards and columns.
* **Card Internal Padding**: `24px` (`p-md`) for desktop, `16px` (`p-sm`) for mobile.

---

## 5. Border Radius & Corner Geometry

* `borderRadius.DEFAULT`: `4px` (`0.25rem`) — Micro badges, checkboxes, small tags.
* `borderRadius.lg`: `8px` (`0.5rem`) — Form inputs, standard buttons, table row containers.
* `borderRadius.xl`: `12px` (`0.75rem`) — Dropdowns, contextual menus, mobile action buttons.
* `soft-card`: `16px` (`1rem`) — All primary metric cards, dashboard panels, and modals.
* `borderRadius.full`: `9999px` — Circular avatars, icon action buttons, pill badges.

---

## 6. Elevation & Depth Strategy

Depth is achieved through **Subtle Borders** rather than heavy drop shadows:

1. **Level 0 (Canvas)**: Solid `#FCF8FB`.
2. **Level 1 (Card / Container)**: Solid `#FFFFFF`, `border: 1px solid #E5E5E7` (or `#C1C6D5`), `border-radius: 16px`.
3. **Level 1 Hover**: `box-shadow: 0px 4px 20px rgba(0, 0, 0, 0.05)`, transition 0.2s ease-in-out.
4. **Level 2 (Dropdowns & Popovers)**: `#FFFFFF`, `box-shadow: 0px 8px 30px rgba(0, 0, 0, 0.08)`, `border: 1px solid #E4E2E4`.
5. **Level 3 (Modals / Dialogs)**: `#FFFFFF`, `box-shadow: 0px 20px 50px rgba(0, 0, 0, 0.15)`, with an `rgba(0, 0, 0, 0.4)` backdrop.

---

## 7. Themes: Light Mode & Dark Mode Inversion

### 7.1 Default Theme (Light Mode)
* Optimal for bright classroom lighting and administrative desktop monitors.
* High contrast ratio (>7:1) for text on `#FFFFFF` and `#FCF8FB`.

### 7.2 Dark Theme (Class Inversion Scheme)
* Background: `#1B1B1D` (Surface Inverse)
* Surface Containers: `#262629` / `#303032`
* Primary: `#AAC7FF` (Primary Fixed Dim)
* On-Surface: `#F3F0F2` (Inverse On Surface)
* Outline: `#414753`

---

## 8. Shell Navigation Architecture

```
┌────────────────────────────────────────────────────────┐
│  Desktop Shell Layout                                  │
├──────────────┬─────────────────────────────────────────┤
│ Sidebar      │ Top Bar: Search | Notifications | Profile│
│ [260px]      ├─────────────────────────────────────────┤
│              │ Breadcrumb / Page Header               │
│ - Brand Logo ├─────────────────────────────────────────┤
│ - + New      │                                         │
│ - Nav Links  │ Content Canvas                          │
│ - System     │ (Cards, Data Tables, Charts)            │
│              │                                         │
│ - Help/Logout│                                         │
└──────────────┴─────────────────────────────────────────┘
```

* **Sidebar**: Fixed on left, full viewport height (`h-screen`), persistent.
* **Top Utility Bar**: Search bar with keyboard shortcut pill, notification icon with unread badge, active user profile pill.
* **Content Stage**: Scrollable, structured with `p-md` to `p-lg`.
