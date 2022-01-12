const { expect } = require('chai');

describe('CryptoCities Contract', () => {
  const setup = async ({ maxSupply = 10 }) => {
    const [owner] = await ethers.getSigners();
    const CryptoCities = await ethers.getContractFactory('CryptoCities');
    const deployed = await CryptoCities.deploy(maxSupply);

    return {
      owner,
      deployed,
    };
  };

  describe('Deployment', () => {
    it('Sets max supply to passed param', async () => {
      const maxSupply = 8;

      const { deployed } = await setup({ maxSupply });

      const returnedMaxSupply = await deployed.maxSupply();
      expect(maxSupply).to.equal(returnedMaxSupply);
    });
  });

  describe('Minting', () => {
    it('Mints a new token and assigns it to owner.', async () => {
      const { owner, deployed } = await setup({});

      await deployed.mint();

      const ownerOfMinted = await deployed.ownerOf(0);

      expect(ownerOfMinted).to.equal(owner.address);
    });

    it('Has a minting limit.', async () => {
      const maxSupply = 2;

      const { deployed } = await setup({ maxSupply });

      //Mint all
      await Promise.all([deployed.mint(), deployed.mint()]);

      //Assert last minting
      await expect(deployed.mint()).to.be.revertedWith(
        'No CryptoCities left :(.'
      );
    });
  });

  describe('Token URI', () => {
    it('It returns a valid URI', async () => {
      const { deployed } = await setup({});

      const returnedURI = await deployed
        .mint()
        .then(() => deployed.tokenURI(0));

      console.log(returnedURI);
    });
  });
});
