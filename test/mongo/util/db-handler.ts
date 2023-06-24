import mongoose from "mongoose";
import { config } from "../../config";
import { MongoMemoryServer } from "mongodb-memory-server";

/**
 * Connect to the in-memory database.
 */
const connect = async () => {
  if (config.Memory) {
    // Config to decided if an mongodb-memory-server instance should be used
    // it's needed in global space, because we don't want to create a new instance every test-suite
    const instance = await MongoMemoryServer.create();
    const uri = instance.getUri();
    console.log(uri);

    (global as any).__MONGOINSTANCE = instance;
    process.env.MONGO_URI = uri.slice(0, uri.lastIndexOf("/"));
  } else {
    process.env.MONGO_URI = `mongodb://${config.IP}:${config.Port}`;
  }

  try {
    await mongoose.connect(`${process.env.MONGO_URI}/${config.Database}`, {});
    await mongoose.connection.dropDatabase();
  } catch (error) {
    console.error(error);
  }
};

/**
 * Drop database, close the connection and stop mongod.
 */
const closeDatabase = async () => {
    await mongoose.connection.close();
    if (config.Memory) { // Config to decided if an mongodb-memory-server instance should be used
      const instance: MongoMemoryServer = (global as any).__MONGOINSTANCE;
      await instance.stop();
    }
};

/**
 * Remove all the data for all db collections.
 */
const clearDatabase = async () => {
  const collections = (await mongoose.connection.asPromise()).collections;

  for (const key in collections) {
    const collection = collections[key];
    await collection.deleteMany();
  }
};

export { clearDatabase, closeDatabase, connect };
