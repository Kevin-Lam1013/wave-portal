const hre = require("hardhat");

const main = async () => {
  const [deployer] = await hre.ethers.getSigners();
  const accountBalance = await deployer.provider.getBalance(deployer.address);

  console.log(
    "Deploying contracts with account: ",
    await deployer.getAddress()
  );
  console.log("Account balance: ", accountBalance.toString());

  const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
  const waveContract = await waveContractFactory.deploy({
    value: hre.ethers.parseEther("0.001"),
  });
  await waveContract.waitForDeployment();

  console.log("WavePortal address: ", await waveContract.getAddress());
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();
