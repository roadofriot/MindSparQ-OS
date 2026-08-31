# MindSparQ OS — UI Component Library & Standards

> **Visual Source of Truth**: [Google Stitch Project `13746084714856879502`](https://stitch.withgoogle.com/projects/13746084714856879502)  
> All components preserve the exact markup patterns, Tailwind utilities, and styling extracted from Stitch screens.

---

## 1. Buttons

### 1.1 Primary Action Button
Features an inset top highlight `shadow-[inset_0_2px_0_rgba(255,255,255,0.2)]` for a subtle, tactile finish.

```html
<button class="bg-primary text-on-primary font-label-md text-label-md px-md py-sm rounded-lg flex items-center justify-center gap-xs shadow-[inset_0_2px_0_rgba(255,255,255,0.2)] hover:bg-primary-container transition-all hover:shadow-[0_4px_20px_rgba(0,0,0,0.05)] active:scale-[0.98]">
  <span class="material-symbols-outlined text-[18px]">add</span>
  <span>New School</span>
</button>
```

### 1.2 Outline / Secondary Button
Used for filtering, secondary actions, and exports.

```html
<button class="px-md py-sm rounded-lg border border-outline-variant text-on-surface hover:bg-surface-container transition-colors font-label-md text-label-md flex items-center gap-xs focus:outline-none focus:ring-2 focus:ring-primary">
  <span class="material-symbols-outlined text-[18px]">download</span>
  <span>Export Report</span>
</button>
```

### 1.3 Ghost / Filter Button
Used inside search bars and contextual filter rows.

```html
<button class="flex items-center gap-xs px-sm py-sm text-secondary hover:bg-surface-container rounded-md transition-colors font-label-md text-label-md border border-transparent hover:border-outline-variant">
  <span class="material-symbols-outlined text-[18px]">filter_list</span>
  <span>More Filters</span>
</button>
```

### 1.4 Destructive / Emergency Button
Used in crisis response, contract cancellation, and data isolation.

```html
<button class="w-full bg-error text-on-error hover:bg-[#a11515] font-label-md text-label-md py-3 px-4 rounded-lg flex justify-between items-center transition-colors shadow-sm active:scale-[0.98]">
  <div class="flex items-center gap-2">
    <span class="material-symbols-outlined">lock_person</span>
    <span>Initiate Campus Lockdown</span>
  </div>
  <span class="material-symbols-outlined text-[18px]">chevron_right</span>
</button>
```

### 1.5 Circular Icon Button
Used in the top navigation bar for alerts, settings, and toggles.

```html
<button class="text-on-surface-variant hover:bg-surface-container rounded-full p-2 scale-95 active:scale-90 transition-transform relative">
  <span class="material-symbols-outlined">notifications</span>
  <span class="absolute top-1.5 right-1.5 w-2 h-2 rounded-full bg-error ring-2 ring-surface"></span>
</button>
```

---

## 2. Inputs & Form Fields

### 2.1 Standard Text & Number Field
```html
<div class="flex flex-col gap-1.5 w-full">
  <label class="font-label-md text-label-md text-on-surface flex items-center gap-1">
    <span>Course Code / कोर्स कोड</span>
    <span class="text-error">*</span>
  </label>
  <input 
    type="text" 
    placeholder="e.g. CS-101" 
    class="w-full bg-surface-container-lowest border border-outline-variant rounded-lg px-4 py-3 font-body-md text-body-md text-on-surface placeholder:text-on-surface-variant/60 focus:outline-none focus:border-primary focus:ring-1 focus:ring-primary transition-colors"
  />
  <span class="text-xs text-on-surface-variant">Unique departmental identifier</span>
</div>
```

### 2.2 Global Search Field (Header & Tables)
```html
<div class="relative w-full max-w-md">
  <span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-on-surface-variant text-[20px]">
    search
  </span>
  <input 
    type="search" 
    placeholder="Search schools, teachers, student IDs..." 
    class="w-full pl-10 pr-4 py-2 bg-surface-container-low border border-transparent rounded-full font-body-md text-body-md text-on-surface focus:border-primary focus:bg-surface focus:ring-1 focus:ring-primary transition-all outline-none"
  />
</div>
```

### 2.3 Select Dropdown
```html
<div class="relative w-full">
  <select class="w-full appearance-none bg-surface-container-lowest border border-outline-variant rounded-lg px-4 py-3 font-body-md text-body-md text-on-surface focus:outline-none focus:border-primary focus:ring-1 focus:ring-primary transition-colors pr-10">
    <option value="">Select Academic Term / सत्र छान्नुहोस्</option>
    <option value="2083-t1">Term 1 (2083)</option>
    <option value="2083-t2">Term 2 (2083)</option>
  </select>
  <span class="material-symbols-outlined pointer-events-none absolute right-3 top-1/2 -translate-y-1/2 text-on-surface-variant">
    expand_more
  </span>
</div>
```

---

## 3. Cards & Panels

### 3.1 Soft Card (Universal Container)
The fundamental container for metrics, charts, and content blocks.

```html
<div class="soft-card bg-surface-container-lowest border border-[#E5E5E7] rounded-[16px] p-6 hover:shadow-[0px_4px_20px_rgba(0,0,0,0.05)] transition-all duration-200">
  <div class="flex items-center justify-between mb-4">
    <h3 class="font-headline-md text-headline-md text-on-surface">Total Schools Enrolled</h3>
    <span class="p-2 rounded-lg bg-primary-fixed text-primary">
      <span class="material-symbols-outlined">school</span>
    </span>
  </div>
  <div class="text-[36px] font-bold text-on-surface tracking-tight mb-1">1,248</div>
  <div class="flex items-center gap-1 text-xs text-success font-medium">
    <span class="material-symbols-outlined text-[16px]">trending_up</span>
    <span>+12.4% from last academic session</span>
  </div>
</div>
```

---

## 4. Tables

### 4.1 Enterprise Data Table
Strict alignment with clean row borders and hover highlights.

```html
<div class="soft-card bg-surface-container-lowest border border-[#E5E5E7] rounded-[16px] overflow-hidden">
  <table class="w-full text-left border-collapse">
    <thead>
      <tr class="bg-surface-container-low border-b border-outline-variant font-label-md text-label-md text-on-surface-variant">
        <th class="py-3.5 px-4 font-semibold">विद्यालय नाम (School Name)</th>
        <th class="py-3.5 px-4 font-semibold">जिल्ला / कोड (District/Code)</th>
        <th class="py-3.5 px-4 font-semibold">विद्यार्थी संख्या (Students)</th>
        <th class="py-3.5 px-4 font-semibold">स्थिति (Status)</th>
        <th class="py-3.5 px-4 font-semibold text-right">कार्यहरू (Actions)</th>
      </tr>
    </thead>
    <tbody class="divide-y divide-[#E5E5E7] font-body-md text-body-md text-on-surface">
      <tr class="hover:bg-surface-container-low/50 transition-colors">
        <td class="py-4 px-4 font-medium">Shree Sharda Secondary School</td>
        <td class="py-4 px-4 text-on-surface-variant">Kathmandu / KTM-042</td>
        <td class="py-4 px-4">1,420</td>
        <td class="py-4 px-4">
          <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-[#d4f8e8] text-[#006e3d]">
            Active
          </span>
        </td>
        <td class="py-4 px-4 text-right">
          <button class="p-1 rounded hover:bg-surface-container text-on-surface-variant">
            <span class="material-symbols-outlined text-[20px]">more_vert</span>
          </button>
        </td>
      </tr>
    </tbody>
  </table>
</div>
```

---

## 5. Dialogs & Modals

### 5.1 Confirmation & Form Modal
Centrally positioned with backdrop blur.

```html
<div class="fixed inset-0 z-50 flex items-center justify-center bg-black/40 backdrop-blur-sm p-4">
  <div class="soft-card bg-surface-container-lowest border border-outline-variant rounded-[16px] w-full max-w-lg shadow-[0px_20px_50px_rgba(0,0,0,0.15)] overflow-hidden">
    <div class="p-6 border-b border-outline-variant flex items-center justify-between">
      <h3 class="font-headline-md text-headline-md text-on-surface">Confirm Data Reconciliation</h3>
      <button class="text-on-surface-variant hover:text-on-surface">
        <span class="material-symbols-outlined">close</span>
      </button>
    </div>
    <div class="p-6 font-body-md text-body-md text-on-surface-variant">
      Are you sure you want to run the automated ledger synchronization for 28 district schools? This operation will lock edits during execution.
    </div>
    <div class="p-6 bg-surface-container-low flex justify-end gap-3">
      <button class="px-4 py-2 border border-outline-variant rounded-lg text-on-surface font-label-md">
        रद्द गर्नुहोस् (Cancel)
      </button>
      <button class="px-4 py-2 bg-primary text-on-primary rounded-lg font-label-md shadow-sm hover:bg-primary-container">
        पुष्टि गर्नुहोस् (Confirm)
      </button>
    </div>
  </div>
</div>
```

---

## 6. Bottom Sheets (Mobile Field Companion)

Mobile field screens slide up from the bottom for rapid input.

```html
<div class="fixed inset-x-0 bottom-0 z-50 bg-surface rounded-t-[24px] border-t border-outline-variant p-6 shadow-2xl animate-slide-up">
  <div class="w-12 h-1.5 bg-surface-container-high rounded-full mx-auto mb-4"></div>
  <h3 class="font-headline-md text-headline-md mb-2">Gate Scanner / प्रवेश जाँच</h3>
  <p class="text-sm text-on-surface-variant mb-4">Scan student or faculty RFID / QR code badge.</p>
  <button class="w-full bg-primary text-on-primary py-3.5 rounded-xl font-label-md flex items-center justify-center gap-2">
    <span class="material-symbols-outlined">qr_code_scanner</span>
    <span>Start Scanner</span>
  </button>
</div>
```

---

## 7. Navigation Shell

### 7.1 Desktop Sidebar Component (260px)
```html
<nav class="hidden md:flex flex-col bg-surface w-[260px] h-screen border-r border-outline-variant fixed left-0 top-0 bottom-0 p-md z-40">
  <div class="mb-lg flex items-center gap-sm">
    <div class="w-10 h-10 rounded-lg bg-primary flex items-center justify-center text-on-primary font-bold text-xl">M</div>
    <div>
      <h1 class="font-headline-md text-headline-md text-on-surface leading-none">MindSparQ OS</h1>
      <span class="text-xs text-on-surface-variant font-medium">आन्तरिक व्यवस्थापन</span>
    </div>
  </div>
  <button class="mb-md w-full bg-primary text-on-primary font-label-md text-label-md py-sm rounded-lg flex items-center justify-center gap-xs shadow-[inset_0_2px_0_rgba(255,255,255,0.2)] hover:bg-primary-container transition-colors">
    <span class="material-symbols-outlined">add</span>
    <span>नयाँ विद्यालय (New School)</span>
  </button>
  <div class="flex-1 space-y-1 overflow-y-auto">
    <a href="#" class="flex items-center gap-3 px-3 py-2.5 rounded-lg bg-primary-fixed text-primary font-medium">
      <span class="material-symbols-outlined">dashboard</span>
      <span>ड्यासबोर्ड (Dashboard)</span>
    </a>
    <a href="#" class="flex items-center gap-3 px-3 py-2.5 rounded-lg text-on-surface-variant hover:bg-surface-container">
      <span class="material-symbols-outlined">school</span>
      <span>विद्यालयहरू (Schools)</span>
    </a>
  </div>
</nav>
```

---

## 8. Alerts & Banners

```html
<!-- Emergency Alert Banner -->
<div class="p-4 rounded-xl bg-error-container text-on-error-container border border-error/30 flex items-start gap-3">
  <span class="material-symbols-outlined text-error text-[24px]">warning</span>
  <div>
    <h4 class="font-semibold text-sm">Emergency Alert: Weather Warning</h4>
    <p class="text-xs opacity-90">Classes suspended in Nuwakot district due to landslide warning.</p>
  </div>
</div>
```

---

## 9. Empty States & Loading States

```html
<!-- Empty State -->
<div class="p-12 text-center flex flex-col items-center justify-center">
  <div class="w-16 h-16 rounded-full bg-surface-container flex items-center justify-center text-on-surface-variant mb-4">
    <span class="material-symbols-outlined text-[32px]">folder_open</span>
  </div>
  <h4 class="font-headline-md text-headline-md text-on-surface mb-1">कुनै विवरण फेला परेन</h4>
  <p class="text-sm text-on-surface-variant mb-4">No records found matching the filter criteria.</p>
  <button class="px-4 py-2 border border-outline-variant rounded-lg text-sm font-medium hover:bg-surface-container">
    Reset Filters
  </button>
</div>

<!-- Skeleton Loading Card -->
<div class="soft-card bg-surface-container-lowest border border-[#E5E5E7] rounded-[16px] p-6 animate-pulse">
  <div class="h-4 bg-surface-container-high rounded w-1/3 mb-4"></div>
  <div class="h-8 bg-surface-container-high rounded w-1/2 mb-2"></div>
  <div class="h-3 bg-surface-container-high rounded w-2/3"></div>
</div>
```
