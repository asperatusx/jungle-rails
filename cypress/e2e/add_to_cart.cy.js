describe("Add to Cart", () => {
  beforeEach(() => {
    // Visit the home page before each test
    cy.visit("/");
  });

  it("There are products on the page", () => {
    cy.visit("/");
    cy.get(".products article").should("be.visible");
  });

  it("will add a product to cart", () => {
    // Check the initial count of cart
    cy.get("a.nav-link").contains("My Cart (0)");

    // Click add button on first product
    cy.get(':nth-child(1) > div > .button_to > .btn').click({force: true})

    // Check that cart count has increased
    cy.get("a.nav-link").contains("My Cart (1)");
  })

})