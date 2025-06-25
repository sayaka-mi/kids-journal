document.addEventListener('turbo:load', () => {
  const input = document.getElementById('tag-search');
  if (!input) return;
  const suggestions = document.getElementById('tag-suggestions');
  const selectedTags = document.getElementById('selected-tags');

  let selectedTagNames = new Set(
    Array.from(selectedTags.querySelectorAll('input[name="tag_names[]"]')).map(input => input.value)
  );

  input.addEventListener('input', async () => {
    const keyword = input.value.trim();
    if (!keyword) {
      suggestions.innerHTML = '';
      return;
    }
    const response = await fetch(`/tags?keyword=${encodeURIComponent(keyword)}`);
    const tags = await response.json();

    suggestions.innerHTML = '';
    const filtered = tags.filter(tag => !selectedTagNames.has(tag.name));

    filtered.forEach(tag => {
      const div = document.createElement('div');
      div.textContent = tag.name;
      div.classList.add('suggestion-item');
      div.addEventListener('click', () => {
        addTag(tag.name);
        suggestions.innerHTML = '';
        input.value = '';
      });
      suggestions.appendChild(div);
    });
  });

  input.addEventListener('keydown', (e) => {
    if (e.key === 'Enter' || e.key === ',' || e.key === ' ' || e.key === '　') {
      e.preventDefault();
      const inputValue = input.value.trim();
      if (!inputValue) return;
      const tags = inputValue.split(/[\s,]+/).filter(tag => tag.length > 0);
      tags.forEach(tag => {
        addTag(tag);
      });
      suggestions.innerHTML = '';
      input.value = '';
    }
  });

  function addTag(name) {
    console.log('addTag called with:', name);
    if (selectedTagNames.has(name)) return;
    selectedTagNames.add(name);

    const span = document.createElement('span');
    span.classList.add('tag-item');
    span.textContent = `#${name}`;

    const btn = document.createElement('button');
    btn.type = 'button';
    btn.classList.add('tag-remove-button');
    btn.textContent = '×';
    btn.addEventListener('click', () => {
      selectedTags.removeChild(span);
      selectedTags.removeChild(hiddenInput);
      selectedTagNames.delete(name);
    });

    span.appendChild(btn);
    selectedTags.appendChild(span);

    const hiddenInput = document.createElement('input');
    hiddenInput.type = 'hidden';
    hiddenInput.name = 'tag_names[]';
    hiddenInput.value = name;
    selectedTags.appendChild(hiddenInput);
  }

  const clearBtn = document.getElementById('clear-search');
  if (!clearBtn) {
    console.error('clearBtn not found');
    return;
  }
  clearBtn.addEventListener('click', () => {
    input.value = '';
    selectedTags.innerHTML = '';
    selectedTagNames.clear();
    const contentInput = document.querySelector('input[name="content"]');
    if (contentInput) contentInput.value = '';
  });
});