# Optimizer utility

An additional utility for WALLETD RPC wallet, called optimizer is included on the "CROAT Node". 
It allows an easy way to automate the execution of wallet outputs optimization, controlling the maximum duration it is allowed to run, 
the interval between interactions so the local mempool does not get flooded, and some other handy command line options. 
It is possible to run the optimizer on a preview mode, where no actual action is taken, but it can be verified the number of wallets that are eligible to be optimized.

The interval is a pause between each interaction, where an interaction is the creation of a fusion transaction for a wallet on the list.

The duration is the maximum time allowed to the tool remains running. 
The process is stopped after the limit is reached. This is useful to automate the process, making sure it does not extrapolate a maintenance window.

## Motivation

Cryptonote use the concept of transaction inputs and transaction outputs to create a transfer of coins from one wallet to another. 
This often leads to a problem where the transaction being built becomes too large and is rejected by the network. 
There is another factor that contributes to an even bigger transaction, namely mixin. 
The common workaround is to break the transfer into smaller ones.

There is a special kind of transaction, called fusion transaction, that can be used to optimize these entries into fewer outputs with larger amounts and prevent the problem. 
What is being commonly called wallet optimization is a process of changing the small value outputs for higher value ones.

The RPC wallet API, walletd, has an endpoint to create such fusion transactions - sendFusionTransaction.

The optimizer utility allows to automate and simplify this process.

### A few recommendations, although not mandatory:

The fusion transaction will appear on the customer's transaction history as a zero amount transaction. 
To avoid questioning, it may be useful to make a small change on frontend code to hide these transactions.
It is probably a good idea to create periodic maintenance windows, once a week for example, where the wallets operations are brought offline for customers, and run the optimizer inside these windows. 
As any other regular transactions, the coins used stays locked until get into a block, so customer can face a race condition where he will fail to create a transfer attempted on a time frame close to the fusion transaction creation for his account.

## This Script

We have prepared this script to facilitate the work of optimising the wallet. 
If you wish you can directly run the "optimizer" command included in "CROAT Node" instead of this script. 

## How to run this script:

```
1) Download CROAT-Optimizer.sh and save to the same folder on you have "optimizer" executable from CROAT Node. 
2) chmod +x CROAT-Optimizer.sh 
3) Run the CROAT-Optimizer.sh script and select what you want. 
```

## Options:

```
1) Preview Optimization:
    Perfom an a preview of optimization results. 
2) Optimize Wallet:
    Run an a WalletD Optimization.
    This options allow you to specify some values:
    * CROAT walletd RPC Port (Default: 46349)
    * Interval between fusion transactions (Default 5)
    * Max optimization duration (Default 120)
    * Transactions anonymity (Default: 1)
    * Optimization amount: (Default: 10000 CROAT)

3) Exit
```

**By default this script is repeated every 60 seconds at the end of a round of all optimisable wallets in the container, so you can run it and leave it running for a while.**


**_:: CROAT.community Dev Team ::_**

