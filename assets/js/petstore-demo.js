'use strict';

(function () {
  var API_BASE = 'https://petstore3.swagger.io/api/v3';

  function readConfig(root) {
    var el = root.querySelector('script[type="application/json"][data-petstore-config]');
    if (!el || !el.textContent.trim()) {
      return { notFound: '', httpError: '' };
    }
    try {
      return JSON.parse(el.textContent);
    } catch (e) {
      return { notFound: '', httpError: '' };
    }
  }

  function initRoot(root) {
    var cfg = readConfig(root);
    var input = root.querySelector('[data-pet-id-input]');
    var btn = root.querySelector('[data-pet-load]');
    var icon = root.querySelector('[data-pet-load-icon]');
    var loadingEl = root.querySelector('[data-pet-loading]');
    var errorEl = root.querySelector('[data-pet-error]');
    var resultEl = root.querySelector('[data-pet-result]');
    var nameEl = root.querySelector('[data-pet-name]');
    var idEl = root.querySelector('[data-pet-id-display]');
    var catRow = root.querySelector('[data-pet-category-row]');
    var catEl = root.querySelector('[data-pet-category]');
    var preEl = root.querySelector('[data-pet-json]');

    function setLoading(on) {
      if (btn) btn.disabled = on;
      if (icon) {
        if (on) icon.classList.add('animate-spin');
        else icon.classList.remove('animate-spin');
      }
      if (loadingEl) loadingEl.hidden = !on;
    }

    function showError(msg) {
      if (!errorEl) return;
      errorEl.textContent = msg || '';
      errorEl.hidden = !msg;
    }

    function clearPet() {
      if (resultEl) resultEl.hidden = true;
      if (nameEl) nameEl.textContent = '';
      if (idEl) idEl.textContent = '';
      if (preEl) preEl.textContent = '';
      if (catRow) catRow.hidden = true;
      if (catEl) catEl.textContent = '';
    }

    function renderPet(pet) {
      if (resultEl) resultEl.hidden = false;
      if (nameEl) nameEl.textContent = pet.name != null ? String(pet.name) : '';
      if (idEl) idEl.textContent = pet.id != null ? String(pet.id) : '';
      if (preEl) preEl.textContent = JSON.stringify(pet, null, 2);
      if (catRow && catEl) {
        var cat = pet.category && pet.category.name;
        if (cat) {
          catRow.hidden = false;
          catEl.textContent = String(cat);
        } else {
          catRow.hidden = true;
        }
      }
    }

    function loadPet() {
      setLoading(true);
      showError('');
      clearPet();

      var raw = input ? input.value : '1';
      var id = parseInt(raw, 10);
      if (!id || id < 1) id = 1;
      if (input) input.value = String(id);

      fetch(API_BASE + '/pet/' + id)
        .then(function (r) {
          if (r.status === 404) {
            showError(cfg.notFound || '');
            return null;
          }
          if (!r.ok) {
            throw new Error((cfg.httpError || 'Request failed') + ' (HTTP ' + r.status + ')');
          }
          return r.json();
        })
        .then(function (pet) {
          if (pet) renderPet(pet);
        })
        .catch(function (e) {
          showError(e.message || cfg.httpError || '');
        })
        .finally(function () {
          setLoading(false);
        });
    }

    if (btn) btn.addEventListener('click', loadPet);
    if (input) {
      input.addEventListener('keydown', function (ev) {
        if (ev.key === 'Enter') {
          ev.preventDefault();
          loadPet();
        }
      });
    }

    loadPet();
  }

  function boot() {
    document.querySelectorAll('[data-petstore-root]').forEach(initRoot);
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', boot);
  } else {
    boot();
  }
})();
