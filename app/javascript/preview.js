document.addEventListener('turbo:load', () => {
  const addBtn = document.getElementById('add_image_input_button');
  const container = document.getElementById('image_inputs_container');
  const previews = document.getElementById('previews');

  if (!addBtn || !container || !previews) return;

  const imageLimit = 5;

  let fileInputs = [];

  function createFileInput() {
    const wrapper = document.createElement('div');
    wrapper.classList.add('image-input-wrapper');

    const input = document.createElement('input');
    input.type = 'file';
    input.name = 'record[images][]';
    input.accept = 'image/jpeg,image/png,image/gif,video/mp4,video/quicktime';
    input.multiple = true;
    input.classList.add('image-input');

    wrapper.appendChild(input);
    container.appendChild(wrapper);

    input.addEventListener('change', updatePreviews);

    fileInputs.push({wrapper, input});
  }

  if (container.querySelectorAll('input[type="file"]').length === 0) {
    createFileInput();
  } else {
    container.querySelectorAll('input[type="file"]').forEach(input => {
      fileInputs.push({wrapper: input.parentElement, input});
      input.addEventListener('change', updatePreviews);
    });
  }

  addBtn.addEventListener('click', () => {
    createFileInput();
  });

  function updatePreviews() {
    previews.innerHTML = '';

    let totalFilesCount = 0;

    fileInputs.forEach(({wrapper, input}, inputIndex) => {
      const files = input.files;
      if (!files) return;

      Array.from(files).forEach((file, fileIndex) => {
        totalFilesCount++;

        if (totalFilesCount > imageLimit) return;

        const url = URL.createObjectURL(file);

        const previewWrapper = document.createElement('div');
        previewWrapper.classList.add('preview-thumbnail-wrapper');
        previewWrapper.setAttribute('data-input-index', inputIndex);
        previewWrapper.setAttribute('data-file-index', fileIndex);

        if (file.type.startsWith('image/')) {
          const img = document.createElement('img');
          img.src = url;
          img.classList.add('preview-thumbnail');
          previewWrapper.appendChild(img);
        } else if (file.type.startsWith('video/')) {
          const video = document.createElement('video');
          video.src = url;
          video.controls = true;
          video.classList.add('preview-thumbnail');
          previewWrapper.appendChild(video);
        }

        const removeBtn = document.createElement('button');
        removeBtn.type = 'button';
        removeBtn.textContent = '✖';
        removeBtn.classList.add('small-close-button');

        removeBtn.addEventListener('click', () => {
          input.value = '';
          updatePreviews();
        });

        previewWrapper.appendChild(removeBtn);
        previews.appendChild(previewWrapper);
      });
    });

  }
});