# MindSparQ OS — Entry Guard UX Specification

> **Visual Source of Truth**: Stitch Screen `ad2c782fa85e4a9ca3d9331b1287fe57` ("Entry Guard - Attendance")  
> **Design Language**: MindSparQ Stitch Design System (`DESIGN.md`, `UI_COMPONENTS.md`, `RESPONSIVE.md`)  
> **Platforms**: Android, iOS, Windows, Linux, macOS  
> **Core Purpose**: Institutional physical presence verification, GPS-fenced check-in/out, biometric identity confirmation, and tamper-resistant offline telemetry for school faculty and staff.

---

## 1. System Overview & Architecture

Entry Guard operates as an intelligent institutional gatekeeper. It guarantees authentic presence using a **Triple-Lock Verification Model**:
1. **Spatial Lock**: Precision GPS calculation against the school perimeter centroid (Geofence radius typically 80m–120m).
2. **Identity Lock**: Native biometric sensor verification (Face ID / Fingerprint / Touch ID).
3. **Temporal Lock**: Tamper-proof network timestamping with cryptographic local storage fallback for offline schools.

```
[ Institutional Gate Entry ]
            │
    ┌───────┴───────┐
    ▼               ▼
[Mobile App]   [Admin Desktop Cockpit]
(Faculty Check-in)  (Real-Time Regional Map & Live Logs)
    │               │
    └───────┬───────┘
            ▼
    [Supabase Entry Guard API & Geofence Engine]
```

---

## 2. Attendance Status Taxonomy

All status badges follow the Stitch pill design (`rounded-full`, uppercase `label-sm`, 12px horizontal padding, 4px vertical padding):

| Status | Visual Tokens | Trigger Logic | Stitch Screen Mapping |
| :--- | :--- | :--- | :--- |
| **`PRESENT`** | Bg: `#E6F4EA`<br>Border: `#CEEAD6`<br>Text/Dot: `#137333` | Check-in completed within perimeter before official shift start + grace period (e.g. 15 mins). | Green badge with filled circular dot in Live Summary and logs. |
| **`LATE`** | Bg: `#FEF7E0`<br>Border: `#FEEFC3`<br>Text/Dot: `#E37400` | Check-in recorded after grace period expiration (e.g., >09:15 AM). | Amber badge with clock icon `schedule`. |
| **`ABSENT`** | Bg: `#FCE8E6`<br>Border: `#FAD2CF`<br>Text/Dot: `#C5221F` | Shift concluded without any valid gate check-in record. | Soft red badge with cancel icon `cancel`. |
| **`ON_LEAVE`** | Bg: `#E0DFE4`<br>Border: `#C7C6CB`<br>Text/Dot: `#5E5E63` | Pre-approved institutional leave (sick, casual, duty leave). | Neutral secondary pill with event icon. |
| **`HALF_DAY`** | Bg: `#FFDBCB`<br>Border: `#FFB692`<br>Text/Dot: `#883700` | Checked in late or checked out early with total duration between 3h and 5h. | Tertiary peach pill with warning tone. |

---

## 3. Check-In UX Flow

### 3.1 Mobile Faculty Check-in States
1. **Perimeter Detection**:
   * App monitors background geofence using OS-level circular region monitoring.
   * Upon crossing boundary: Notification `"Welcome to [School Name]. Tap to confirm attendance."`
2. **Presence Verification Card**:
   * Primary Button: `AppButtonVariant.primary`, height 54px, full width.
   * Label: `"हाजिरी प्रमाणित गर्नुहोस् (Verify Attendance)"`.
   * Icon: `Icons.fingerprint` (32px).
3. **Biometric Trigger**:
   * System invokes local biometric prompt: `"Confirm identity for MindSparQ Entry Guard"`.
4. **Success Feedback**:
   * Haptic success buzz + checkmark animation.
   * Status updates immediately to **`Verified`** (`#004E9F`).
   * Displays check-in time e.g., `"Entry: 08:48 AM"` and active shift counter.

### 3.2 Desktop Cockpit Telemetry
* Live updates stream via Supabase real-time channel.
* Metric increment: `Live Status Summary (142 / 150 Total Staff)`.
* Map beacon pulses at the school coordinate.

---

## 4. Check-Out UX Flow

1. **Active Shift State**:
   * Persistent top banner during shift: `"Active Shift • 4h 18m elapsed"`.
2. **Departure Trigger**:
   * Faculty initiates check-out via `"प्रस्थान दर्ता गर्नुहोस् (Log Departure)"` button.
3. **Early Departure Warning Modal**:
   * If checkout occurs prior to scheduled shift end (e.g. before 04:00 PM):
     * Dialog: `AppDialog` with backdrop blur.
     * Title: `"Early Departure Notice"`.
     * Selection dropdown for reason: `"Official Duty (काज)"`, `"Emergency"`, `"Medical"`, `"Approved Permission"`.
4. **Summary Card**:
   * Total shift duration displayed e.g., `"Duration: 7h 12m"`.
   * Status transitions from `Active` to `Checked-out`.

---

## 5. Location Status & GPS Accuracy

To prevent false check-ins, Entry Guard measures and displays live GPS confidence:

```
    [ GPS Sensor Signal ]
             │
             ├── Accuracy ≤ 15m ─────► [ HIGH ACCURACY ] ──► Check-In Enabled
             ├── 15m < Accuracy ≤ 50m ► [ MODERATE ]       ──► Check-In Enabled with Warning
             └── Accuracy > 50m ─────► [ POOR / UNUSABLE ]──► Check-In Blocked (Calibrating)
```

### 5.1 Precision Levels & Visual Indicators
* **`HIGH ACCURACY` (≤ 15 meters)**:
  * Indicator: Solid green radar dot + `"GPS Accuracy: ±8m (Optimal)"`.
  * Allows instantaneous check-in.
* **`MODERATE ACCURACY` (15m to 50m)**:
  * Indicator: Amber pulse dot + `"GPS Accuracy: ±32m (Acceptable)"`.
  * Suggests stepping into open sky for higher precision.
* **`POOR ACCURACY` (> 50 meters)**:
  * Indicator: Red warning pill + `"GPS Weak (±85m) • Acquiring satellites..."`.
  * Check-in button disabled until threshold improves or secondary QR fallback is unlocked.

---

## 6. Geofence Status

Institutional schools in Nepal often feature campus compounds with boundary walls. The geofence is defined as a polygon or circular radius (standard 100m from school office):

| Geofence State | Radius Distance | Visual State | Action Permission |
| :--- | :--- | :--- | :--- |
| **`INSIDE_PERIMETER`** | `Distance ≤ Boundary Radius` | Blue pill: `Secured` (`#004E9F`) with blue pulse beacon on map. | Check-in / Check-out fully enabled. |
| **`APPROACHING_ZONE`** | `Radius < Distance ≤ 250m` | Amber pill: `Approaching (180m away)`. | Check-in disabled; hints remaining distance to gate. |
| **`OUTSIDE_PERIMETER`** | `Distance > 250m` | Grey/Red pill: `Outside Zone (1.4 km from ABC School)`. | Check-in disabled. |
| **`MOCK_LOCATION_DETECTED`**| Fake GPS / Developer hook | Red alert banner: `Spoofing Detected`. | System locked; security telemetry sent to Central Admin. |

---

## 7. Permission Status Matrix

Entry Guard requests Location and Biometric permissions with institutional transparency:

| Permission State | System Behavior | UX Fallback |
| :--- | :--- | :--- |
| **`GRANTED_PRECISE`** | Full GPS geofencing & background arrival detection. | Optimal state. |
| **`APPROXIMATE_ONLY`** | OS provides only coarse location (e.g. iOS 14 / Android 12). | Full-screen prompt: `"Precise Location Required"`. Deep-link CTA: `"Enable Precise Location in Settings"`. |
| **`DENIED_TEMPORARY`** | User dismissed prompt. | Soft warning banner: `"Location permission required to verify gate presence."` |
| **`DENIED_PERMANENT`** | Permission blocked permanently. | Dialog: `"Institutional Attendance Requires Location"`. Button: `"Open System Settings"`. |
| **`BIOMETRICS_UNAVAILABLE`**| Device lacks fingerprint/face sensor. | System PIN or Supervisor OTP verification fallback. |

---

## 8. Offline Status & Resilient Sync

Many regional institutions in Nepal (e.g., in Karnali or remote districts) experience intermittent power or internet outages. Entry Guard enforces an **Offline-First Zero Data Loss** policy:

### 8.1 Offline Architecture
1. **Local Cryptographic Vault**:
   * Record stored in encrypted device storage (AES-256 with device hardware keystore).
   * Payload: `{teacher_id, timestamp_utc, latitude, longitude, accuracy, biometric_hash, signature}`.
2. **Visual Indicators**:
   * Status Pill: Amber badge `"Offline • Saved Locally (Sync Pending)"` with cloud-off icon `cloud_off`.
   * Counter badge in TopAppBar: `"3 logs awaiting sync"`.
3. **Automatic Reconnection Sync**:
   * Background daemon listens for connectivity recovery.
   * Dispatches queue to Supabase `attendance_logs` table using idempotent UUIDs.
   * On successful sync: Badge updates to `"All logs synchronized ✓"`.

---

## 9. Verification Status

Every attendance entry in the central audit table (`ad2c782fa85e4a9ca3d9331b1287fe57`) displays a tamper verification tier:

* **`VERIFIED`** (Blue Pill with Check Icon):
  * GPS inside geofence (`accuracy ≤ 15m`).
  * Biometric confirmed.
  * Time synchronized with NTP server.
* **`LATE`** (Amber Pill with Clock Icon):
  * Valid location and identity, but logged after official shift commencement.
* **`FLAGGED_OVERRIDE`** (Amber/Warning Badge):
  * Geofence boundary exception granted by School Principal or Admin override with signed reason.
* **`REJECTED / TAMPERED`** (Red Pill with Exclamation):
  * Clock manipulation or mock provider detected.

---

## 10. Error States & Recovery Workflows

```
┌───────────────────────────────────────────────────────────────────────┐
│                      ENTRY GUARD ERROR TAXONOMY                       │
├──────────────────────────┬───────────────────────┬────────────────────┤
│ Error Condition          │ User-Facing Message   │ Recovery Action    │
├──────────────────────────┼───────────────────────┼────────────────────┤
│ GPS Timeout (>15s)       │ "Unable to acquire    │ "Retry GPS Search" │
│                          │ satellite lock"       │                    │
├──────────────────────────┼───────────────────────┼────────────────────┤
│ Out of Geofence          │ "You are 320m from    │ "View Gate Radius" │
│                          │ school perimeter"     │ (renders map card) │
├──────────────────────────┼───────────────────────┼────────────────────┤
│ Biometric 5x Failure     │ "Biometric match      │ "Enter Security    │
│                          │ failed"               │ Master PIN"        │
├──────────────────────────┼───────────────────────┼────────────────────┤
│ Mock GPS / Location Mock │ "Security Violation:  │ System locked;     │
│                          │ Mock provider active" │ audit event logged │
├──────────────────────────┼───────────────────────┼────────────────────┤
│ Database Network Outage  │ "Network offline. Log │ Automatic silent   │
│                          │ secured to device."   │ background sync    │
└──────────────────────────┴───────────────────────┴────────────────────┘
```

---

## 11. Stitch Component Mapping & Layout Hierarchy

### Desktop Layout (`ad2c782fa85e4a9ca3d9331b1287fe57`)
* **Left Column (4 Cols)**:
  * `LIVE STATUS SUMMARY` SoftCard: Staff present/late/absent counters.
  * `ACTIVE LOCATION ZONES` SoftCard: List of schools with `Secured` / `Warning` status chips.
* **Right Column (8 Cols)**:
  * `Regional Map & Live Telemetry Feed`: Real-time map with interactive GPS beacons.
  * `ATTENDANCE LOGS Table`: Real-time data table with Teacher, School, Entry, Exit, Duration, and Status badges.

### Mobile Layout
* **Header**: Active school perimeter pill + live GPS accuracy badge.
* **Presence Gate Card**: Quick one-tap biometric check-in / check-out button with proximity radar circle.
* **Today's Timeline**: Entry time, active duration, exit status.
* **Recent Logs**: Scrollable cards with verification badges.
