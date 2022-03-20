const mongoose = require('mongoose');
const { MongoMemoryServer } = require('mongodb-memory-server');

/**
 * Connect to the in-memory database.
 */
module.exports.connect = async () => {
    const instance = await MongoMemoryServer.create();
    const uri = await instance.getUri();
    __MONGOINSTANCE = instance;
    process.env.MONGO_URI = uri.slice(0, uri.lastIndexOf('/'));

    await mongoose.connect(`${process.env.MONGO_URI}/testdb`, {});
    // await mongoose.connection.db.dropDatabase();
}

/**
 * Drop database, close the connection and stop mongod.
 */
module.exports.closeDatabase = async () => {
    await mongoose.disconnect();

    const instance = __MONGOINSTANCE;
    await instance.stop();
}

/**
 * Remove all the data for all db collections.
 */
module.exports.clearDatabase = async () => {
    // const collections = mongoose.connection.collections;

    // for (const key in collections) {
    //     const collection = collections[key];
    //     await collection.deleteMany();
    // }
    await mongoose.connection.db.dropDatabase();
}