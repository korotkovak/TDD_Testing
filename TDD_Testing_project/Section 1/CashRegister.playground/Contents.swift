
import XCTest

class CashRegister {

    var availableFunds: Decimal
    var transactionTotal: Decimal = 0

    init(availableFunds: Decimal) {
        self.availableFunds = availableFunds
    }

    func addItem(_ cost: Decimal) {
        transactionTotal += cost
    }

    func acceptCashPayment(_ cash: Decimal) {
        transactionTotal -= cash
        availableFunds += cash
    }

}

class CashRegisterTests: XCTestCase {

    var availableFunds: Decimal!
    var sut: CashRegister!
    var itemCost: Decimal!
    var payment: Decimal!

    override func setUp() {
        super.setUp()
        availableFunds = 100
        sut = CashRegister(availableFunds: availableFunds)
        itemCost = 42
        payment = 40
    }

    override func tearDown() {
        availableFunds = nil
        sut = nil
        itemCost = nil
        payment = nil
        super.tearDown()
    }

    func testInitAvailableFunds_setsAvailableFunds() {
        XCTAssertEqual(sut.availableFunds, availableFunds)
    }

    func testAddItem_oneItem_addsCostToTransactionTotal() {
        // given

        // when
        sut.addItem(itemCost)

        // then
        XCTAssertEqual(sut.transactionTotal, itemCost)
    }

    func testAddItem_twoItems_addsCostsToTransactionTotal() {
        // given
        let itemCost2 = Decimal(40)
        let expectedTotal = itemCost + itemCost2

        // when
        sut.addItem(itemCost)
        sut.addItem(itemCost2)

        // then
        XCTAssertEqual(sut.transactionTotal, expectedTotal)
    }

    func testAcceptCashPayment_subtractsPaymentFromTransactionTotal() {
      // given
      givenTransactionInProgress()
      let expected = sut.transactionTotal - payment

      // when
      sut.acceptCashPayment(payment)

      // then
      XCTAssertEqual(sut.transactionTotal, expected)
    }

    func testAcceptCashPayment_addsPaymentToAvailableFunds() {
      // given
      givenTransactionInProgress()
      let expected = sut.availableFunds + payment

      // when
      sut.acceptCashPayment(payment)

      // then
      XCTAssertEqual(sut.availableFunds, expected)
    }

    func givenTransactionInProgress() {
      sut.addItem(50)
      sut.addItem(100)
    }
}

CashRegisterTests.defaultTestSuite.run()
