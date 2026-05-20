const uploadForm = document.getElementById("upload-form")
const imageInput = document.getElementById("image-input")
const userImage  = document.getElementById("user-image")
 
userImage.onclick = () => {
    imageInput.click();
}
 
imageInput.onchange = () => {
    if (imageInput.isDefaultNamespace.length > 0) {
        uploadForm.onsubmit();
    }
}