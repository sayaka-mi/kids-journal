document.addEventListener('turbo:load', () => {
  const input = document.getElementById('tag-search');
  if (!input) return;
  const suggestions = document.getElementById('tag-suggestions');
  const selectedTags = document.getElementById('selected-tags');

  let selectedTagIds = new Set();
  let selectedNewTagNames = new Set();

  document.querySelectorAll('input[name="record[tag_ids][]"]').forEach(input => {
    const id = parseInt(input.value, 10);
    if (!isNaN(id)) {
      selectedTagIds.add(id);
    }
  });

  document.querySelectorAll('input[name="new_tags[]"]').forEach(input => {
    const name = input.value.trim();
    if (name) {
      selectedNewTagNames.add(name);
    }
  });

  input.addEventListener('input', async () => {
    const keyword = input.value.trim();

    if (!keyword) {
      suggestions.innerHTML = '';
      return;
    }

    const response = await fetch(`/tags?keyword=${encodeURIComponent(keyword)}`);
    const tags = await response.json();

    suggestions.innerHTML = '';

    const filteredTags = tags.filter(tag => !selectedTagIds.has(tag.id) && !selectedNewTagNames.has(tag.name));

    filteredTags.forEach(tag => {
      const div = document.createElement('div');
      div.textContent = tag.name;
      div.classList.add('suggestion-item');
      div.dataset.id = tag.id;
      div.dataset.name = tag.name;

      div.addEventListener('click', () => {
        addTag(tag.id, tag.name);
        suggestions.innerHTML = '';
        input.value = '';
      });

      suggestions.appendChild(div);
    });
  });

  input.addEventListener('keydown', (e) => {
    if (e.key === 'Enter' || e.key === ',') {
      e.preventDefault();
      const tagName = input.value.trim();
      if (tagName) {
        addTag(null, tagName);
        suggestions.innerHTML = '';
        input.value = '';
      } else {
        alert('タグを入力してください！');
      }
    }
  });

  function addTag(id, name) {

    if (id !== null && selectedTagIds.has(id)) return;

    if (id === null && selectedNewTagNames.has(name)) return;

    if (id !== null) {
      selectedTagIds.add(id);
    } else {
      selectedNewTagNames.add(name);
    }

    const tagElem = document.createElement('span');
    tagElem.classList.add('selected-tag');
    tagElem.textContent = '#' + name;

    const removeBtn = document.createElement('button');
    removeBtn.type = 'button';
    removeBtn.textContent = '×';
    removeBtn.classList.add('tag-remove-button');
    removeBtn.addEventListener('click', () => {
      selectedTags.removeChild(tagElem);
      if (id !== null) {
        selectedTagIds.delete(id);
        const hiddenInput = document.querySelector(`input[name="record[tag_ids][]"][value="${id}"]`);
        if (hiddenInput) hiddenInput.remove();
      } else {
        selectedNewTagNames.delete(name);
        const hiddenInput = document.querySelector(`input[name="new_tags[]"][value="${name}"]`);
        if (hiddenInput) hiddenInput.remove();
      }
    });

    tagElem.appendChild(removeBtn);
    selectedTags.appendChild(tagElem);

    const hiddenInput = document.createElement('input');
    hiddenInput.type = 'hidden';
    if (id !== null) {
      hiddenInput.name = 'record[tag_ids][]';
      hiddenInput.value = id;
    } else {
      hiddenInput.name = 'new_tags[]';
      hiddenInput.value = name;
    }
    document.querySelector('.record-form').appendChild(hiddenInput);
  }
});