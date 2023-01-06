const myLibrary = [];

const newBookForm = document.getElementById("new-book-form");
const newBookButton = document.getElementById("new-book-button");
const titleInput = document.getElementById("title");
const authorInput = document.getElementById("author");
const pagesInput = document.getElementById("pages");
const readInput = document.getElementById("read");

function Book(title, author, pages, read) {
  this.title = title;
  this.author = author;
  this.pages = pages;
  this.read = read;
  this.toggleRead = () => {
    this.read = !this.read;
  };
}

function addBookToLibrary(title, author, pages, read) {
  const newBook = new Book(title, author, pages, read);
  myLibrary.push(newBook);
}

function displayLibrary() {
  const libraryTable = document.querySelector(".library-table");
  document.querySelectorAll("table tr:not(:first-child)").forEach((row) => row.remove());

  myLibrary.forEach((book) => {
    const tableRow = document.createElement("tr");

    ["title", "author", "pages", "read"].forEach((attribute) => {
      const tableData = document.createElement("td");

      if (typeof book[attribute] === "boolean") {
        const checkbox = document.createElement("input");
        checkbox.type = "checkbox";
        checkbox.checked = book[attribute];
        checkbox.addEventListener("click", () => book.toggleRead());
        tableData.appendChild(checkbox);
      } else {
        tableData.innerText = book[attribute];
      }

      tableRow.appendChild(tableData);
    });

    // eslint-disable-next-line no-use-before-define
    tableRow.appendChild(createRemoveColumn(myLibrary.indexOf(book)));
    libraryTable.appendChild(tableRow);
  });
}

function createRemoveColumn(bookIndex) {
  const column = document.createElement("td");
  const button = document.createElement("button");

  button.type = "button";
  button.innerText = "❌";

  button.addEventListener("click", (e) => {
    myLibrary.splice(bookIndex, 1);
    displayLibrary();
  });

  column.appendChild(button);
  return column;
}

function submitNewBook(e) {
  e.preventDefault();
  addBookToLibrary(titleInput.value, authorInput.value, pagesInput.value, readInput.checked);
  newBookForm.reset();
  newBookForm.hidden = true;
  displayLibrary();
}

newBookButton.addEventListener("click", () => {
  newBookForm.hidden = !newBookForm.hidden;
});
newBookForm.addEventListener("submit", submitNewBook);

addBookToLibrary("My Book", "Philipp", 200, false);
addBookToLibrary("The Way", "Karen", 4212, true);
addBookToLibrary("Undercover", "John", 320, false);

displayLibrary();
