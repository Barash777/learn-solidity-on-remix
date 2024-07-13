import { loadFixture, ethers, expect } from './setup';

describe('Payments contract', () => {
  async function deploy() {
    const [user1, user2] = await ethers.getSigners();

    const Factory = await ethers.getContractFactory('Payments');
    const payments = await Factory.deploy();
    await payments.waitForDeployment();

    return { user1, user2, payments };
  }

  it('should be deplyed', async () => {
    const { payments } = await loadFixture(deploy);

    // console.log(user1.address);
    // console.log(payments.target);
    // console.log(await payments.getAddress());

    expect(payments.target).to.be.properAddress;
  });

  it('should have 0 ETH by default', async () => {
    const { payments } = await loadFixture(deploy);

    expect(await payments.currentBalance()).to.eq(0);
    expect(await ethers.provider.getBalance(payments.target)).to.be.eq(0);
  });

  it('should be possible to send funds', async () => {
    const { user1, payments } = await loadFixture(deploy);

    const sum = 100; // wei
    const msg = 'hellow form hh';

    await payments.pay(msg, { value: sum });

    const contractBalance = await ethers.provider.getBalance(payments.target);
    const user1Balance = await ethers.provider.getBalance(user1.address);

    await expect(contractBalance).to.be.eq(100);
    await expect(user1Balance).to.be.lessThan(10000000000000000000000n);
  });

  it('should be paid by user2', async () => {
    const { user2, payments } = await loadFixture(deploy);

    const sum = 100; // wei
    const msg = 'hellow form hh';

    const tx = await payments.connect(user2).pay(msg, { value: sum });
    await tx.wait(1);

    await expect(tx).to.changeEtherBalance(user2, -sum);
  });

  it('payments map should be updated after tx', async () => {
    const { user2, payments } = await loadFixture(deploy);

    const sum = 100; // wei
    const msg = 'hellow form hh';

    const tx = await payments.connect(user2).pay(msg, { value: sum });
    await tx.wait(1);

    const currentBlock = await ethers.provider.getBlock(
      await ethers.provider.getBlockNumber()
    );

    const newPayment = await payments.getPayment(user2.address, 0);

    expect(newPayment.message).to.eq(msg);
    expect(newPayment.amount).to.eq(sum);
    expect(newPayment.from).to.eq(user2.address);
    expect(newPayment.timestamp).to.eq(currentBlock?.timestamp);
  });
});
