let myLibrary = [];

function Book(title, author, pages, read) {
  this.title = title;
  this.author = author;
  this.pages = pages;
  this.read = read;
  this.info = function () {
    return title + " by " + author + ", " + pages + " pages " + ", " + (read ? "already read" : "not read yet");
  };
}

function addBookToLibrary(title, author, pages, read) {
  const newBook = new Book(title, author, pages, read);
  myLibrary.push(newBook);
}

function displayLibrary() {
  const libraryTable = document.querySelector(".library-table");
  myLibrary.forEach((book) => {
    let tableRow = document.createElement("tr");

    for (const attribute in book) {
      if (Object.hasOwnProperty.call(book, attribute) && typeof book[attribute] != "function") {        
        let tableData = document.createElement("td");
        tableData.innerText = book[attribute];
        tableRow.appendChild(tableData);
      }
    }

    libraryTable.appendChild(tableRow);
  });
}

addBookToLibrary("My Book", "Philipp", 200, false);
addBookToLibrary("The Way", "Karen", 4212, true);
addBookToLibrary("Undercover", "John", 320, false);

displayLibrary();
