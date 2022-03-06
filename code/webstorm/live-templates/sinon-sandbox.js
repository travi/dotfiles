// sandbox: sinon sandbox
let sandbox;

setup(() => {
  sandbox = sinon.createSandbox();

  sandbox.stub($END$);
});

teardown(() => sandbox.restore());