const mongoose = require('mongoose');

const dbHandler = require('../util/db-handler');
const productService = require('./product');
const productModel = require('../models/product');

beforeAll(async () => await dbHandler.connect());
afterEach(async () => await dbHandler.clearDatabase());
afterAll(async () => await dbHandler.closeDatabase());

/**
 * Product test suite.
 */
describe('product ', () => {

    /**
     * Tests that a valid product can be created through the productService without throwing any errors.
     */
    it('can be created correctly', async () => {
        expect(async () => await productService.create(productComplete))
            .not
            .toThrow();
    });
});

/**
 * Complete product example.
 */
const productComplete = {
    name: 'iPhone 11',
    price: 699,
    description: 'A new dual‑camera system captures more of what you see and love. '
};