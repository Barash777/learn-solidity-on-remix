import { loadFixture, ethers, expect } from "./setup";

describe("Payments contract", () => {
  async function deploy() {
    const [user1, user2] = await ethers.getSigners();

    const Factory = await ethers.getContractFactory("Payments");
    const payments = await Factory.deploy();
    await payments.waitForDeployment();

    return { user1, user2, payments };
  }

  it("should be deplyed", async () => {
    const { payments } = await loadFixture(deploy);

    // console.log(user1.address);
    // console.log(payments.target);
    // console.log(await payments.getAddress());

    expect(payments.target).to.be.properAddress;
  });

  it("should have 0 ETH by default", async () => {
    const { payments } = await loadFixture(deploy);

    expect(await payments.currentBalance()).to.eq(0);
    expect(await ethers.provider.getBalance(payments.target)).to.be.eq(0);
  });

  it("should be possible to send funds", async () => {
    const { user1, user2, payments } = await loadFixture(deploy);

    const sum = 100; // wei
    const msg = "hellow form hh";

    await payments.pay(msg, { value: sum });

    const contractBalance = await ethers.provider.getBalance(payments.target);
    const user1Balance = await ethers.provider.getBalance(user1.address);
    const user2Balance = await ethers.provider.getBalance(user2.address);

    expect(contractBalance).to.be.eq(100);
    expect(user1Balance).to.be.lessThan(10000000000000000000000n);
    expect(user2Balance).to.be.eq(10000000000000000000000n);
  });

  it("should be paid by user2", async () => {
    const { user1, user2, payments } = await loadFixture(deploy);

    const sum = 100; // wei
    const msg = "hellow form hh";

    await payments.connect(user2).pay(msg, { value: sum });

    const contractBalance = await ethers.provider.getBalance(payments.target);
    const user1Balance = await ethers.provider.getBalance(user1.address);
    const user2Balance = await ethers.provider.getBalance(user2.address);

    expect(contractBalance).to.be.eq(100);
    expect(user2Balance).to.be.lessThan(10000000000000000000000n);
    expect(user1Balance).to.be.lessThan(10000000000000000000000n);
  });
});
