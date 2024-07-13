import { loadFixture, ethers, expect } from './setup';

describe('Lesson7Contract', () => {
  async function deploy() {
    const [user1, user2] = await ethers.getSigners();

    const Factory = await ethers.getContractFactory('Lesson7Contract');
    const Lesson7Contract = await Factory.deploy();
    await Lesson7Contract.waitForDeployment();

    return { user1, user2, Lesson7Contract };
  }

  // async function sendMoney(_toAddress: any, sender: any) {
  //   const amount = 100;
  //   const txData = {
  //     to: _toAddress,
  //     value: amount,
  //   };

  //   const tx = await sender.provider.sendTransaction(txData);
  //   await tx.wait(1);

  //   return [tx, amount];
  // }

  it('should be deployed', async () => {
    const { Lesson7Contract } = await loadFixture(deploy);

    expect(Lesson7Contract.target).to.be.properAddress;
  });

  it('should allow to send money', async () => {
    const { Lesson7Contract, user1, user2 } = await loadFixture(deploy);

    const amount = 123;
    const tx = await Lesson7Contract.pay({ value: amount });
    await tx.wait(1);

    const currentBlock = await ethers.provider.getBlock(
      await ethers.provider.getBlockNumber()
    );

    const contractBalance = await ethers.provider.getBalance(
      Lesson7Contract.target
    );

    expect(contractBalance).to.be.eq(amount);
    expect(tx).to.changeEtherBalance(user1, -amount);
    await expect(tx)
      .emit(Lesson7Contract, 'Paid')
      .withArgs(user1.address, amount, currentBlock?.timestamp);
  });

  it('should allow owner to withdraw money', async () => {
    const { Lesson7Contract, user1, user2 } = await loadFixture(deploy);

    const amount = 123;
    const tx = await Lesson7Contract.connect(user2).pay({ value: amount });
    await tx.wait(1);

    const withdraw = await Lesson7Contract.withdraw(user1.address);
    await withdraw.wait(1);

    await expect(withdraw).to.changeEtherBalances(
      [user1.address, Lesson7Contract.target],
      [amount, -amount]
    );
  });

  it('should NOT allow owner to withdraw money', async () => {
    const { Lesson7Contract, user2 } = await loadFixture(deploy);

    const amount = 123;
    const tx = await Lesson7Contract.pay({ value: amount });
    await tx.wait(1);

    await expect(
      Lesson7Contract.connect(user2).withdraw(user2.address)
    ).to.be.revertedWith('you are not an owner!');
  });
});
