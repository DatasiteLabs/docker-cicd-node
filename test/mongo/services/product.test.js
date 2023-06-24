const {connect, clearDatabase, closeDatabase} = require("../util/db-handler");
const productService = require("./product");

beforeAll(async () => await connect());
afterEach(async () => await clearDatabase());
afterAll(async () => {
  await closeDatabase();
});

/**
 * Product test suite.
 */
describe("product ", () => {
  /**
   * Tests that a valid product can be created through the productService without throwing any errors.
   */
  it("can be created correctly", async () => {
    expect(
      await (async () => await productService.create(productComplete))
    // @ts-ignore
    ).not.toThrow();
  });
});

/**
 * Complete product example.
 */
const productComplete = {
  name: "iPhone 11",
  price: 699,
  description:
    "A new dual‑camera system captures more of what you see and love. ",
};
