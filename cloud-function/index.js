const functions = require('@google-cloud/functions-framework');

functions.http('helloWorld', (req, res) => {
  console.log("Hello World!");
  res.send('Hello World!');
});