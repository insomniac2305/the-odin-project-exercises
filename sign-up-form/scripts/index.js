const firstname = document.getElementById("firstname");
const lastname = document.getElementById("lastname");
const email = document.getElementById("email");
const phone = document.getElementById("phone");
const country = document.getElementById("country");
const postalcode = document.getElementById("postalcode");
const password = document.getElementById("password");
const passwordRepeat = document.getElementById("password-repeat");
const signupForm = document.getElementById("signup-form");
const formSubmitBtn = document.querySelector(".form-submit-wrapper>button");

const validationInputs = [];
validationInputs.push(firstname, lastname, email, phone, country, postalcode, password, passwordRepeat);

function setErrorMessage(input, message) {
  const messageNode = input.parentElement.querySelector(".error-message");
  messageNode.innerText = message;
}

function focusOutValidation(input) {
  input.classList.add("validate");
  if (!input.checkValidity()) {
    setErrorMessage(input, input.validationMessage);
  }
}

function inputValidation(input) {
  if (input.classList.contains("validate")) {
    if (input.checkValidity()) {
      input.classList.remove("validate");
    } else {
      setErrorMessage(input, input.validationMessage);
    }
  }
}

validationInputs.forEach((input) => {
  input.addEventListener("focusout", focusOutValidation.bind(this, input));
  input.addEventListener("input", inputValidation.bind(this, input));
});

function patternValidation(input, errorMessage) {
  if (input.value !== "" && input.validity.patternMismatch) {
    input.setCustomValidity(errorMessage);
  } else {
    input.setCustomValidity("");
  }
}
phone.addEventListener(
  "invalid",
  patternValidation.bind(
    this,
    phone,
    "Only digits, spaces, parentheses, hyphens and an optional plus sign at the start are allowed. Max. three number blocks and 15 digits in total."
  )
);

const postalcodePatterns = {
  DE: {
    regex: "^\\d{5}",
    hint: "Use the following format: 12345",
  },
  US: {
    regex: "^\\d{5}([-]\\d{4})?",
    hint: "Use the following format: 12345[-6789]",
  },
  FR: {
    regex: "^\\d{2}[ ]?\\d{3}",
    hint: "Use the following format: 12 345",
  },
  NL: {
    regex: "^\\d{4}[ ]?[A-Z]{2}",
    hint: "Use the following format: 1234 AB",
  },
};

country.addEventListener("change", () => {
  postalcode.pattern = postalcodePatterns[country.value].regex;
  inputValidation(postalcode);
});

postalcode.addEventListener("invalid", () => {
  patternValidation(postalcode, postalcodePatterns[country.value].hint);
});

postalcode.pattern = postalcodePatterns[country.value].regex;

password.addEventListener(
  "invalid",
  patternValidation.bind(
    this,
    password,
    "Password must contain min. 8 characters out of numbers, lower case and upper case letters"
  )
);

function passwordsMatchValidation(input1, input2) {
  if (input1.value !== "" && input2.value !== "" && input1.validity.valid && input1.value !== input2.value) {
    input2.setCustomValidity("Passwords must match");
  } else {
    input2.setCustomValidity("");
  }
}

passwordRepeat.addEventListener("input", passwordsMatchValidation.bind(this, password, passwordRepeat));

signupForm.addEventListener("submit", (e) => {
  e.preventDefault();
  let formValid = true;
  let firstInvalidInput;

  validationInputs.forEach((input) => {
    formValid = formValid && input.validity.valid;
    focusOutValidation(input);
    if (!formValid && !firstInvalidInput) {
      firstInvalidInput = input;
    }
  });

  if (formValid) {
    const successMessage = document.createElement("div");
    successMessage.innerText = "✅ Success!";
    formSubmitBtn.insertAdjacentElement("afterend", successMessage);
    setTimeout(() => {
      signupForm.reset();
      validationInputs.forEach((input) => input.classList.remove("validate"));
      successMessage.remove();
    }, 5000);
  } else {
    firstInvalidInput.focus();
  }
});
