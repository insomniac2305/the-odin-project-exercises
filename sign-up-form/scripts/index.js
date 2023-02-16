const firstname = document.getElementById("firstname");
const lastname = document.getElementById("lastname");
const email = document.getElementById("email");
const phone = document.getElementById("phone");
const country = document.getElementById("country");
const postalcode = document.getElementById("postalcode");
const password = document.getElementById("password");
const passwordRepeat = document.getElementById("password-repeat");

const inputs = [];
inputs.push(firstname, lastname, email, phone, country, postalcode, password, passwordRepeat);

inputs.forEach(input => {
  input.addEventListener("focusout", () => {
    input.classList.add("validate");
    const message = input.parentElement.querySelector(".error-message");
    message.innerText = input.validationMessage;
  })
});