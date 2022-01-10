const deploy = async () => {
  const [deployer] = await ethers.getSigners();

  console.log('Deploying contract with account: ', deployer.address);

  const CryptoCities = await ethers.getContractFactory('CryptoCities');
  const deployed = await CryptoCities.deploy(00);

  console.log('The contract is deployed at: ', deployed.address);
};

deploy()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
