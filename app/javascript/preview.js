document.addEventListener('turbo:load', () => {
  const addBtn = document.getElementById('add_image_input_button');
  const container = document.getElementById('image_inputs_container');
  const previews = document.getElementById('previews');

  if (!addBtn || !container || !previews) return;

  addBtn.addEventListener('click', () => {
    const newInputWrapper = document.createElement('div');
    newInputWrapper.classList.add('image-input-wrapper');

    const newInput = document.createElement('input');
    newInput.type = 'file';
    newInput.name = 'record[images][]';
    newInput.accept = 'image/jpeg,image/png,image/gif,video/mp4,video/quicktime';
    newInput.capture = 'environment';

    newInputWrapper.appendChild(newInput);
    container.appendChild(newInputWrapper);
  });

  container.addEventListener('change', (e) => {
    if (!e.target.matches('input[type="file"]')) return;

    const files = e.target.files;
    if (files.length === 0)return;

    for (const file of files) {
      const url = URL.createObjectURL(file);

      if (file.type.startsWith('image/')) {
        const img = document.createElement('img');
        img.src = url;
        img.style.maxWidth = '200px';
        img.style.margin = '5px';
        previews.appendChild(img);
      }
      else if (file.type.startsWith('video/')) {
        const video = document.createElement('video');
        video.src = url;
        video.controls = true;
        video.style.maxWidth = '200px';
        video.style.margin = '5px';
        previews.appendChild(video);
      }
    }
  });
});