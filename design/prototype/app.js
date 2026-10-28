const SPRITE = `
<svg width="0" height="0" style="position:absolute" aria-hidden="true"><defs>
<symbol id="i-back" viewBox="0 0 24 24"><path d="M15 19l-7-7 7-7"/></symbol>
<symbol id="i-share" viewBox="0 0 24 24"><path d="M12 15V3m0 0L8 7m4-4l4 4M5 13v7h14v-7"/></symbol>
<symbol id="i-pause" viewBox="0 0 24 24"><rect x="7" y="5" width="3.5" height="14" rx="1.2" fill="currentColor" stroke="none"/><rect x="13.5" y="5" width="3.5" height="14" rx="1.2" fill="currentColor" stroke="none"/></symbol>
<symbol id="i-play" viewBox="0 0 24 24"><path d="M8 5.5v13l10.5-6.5z" fill="currentColor" stroke="none"/></symbol>
<symbol id="i-stop" viewBox="0 0 24 24"><rect x="6" y="6" width="12" height="12" rx="2.5" fill="currentColor" stroke="none"/></symbol>
<symbol id="i-lock" viewBox="0 0 24 24"><rect x="5" y="10.5" width="14" height="9.5" rx="2.5"/><path d="M8 10.5V8a4 4 0 018 0v2.5"/></symbol>
<symbol id="i-chev" viewBox="0 0 24 24"><path d="M9 5l7 7-7 7"/></symbol>
<symbol id="i-chev-left" viewBox="0 0 24 24"><path d="M15 5l-7 7 7 7"/></symbol>
<symbol id="i-check" viewBox="0 0 24 24"><path d="M5 13l4 4L19 7"/></symbol>
<symbol id="i-check-circle" viewBox="0 0 24 24"><circle cx="12" cy="12" r="9"/><path d="M8 12.5l2.6 2.6L16 9.5"/></symbol>
<symbol id="i-watch" viewBox="0 0 24 24"><rect x="7" y="6.5" width="10" height="11" rx="3"/><path d="M9.5 3h5M9.5 21h5M12 10v2.2l1.6 1"/></symbol>
<symbol id="i-route" viewBox="0 0 24 24"><circle cx="5.5" cy="18.5" r="2.2"/><circle cx="18.5" cy="5.5" r="2.2"/><path d="M7.7 18.5h4.8a3.5 3.5 0 000-7H10a3 3 0 010-6h6.3"/></symbol>
<symbol id="i-gps" viewBox="0 0 24 24"><circle cx="12" cy="12" r="6.5"/><circle cx="12" cy="12" r="1.6" fill="currentColor" stroke="none"/><path d="M12 2v3M12 19v3M2 12h3M19 12h3"/></symbol>
<symbol id="i-gps-off" viewBox="0 0 24 24"><path d="M4 4l16 16"/><path d="M12 5.5a6.5 6.5 0 016.5 6.5M12 2v3M2 12h3M19 12h3M12 19v3"/><circle cx="12" cy="12" r="2"/></symbol>
<symbol id="i-person" viewBox="0 0 24 24"><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4 3.6-6.5 8-6.5S20 17 20 21"/></symbol>
<symbol id="i-calendar" viewBox="0 0 24 24"><rect x="3.5" y="5" width="17" height="15.5" rx="2.5"/><path d="M3.5 10h17M8 3v4M16 3v4"/></symbol>
<symbol id="i-home" viewBox="0 0 24 24"><path d="M4 11l8-7 8 7v8.5a1.5 1.5 0 01-1.5 1.5H14v-6h-4v6H5.5A1.5 1.5 0 014 19.5z"/></symbol>
<symbol id="i-more" viewBox="0 0 24 24"><circle cx="5" cy="12" r="1.6" fill="currentColor" stroke="none"/><circle cx="12" cy="12" r="1.6" fill="currentColor" stroke="none"/><circle cx="19" cy="12" r="1.6" fill="currentColor" stroke="none"/></symbol>
<symbol id="i-settings" viewBox="0 0 24 24"><circle cx="12" cy="12" r="3"/><path d="M12 2.5v3M12 18.5v3M2.5 12h3M18.5 12h3M5.3 5.3l2.1 2.1M16.6 16.6l2.1 2.1M18.7 5.3l-2.1 2.1M7.4 16.6l-2.1 2.1"/></symbol>
<symbol id="i-refresh" viewBox="0 0 24 24"><path d="M20 12a8 8 0 10-2.4 5.7"/><path d="M20 4v6h-6"/></symbol>
<symbol id="i-cloud-off" viewBox="0 0 24 24"><path d="M4 4l16 16"/><path d="M7 18h9a4 4 0 001-7.9A6 6 0 008.6 7M6.2 10.3A4.5 4.5 0 007 18"/></symbol>
<symbol id="i-loc-off" viewBox="0 0 24 24"><path d="M4 4l16 16"/><path d="M12 21s7-6 7-11a7 7 0 00-11.2-5.6M8.4 6.4A7 7 0 005 10c0 5 7 11 7 11"/></symbol>
<symbol id="i-search-off" viewBox="0 0 24 24"><circle cx="10.5" cy="10.5" r="6.5"/><path d="M15.3 15.3L21 21M4 4l16 16"/></symbol>
<symbol id="i-fullscreen" viewBox="0 0 24 24"><path d="M4 9V4h5M20 9V4h-5M4 15v5h5M20 15v5h-5"/></symbol>
<symbol id="i-locate" viewBox="0 0 24 24"><circle cx="12" cy="12" r="3"/><circle cx="12" cy="12" r="7"/><path d="M12 2v3M12 19v3M2 12h3M19 12h3"/></symbol>
<symbol id="i-info" viewBox="0 0 24 24"><circle cx="12" cy="12" r="9"/><path d="M12 11v6M12 7.5v.5"/></symbol>
<symbol id="i-logout" viewBox="0 0 24 24"><path d="M14 4H5v16h9M10 12h11M18 8l4 4-4 4"/></symbol>
<symbol id="i-edit" viewBox="0 0 24 24"><path d="M4 20h4L20 8l-4-4L4 16z"/><path d="M14 6l4 4"/></symbol>
<symbol id="i-bell" viewBox="0 0 24 24"><path d="M6 9a6 6 0 0112 0c0 5 2 6 2 6H4s2-1 2-6"/><path d="M10 19a2 2 0 004 0"/></symbol>
<symbol id="i-close" viewBox="0 0 24 24"><path d="M6 6l12 12M18 6L6 18"/></symbol>
<symbol id="i-trash" viewBox="0 0 24 24"><path d="M4 7h16M9 7V4h6v3M6 7l1 14h10l1-14"/></symbol>
<symbol id="i-alert" viewBox="0 0 24 24"><path d="M12 3l9.5 17H2.5z"/><path d="M12 9v5M12 17.2v.3"/></symbol>
<symbol id="i-clock" viewBox="0 0 24 24"><circle cx="12" cy="12" r="9"/><path d="M12 7v5.4l3.4 2"/></symbol>
<symbol id="i-flag" viewBox="0 0 24 24"><path d="M6 21V4M6 5h11l-2 3.5 2 3.5H6"/></symbol>
<symbol id="i-trend" viewBox="0 0 24 24"><path d="M3 17l6-6 4 4 8-8"/><path d="M15 7h6v6"/></symbol>
<symbol id="i-puffin" viewBox="0 0 24 24"><path d="M7 20c-1.5-3-1.5-8 1-11.5S14 4 16 5.5c2.2 1.6 1.4 5 .2 7.6-1.4 3-4.2 5.4-9.2 6.9z"/><circle cx="14.4" cy="9.2" r=".9" fill="currentColor" stroke="none"/><path d="M17.5 10.5l3-1.2-2.8 2.6"/></symbol>
</defs></svg>`;

const NAV = [
  ["index.html", "跑步页"],
  ["result.html", "跑步结果"],
  ["plan.html", "训练计划"],
  ["profile.html", "我的 / Coros"],
];

function statusBar(el) {
  const time = el.dataset.time || "9:41";
  el.innerHTML = `<span>${time}</span>
    <span class="right">
      <span class="sig"><i></i><i></i><i></i><i></i></span>
      <span style="font-size:10px;font-weight:600;letter-spacing:.4px">5G</span>
      <span class="batt"></span>
    </span>`;
}

function init() {
  const holder = document.createElement("div");
  holder.innerHTML = SPRITE;
  document.body.insertBefore(holder.firstElementChild, document.body.firstChild);

  document.querySelectorAll(".sbar").forEach(statusBar);
  document.querySelectorAll(".home-ind").forEach((el) => {
    if (!el.querySelector("i")) el.innerHTML = "<i></i>";
  });

  const topbar = document.getElementById("topbar");
  if (topbar) {
    const page = location.pathname.split("/").pop() || "index.html";
    topbar.outerHTML = `<header class="topbar">
      <a class="brand-mark" href="index.html" style="text-decoration:none;color:inherit">
        <span class="logo"><svg class="ic s20"><use href="#i-puffin"/></svg></span>
        步凡 · 迭代 1 设计原型
      </a>
      <nav>${NAV.map(([href, label]) => `<a href="${href}" class="${href === page ? "on" : ""}">${label}</a>`).join("")}</nav>
      <button class="theme-btn" id="themeBtn">切换深色</button>
    </header>`;
  }

  const root = document.documentElement;
  const saved = localStorage.getItem("bp-theme");
  if (saved) root.dataset.theme = saved;
  const btn = document.getElementById("themeBtn");
  const sync = () => {
    if (btn) btn.textContent = root.dataset.theme === "dark" ? "切换浅色" : "切换深色";
  };
  sync();
  if (btn) {
    btn.addEventListener("click", () => {
      root.dataset.theme = root.dataset.theme === "dark" ? "light" : "dark";
      localStorage.setItem("bp-theme", root.dataset.theme);
      sync();
    });
  }
}

document.addEventListener("DOMContentLoaded", init);
