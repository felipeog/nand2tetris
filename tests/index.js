const { execSync } = require("child_process");
const path = require("path");
const glob = require("glob");
const cliProgress = require("cli-progress");

function logResults(results) {
  for (let index = 0; index < results.length; index++) {
    const testPath = results[index];
    const testName = testPath.match(/\w+\.tst/gi)[0];

    console.log(testName);
  }
}

function tests() {
  const testsGlobPattern = path.resolve(__dirname, "../projects/**/*.tst");
  const testsPaths = glob.sync(testsGlobPattern);
  const progressBar = new cliProgress.SingleBar();
  const results = {
    success: [],
    fail: [],
  };

  progressBar.start(testsPaths.length, 0);

  for (let index = 0; index < testsPaths.length; index++) {
    progressBar.update(index + 1);

    const testPath = testsPaths[index];
    const testResult = execSync(`npm run hdl-js -- --script ${testPath}`, {
      encoding: "utf-8",
    });

    if (testResult.includes("✓ Script executed successfully!")) {
      results.success.push(testPath);
    } else {
      results.fail.push(testPath);
    }
  }

  progressBar.stop();

  console.log("\n- Success: ");
  logResults(results.success);

  console.log("\n- Fail: ");
  logResults(results.fail);
}

tests();
