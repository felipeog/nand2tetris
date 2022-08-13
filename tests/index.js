const { execSync } = require("child_process");
const path = require("path");
const glob = require("glob");

function tests() {
  const testsGlobPattern = path.resolve(__dirname, "../projects/**/*.tst");
  const testsPaths = glob.sync(testsGlobPattern);
  let failCount = 0;

  console.log(`${testsPaths.length} tests`);

  for (let index = 0; index < testsPaths.length; index++) {
    const testPath = testsPaths[index];
    const result = execSync(`npm run hdl-js -- --script ${testPath}`, {
      encoding: "utf-8",
    });

    console.log(`\n${index + 1}/${testsPaths.length}: ${testPath}`);

    if (!result.includes("✓ Script executed successfully!")) {
      failCount += 1;

      console.log("> Fail");

      continue;
    }

    console.log("> Success");
  }

  console.log(
    `\nSuccess: ${testsPaths.length - failCount}; Fail: ${failCount}`
  );
}

tests();
