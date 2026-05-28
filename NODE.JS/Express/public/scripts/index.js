const uploadForm = document.getElementById("upload-form");
const imageInput = document.getElementById("image-input");
const userImage = document.getElementById("user-image");
const bgForm = document.getElementById("bg-form");
const bgInput = document.getElementById("bg-input");
const bgButton = document.getElementById("bg-button");

userImage.onclick = () => {
    imageInput.click();
}

imageInput.onchange = () => {
    if (imageInput.files.length > 0) {
        uploadForm.submit();
    }
}

bgButton.onclick = () => {
    bgInput.click();
}

bgInput.onchange = () => {
    if (bgInput.files.length > 0) {
        bgForm.submit();
    }
}