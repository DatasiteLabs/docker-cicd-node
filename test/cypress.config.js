const { defineConfig } = require("cypress");

module.exports = defineConfig({
  e2e: {
    videoUploadOnPasses: false,
    videoCompression: false,
    setupNodeEvents(on, config) {
      // implement node event listeners here
    },
  },
});
