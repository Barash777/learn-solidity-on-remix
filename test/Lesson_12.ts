import { loadFixture, ethers, expect } from './setup';

describe('Lesson 12: Interface', () => {
  async function deploy() {
    const [user1, user2] = await ethers.getSigners();

    const Logger = await ethers.getContractFactory('Logger');
    const logger = await Logger.deploy();
    await logger.waitForDeployment();

    const Lesson_12 = await ethers.getContractFactory('Lesson_12');
    const lesson_12 = await Lesson_12.deploy(logger.target);
    await lesson_12.waitForDeployment();

    return { user1, user2, logger, lesson_12 };
  }

  it('should be deplyed', async () => {
    const { lesson_12 } = await loadFixture(deploy);

    expect(lesson_12.target).to.be.properAddress;
  });

  it('allows to pay and get payment info', async () => {
    const { user1, lesson_12 } = await loadFixture(deploy);

    const sum = 100; // wei

    const txData = {
      value: sum,
      to: lesson_12.target,
    };

    const tx = await user1.sendTransaction(txData);
    await tx.wait(1);

    const contractBalance = await ethers.provider.getBalance(lesson_12.target);
    expect(contractBalance).to.be.eq(sum);

    const amount = await lesson_12.getPayment(user1.address, 0);
    expect(amount).to.be.eq(sum);
  });
});

describe('Lesson 12: Library', () => {
  async function deploy() {
    const [user1, user2] = await ethers.getSigners();

    const Factory = await ethers.getContractFactory('LibDemo');
    const libDemo = await Factory.deploy();
    await libDemo.waitForDeployment();

    return { user1, user2, libDemo };
  }

  it('should be deplyed', async () => {
    const { libDemo } = await loadFixture(deploy);

    expect(libDemo.target).to.be.properAddress;
  });

  it('compares strings', async () => {
    const { libDemo } = await loadFixture(deploy);

    expect(await libDemo.compareStrings('1zxcv', '2qwe')).to.be.false;
    expect(await libDemo.compareStrings('Alex', 'Alex')).to.be.true;
  });

  it('find uint element in array', async () => {
    const { libDemo } = await loadFixture(deploy);

    expect(await libDemo.findElement([1, 2, 3], 5)).to.be.false;
    expect(await libDemo.findElement([1, 2, 3], 2)).to.be.true;
  });
});
