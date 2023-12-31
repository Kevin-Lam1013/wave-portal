const hre = require("hardhat");

const main = async () => {
  const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
  const waveContract = await waveContractFactory.deploy({
    value: hre.ethers.parseEther("0.1"),
  });

  // used waitForDeployment instead of deployed and getAddress instead of address,
  // because of the current version of @npmicfoundation/hardhat-toolbox
  await waveContract.waitForDeployment();
  console.log("Contract deployed to : ", await waveContract.getAddress());

  // Get contract balance
  let contractBalance = await hre.ethers.provider.getBalance(
    await waveContract.getAddress()
  );
  console.log("Contract balance : ", hre.ethers.formatEther(contractBalance));

  // let waveCount;
  // waveCount = await waveContract.getTotalWaves();
  // console.log(Number(waveCount));

  /**
   * Let's send a few waves!
   */
  let waveTxn = await waveContract.wave("First !");
  await waveTxn.wait();

  let waveTxn2 = await waveContract.wave("Second !");
  await waveTxn2.wait();

  // Get contract balance to see what happened !
  contractBalance = await hre.ethers.provider.getBalance(
    await waveContract.getAddress()
  );
  console.log("Contract balance : ", hre.ethers.formatEther(contractBalance));

  const allWaves = await waveContract.getAllWaves();
  console.log(allWaves);
};

const runMain = async () => {
  // Read more about Node exit ('process.exit(num)') status codes here: https://stackoverflow.com/a/47163396/7974948
  try {
    await main();
    process.exit(0); // exit Node process without error
  } catch (error) {
    console.log(error);
    process.exit(1); // exit Node process while indicating 'Uncaught Fatal Exception' error
  }
};

runMain();
