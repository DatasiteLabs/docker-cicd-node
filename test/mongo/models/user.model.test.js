const User = require('./user.model');
const { fakeUserData } = require('../database/fixtures');
const {
  validateNotEmpty,
  validateStringEquality,
  validateMongoDuplicationError,
} = require('../util/test-validators.utils');
const dbHandler = require('../util/db-handler');

beforeAll(async () => {
  await dbHandler.connect();
  await dbHandler.clearDatabase();
});
// afterEach(async () => await dbHandler.clearDatabase());
afterAll(async () => await dbHandler.closeDatabase());

describe('User Model Test Suite', () => {
  test('should validate saving a new student user successfully', async () => {
    const validStudentUser = new User({
      local: fakeUserData,
      role: fakeUserData.role,
    });
    const savedStudentUser = await validStudentUser.save();

    validateNotEmpty(savedStudentUser);

    if (!savedStudentUser.local) {
      throw new Error('local is not defined');
    }

    validateStringEquality(savedStudentUser.role, fakeUserData.role);
    validateStringEquality(savedStudentUser.local.email, fakeUserData.email);
    validateStringEquality(
      savedStudentUser.local.username,
      fakeUserData.username
    );
    validateStringEquality(
      savedStudentUser.local.password,
      fakeUserData.password
    );
    validateStringEquality(
      savedStudentUser.local.firstName,
      fakeUserData.firstName
    );
    validateStringEquality(
      savedStudentUser.local.lastName,
      fakeUserData.lastName
    );
  });

  test('should validate MongoError duplicate error with code 11000', async () => {
    expect.assertions(4);
    const validStudentUser = new User({
      local: fakeUserData,
      role: fakeUserData.role,
    });

    try {
      await validStudentUser.save();
    } catch (error) {
      const { name, code } = error;
      validateMongoDuplicationError(name, code);
    }
  });
});
