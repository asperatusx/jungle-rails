describe("Product Details", () => {
  beforeEach(() => {
    // Visit the home page before each test
    cy.visit("/");
  });

  it("Navigates to product detail page from home page", () => {
    // Click the first product link
    cy.get(':nth-child(1) > a > img').first().click();

    // Check that the URL includes "/products"
    cy.url().should("include", "/products/");

    // Check that product detail content is displayed
    cy.get(".product-detail").should("be.visible");

    // Check for specific product attributes
    cy.contains("Scented Blade").should("be.visible");
    cy.contains("$24.99").should("be.visible");
  });
});