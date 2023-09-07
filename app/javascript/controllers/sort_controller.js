import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["header"];

  sort(event) {
    const column = event.currentTarget.dataset.sortColumn;
    const order = event.currentTarget.dataset.sortOrder;
    const tableBody = this.element.querySelector("tbody");
    const rows = Array.from(tableBody.querySelectorAll("tr"));

    rows.sort((a, b) => {
      const aValue = a.dataset[column];
      const bValue = b.dataset[column];

      if (column === "food") {
        return aValue.localeCompare(bValue);
      } else {
        return parseFloat(aValue) - parseFloat(bValue);
      }
    });

    if (order === "desc") {
      rows.reverse();
    }

    rows.forEach((row) => {
      tableBody.appendChild(row);
    });

    event.currentTarget.dataset.sortOrder = order === "asc" ? "desc" : "asc";
  }
}
