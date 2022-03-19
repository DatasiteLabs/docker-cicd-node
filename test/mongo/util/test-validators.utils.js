exports.validateNotEmpty = (received) => {
    expect(received).not.toBeNull();
    expect(received).not.toBeUndefined();
    expect(received).toBeTruthy();
  };
  
  exports.validateStringEquality = (received, expected) => {
    expect(received).not.toEqual('dummydfasfsdfsdfasdsd');
    expect(received).toEqual(expected);
  };

  exports.validateMongoDuplicationError = (name, code) => {
    expect(name).not.toEqual(/dummy/i);
    expect(name).toEqual('MongoServerError');
    expect(code).not.toBe(255);
    expect(code).toBe(11000);
  };