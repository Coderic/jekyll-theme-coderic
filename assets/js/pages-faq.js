'use strict';

document.addEventListener('DOMContentLoaded', function () {
  var root = document.querySelector('[data-faq-accordion]');
  if (!root) return;

  var items = Array.prototype.slice.call(root.querySelectorAll('[data-faq-item]'));

  function setExpanded(item, expanded) {
    var btn = item.querySelector('[data-faq-button]');
    var panel = item.querySelector('[data-faq-panel]');
    var icon = item.querySelector('[data-faq-icon]');
    if (!btn || !panel) return;
    btn.setAttribute('aria-expanded', expanded ? 'true' : 'false');
    panel.hidden = !expanded;
    if (icon) icon.classList.toggle('rotate-180', expanded);
  }

  items.forEach(function (item, index) {
    var btn = item.querySelector('[data-faq-button]');
    if (!btn) return;

    btn.addEventListener('click', function () {
      var isOpen = btn.getAttribute('aria-expanded') === 'true';
      if (isOpen) {
        setExpanded(item, false);
      } else {
        items.forEach(function (other, j) {
          setExpanded(other, j === index);
        });
      }
    });

    btn.addEventListener('keydown', function (ev) {
      if (ev.key !== 'ArrowDown' && ev.key !== 'ArrowUp') return;
      ev.preventDefault();
      var nextIndex = ev.key === 'ArrowDown' ? index + 1 : index - 1;
      if (nextIndex < 0 || nextIndex >= items.length) return;
      var nextBtn = items[nextIndex].querySelector('[data-faq-button]');
      if (nextBtn) nextBtn.focus();
    });
  });
});
