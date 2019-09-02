## Web3j

### 常用工具

1. eth wei 相互转换

```Java
// eth to wei
BigInteger ethToWeivalue = Convert.toWei("1", Unit.ETHER).toBigInteger();
// wei to eth
BigInteger weiToEthValue = Convert.fromWei("1000000000000000000", Unit.ETHER).toBigInteger();
```

### 发送交易

1. 在线, 常规

```Java
// 1. 连接
Admin web3j = Admin.build(new HttpService("http://127.0.0.1:6600"));
// 2. 解锁账户
PersonalUnlockAccount unlockAccount = web3j.personalUnlockAccount(accountFrom, "123456").sendAsync().get();
// 3. 判断解锁成功后构建交易并发送
if (unlockAccount.accountUnlocked()) {
    Transaction transaction = Transaction.createEtherTransaction(accountFrom, nonce,
            gasPrice, gasLimit, accountTo, value);
    String result = web3j.ethSendTransaction(transaction).send().getTransactionHash();
    System.out.println(result);
}
```

2. 利用离线签名

```Java
// 1. 连接
Admin web3j = Admin.build(new HttpService("http://127.0.0.1:6600"));
// 2. 离线签名transaction
RawTransaction rawTransaction = RawTransaction.createEtherTransaction(nonce, gasPrice,
        gasLimit, accountTo, value);
Credentials credentials = WalletUtils.loadCredentials("123456", new File("path_to_keystore_file"));
byte[] signedMessage = TransactionEncoder.signMessage(rawTransaction, credentials);
String hexValue = Numeric.toHexString(signedMessage);
// 3. 发送交易(在线)
String result =
        web3j.ethSendRawTransaction(hexValue).sendAsync().get().getTransactionHash();
System.out.println(result);
```

3. 只是转账

```Java
// 1. 连接
Admin web3j = Admin.build(new HttpService("http://127.0.0.1:6600"));
// 2. 导入Credentials
Credentials credentials = WalletUtils.loadCredentials("123456", new File("path_to_keystore_file"));
// 3. 发送交易
String result = Transfer.sendFunds(web3j, credentials, accountTo,
        BigDecimal.valueOf(100.0), Convert.Unit.ETHER).send().getTransactionHash();
System.out.println(result);
```
